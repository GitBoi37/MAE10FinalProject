function data = importTicker(ticker)
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
    tbl = readtable(sprintf('C:\\Users\\lance\\OneDrive\\Documents\\MATLAB\\Examples\\R2020b\\matlab\\Final Project\\%s.csv', ticker), opts);

    %% Convert to output type
    Date = tbl.Date;
    Open = tbl.Open;
    High = tbl.High;
    Low = tbl.Low;
    Close = tbl.Close;
    AdjClose = tbl.AdjClose;
    Volume = tbl.Volume;
    % Clear temporary variables
    clear opts tbl
    
    % return data
    data = [datenum(Date), Open, High, Low, Close, AdjClose, Volume];
end