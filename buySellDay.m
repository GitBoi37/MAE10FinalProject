function d = buySellDay(Open, Close, Index, a)
   
   if(Open(Index) < a(Index))
       %sell
       d = 0;
   else 
       %buy
       d = 1;
   end
end
