%% Import data from text file

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 7);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Date", "Open", "High", "Low", "Close", "AdjClose", "Volume"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Date", "InputFormat", "yyyy-MM-dd");

% Import the data
tbl = readtable("C:\Users\lance\OneDrive\Documents\MATLAB\Examples\R2020b\matlab\Final Project\SPY.csv", opts);

%% Convert to output type
Date = tbl.Date;
Open = tbl.Open;
High = tbl.High;
Low = tbl.Low;
Close = tbl.Close;
AdjClose = tbl.AdjClose;
Volume = tbl.Volume;

%% Clear temporary variables
clear opts tbl
fig1 = figure;
plotRange(7105:7130, Close, Open, Date, High, Low)
plotLastDays(100, Close, Open, Date, High, Low)
fig2 = figure;
%plot graphs in a 2x2 configuration
%plot the change between the open and close
subplot(2,2,1); plotChangeOpenClose(1:size(Close,1),Close, Open, Date)
%plot the change between the high and low
subplot(2,2,2); plotChangeHighLow(size(Close,1)-50:size(Close,1),Close, Open, Date)
%plot the price of the stock between 1:number, number being the day since
%the start of the data
subplot(2,2,3); plotRange(1:size(Close,1), Close, Open, Date, High, Low)
%plots moving average overlayed on price of stock
subplot(2,2,4);plotMovingAverage(Date, movingAverage200(Close,Open), Open);

%plot the moving average and price of stock on the same graph 
function plotMovingAverage(Date, MA, Open)
    plot(Date, MA, Date, Open);
    title('Price and Moving Average');
    xlabel('Date');
    ylabel('Price of stock');
    legend('Moving Average ($)', 'Price at Open ($)');
end

%plots a graph of the change between the open and close vs time
function plotChangeOpenClose(range, Close, Open, Date)
    c = changeOpenClose(Close, Open);
    plot(Date(range), c(range));
    title('Change Open Close $')
    xlabel('Date')
    ylabel('Change $')
end

%plots a graph of the change between the high and low vs time
function plotChangeHighLow(range, Close, Open, Date)
    c = changeHighLow(Close, Open);
    plot(Date(range), c(range));
    title('Change High Low $')
    xlabel('Date')
    ylabel('Change $')
end

%plots 'days' days from the last data point
function plotLastDays(days, Close, Open, Date, High, Low)
    range = (size(Close,1) - days: size(Close,1))
    plotRange(range, Close, Open, Date, High, Low)
    title('Change High Low $')
    xlabel('Date')
    ylabel('Change $')
end

%plots in a range of data points specified by range
function plotRange(range, Close, Open, Date, High, Low)
    a = avg(Close, Open);
    plot(Date(range), a(range), Date(range), High(range), Date(range), Low(range));
    title('Price of Stock in Dollars')
    xlabel('Date')
    ylabel('Price, High, Low, Range')
    legend('Average of High and Low', 'High', 'Low');
end

%compute the change between the open and close for the whole data set
function c = changeOpenClose(Close, Open)
    change = zeros(7130, 1);
    for i = 1:size(Close,1)
        change(i) = Close(i) - Open(i);
    end
    c = change;
end

%compute the change between the high and low for the whole data set
function x = changeHighLow(High,Low)
    change = zeros(7130, 1);
    for i = 1:size(High,1)
        change(i) = High(i) - Low(i);
    end
    x = change;
end