function m = movingAverage200(Close, Open)
    a = zeros(size(Close,1), 1);
    average = avg(Close, Open);
    a(1:200) = average(1:200);
    %
    for i = 201:size(Close,1)
        a(i) = mean(average(i-200:i));
    end
    m = a;
end