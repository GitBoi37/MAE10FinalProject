function m = plotMovingAverageRange200(Close, Open, Date, r)
    a = zeros(7130, 1);
    average = avg(Close, Open);
    a(1:200) = average(1:200);
    %take last 2 hundred data points (days) and take average and put that
    %in index
    for i = 201:size(Close,1)
        a(i) = mean(average(i-200:i));
    end
    m = a;
    plot(Date(r), m(r), Date(r), Open(r));
end