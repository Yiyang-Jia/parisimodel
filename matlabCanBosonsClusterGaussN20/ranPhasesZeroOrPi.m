function y = ranPhasesZeroOrPi(d, q)
sp = zeros(d,d);
 
for k =1:d-1
    for l = k+1:d
         if rand() < (1+q)/2
         sp(k,l) =0;
         else 
         sp(k,l) =pi;
         end
         sp(l,k) = -sp(k,l); 
     end
end
y = sp;
end