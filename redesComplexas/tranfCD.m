function CDzeros = tranfCD(CDe)
CDzeros = zeros(length(CDe),5);

for x=1:5
    for y=1:length(CDe)
       if isnan(CDe(y,x)) || isinf(CDe(y,x))
           CDzeros(y,x) = 0;
       else
           CDzeros(y,x) = CDe(y,x);
       end
    end   
end

end