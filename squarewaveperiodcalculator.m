loadspice("worstcaseanalysis.txt");

if exist("n002", "var")
    vout = n002;
end

close all
plot(time{1}, vout{1},  "-")
title("Parameter Sweep of Time (s) vs. Vout (V)")
xlabel("Time (s)")
ylabel("Vout (V)")
ylim([-0.1, 3.4])

hold on
for i = 2:size(time, 2)
    plot(time{i}, vout{i}, "-")
end
hold off

periods = zeros(size(vout));

for j = 1:size(vout, 2)

    sampledata = vout{j};
    sampletime = time{j};

    periodstart = false;

    for i = 1:size(sampledata, 2) - 1
        if sampledata(i) > 3 && sampledata(i + 1) < 3
            if periodstart == false
                periodstartindex = i;
                periodstart = true;
            else
                periodendindex = i;
                break
            end
        end
    end

    periods(j) = sampletime(1, periodendindex) - sampletime(1, periodstartindex);
end

figure
plot(periods, ".", markersize=15)
title("Worst Case Analysis of Oscillator Period")
xlabel("Trial Number")
ylabel("Period (s)")
hold on
yline(1.1, "r--")
yline(0.9, "magenta--")
ylim([0.85, 1.15])
legend(["Period", "Upper Error Limit", "Lower Error Limit"], "Location", "southeast")
hold off

