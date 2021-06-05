
function a = avg(Close, Open)
    avg = zeros(7130,1);

    for i = 1:size(Close,1)
        avg(i) = (Close(i) + Open(i))/2;
    end
    a = avg;
end