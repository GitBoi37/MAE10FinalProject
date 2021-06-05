function x = binaryRecommendation(Open, Close)
    a = movingAverage200(Close, Open);
    x = zeros(size(Close,1),1);
    for i = 1:size(Close,1)
        x(i) = buySellDay(Open,Close, i, a);
    end
end