function M1 = zeros2inf(M)
size = length(M);
M1 = zeros(22);

for i=1:size
   for j=1:size
       if(M(i,j) == 0)
          M1(i,j) = Inf;
       else
           M1(i,j) = M(i,j);
       end
   end
end


end