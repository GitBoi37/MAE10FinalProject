%parameters:
%Open = Open data for range
%Close = Close data for range
%Date = Date data for range
%initialAccBalance = initial money in account in dollars
%pS = percent to sell 
%pB = percent to buy
%shareMoney = dollar amount of shares to start with
%return profit as 1 x 2 array p(1) = profit of trading 
%p(2) = profit of holding
function profit = backTestMABasic(Open, Close, initialAccBalance, shareMoney, pS, pB)
    %% initialize variables
    %initialAccBalance keeps track of initial money in account
    bal = initialAccBalance; %used to track free money in account in dollars
    initShares = round(shareMoney / Open(1)); %keeps track of initial shares in account
    shares = initShares;
    x = binaryRecommendation(Open,Close);
    %% run simulation, start at day 200 since thats what the moving average starts at
    for i  = 200:size(Close,1)
        if(isnan(Open(i)))
            continue
        end
        if(x(i) == 0 && x(i-1) == 1)
            %sell
            %bal  = current balance + the price of stock * the rounded whole
            %number of shares to sell (a percentage of the current number of
            %shares)
            bal = bal + Open(i) * round(shares * (pS / 100)); 
            shares = shares - round(shares * (pS / 100));
        elseif(x(i) == 1 && x(i-1) == 0)
            %buy
            bal = bal - round(bal * (pB / 100)); 
            shares = shares + round(bal * (pB / 100)/ Open(i));
        end
    end
    %calculate profit of bot trading
    profitActive = bal + shares * Open(size(Open,1)) - initialAccBalance - initShares * Open(1);
    %calculate profit of buying once at the beginning and holding until today
    profitPassive = initShares * Open(size(Open,1)) - initialAccBalance - initShares * Open(1);
    profit = [profitActive profitPassive];
end

