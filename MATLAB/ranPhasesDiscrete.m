function y = ranPhasesDiscrete(d, phi)%Dirac matrices in Weyl basis
sp = zeros(d,d);
for k =1:d-1
    for l = k+1:d
         sp(k,l) =2*randi([0,1])-1;
         sp(l,k) = -sp(k,l); 
     end
end
y = phi*sp;
end