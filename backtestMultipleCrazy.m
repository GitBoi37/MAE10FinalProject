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
function profit = backTestMABasic(Open, Close, Date, initialAccBalance, shareMoney, pS, pB)
    %% initialize variables
    %initialAccBalance keeps track of initial money in account
    bal = initialAccBalance; %used to track free money in account in dollars
    dailyShares = zeros(size(Close,1),1); %7130x1 array of held shares over range
    initShares = round(shareMoney / Open(1)); %keeps track of initial shares in account
    shares = initShares; %50 thousnad dollars at the opening price of AAPL stock in shares, rounded to exclude fractional shares
    dailyBal = bal * ones(7130,1); %7130x1 array of portfolio balance over range
    %control balance, initialize to same as dailybal
    control = dailyBal;  %7130x1 array will track the value of held stock (not sold) over range

    %buy sell array, keeps track of actions
    bs = zeros(7130,1); %1 is sell, 0 is hold (default), -1 is buy for some reason
    %TPV = total portfolio value, initialize to the value of portfolio at day one
    %TPV = sum of market day value of balance in dollars and stock in dollars
    TPV = (bal + shares * Open(1))*ones(size(Close,1),1);

    x = binaryRecommendation(Open,Close);
    %% run simulation, start at day 200 since thats what the moving average starts at
    for i  = 200:size(Close,1)
        if(x(i) == 0 && x(i-1) == 1)
            %sell
            %bal  = current balance + the price of stock * the rounded whole
            %number of shares to sell (a percentage of the current number of
            %shares)
            bal = bal + Open(i) * round(shares * (pS / 100)); 
            shares = shares - round(shares * (pS / 100));
            bs(i) = 0
        elseif(x(i) == 1 && x(i-1) == 0)
            %buy
            bs(i)= -1;
            bal = bal - round(bal * (pB / 100)); 
            shares = shares + round(bal * (pB / 100)/ Open(i));
        end
        dailyBal(i) = bal;
        dailyShares(i) = shares;
        control(i) = initShares * Open(i);
        TPV(i) = bal + shares * Open(i);
    end
    %calculate profit of bot trading
    profitActive = bal + shares * Open(7130) - initialAccBalance - initShares * Open(1);
    %calculate profit of buying once at the beginning and holding until today
    profitPassive = initShares * (Open(7130)) - initialAccBalance - initShares * Open(1);
    profit = [profitActive profitPassive];
end

