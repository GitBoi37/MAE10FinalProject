clc;
%index = 200
%disp(buySellDay(Open, Close, index))
a = movingAverage200(Close, Open);
x = zeros(7130,1);
for i = 1:7130
    x(i) = buySellDay(Open,Close, i, a);
end
%backtest strategy
accBal = 50000; percBuySell = 25;
backTestMAFixedPercent(accBal, percBuySell, x, Open, Date);

%display recommendations for a range of days
%displayRec(x, 10:20, Open, a);

%function that simulates buying and selling of apple stock
%parameters: 
%inital account balance (dollars)
%percentage of remaining account balance willing to sell or buy
%x = array of buy sell recommendations
%buys and sells on the open of that day
function backTestMAFixedPercent(initialAccBalance, percentBuySell, x, Open, Date)
    
end

function profit = backTestMAVariablePercent(initialAccBalance, a)

end

function displayRec(x, range, Open, a)
    for i = range;
        if(x(i) == 0)
            %disp sell
            fprintf('Open, Avg, Rec: %.2f, %.2f, %s \n', Open(i), a(i), "Sell")
        else
            %disp buy
            fprintf('Open, Avg, Rec: %.2f, %.2f, %s \n', Open(i), a(i), "Buy")
        end
    end
end

function d = buySell(Open, Close)
   a = movingAverage200(Close, Open);
   if(Open(size(Open,1)) < a(size(Open,1)))
       d = 'Sell';
   else 
       d = 'Buy';
   end
end


