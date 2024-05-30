function y = ranPhases(d, phi)
sp = zeros(d,d);
for k =1:d-1
    for l = k+1:d
         sp(k,l) = 2*rand()-1;
         sp(l,k) = -sp(k,l); 
     end
end
y = phi*sp;
end