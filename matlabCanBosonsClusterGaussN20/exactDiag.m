n=12; %system size
k=6; %occupation number
m = nchoosek(k+n-1,n-1); % this will be the dim of hilbert space
dividers = [zeros(m,1),nchoosek((1:(k+n-1))',n-1),ones(m,1)*(k+n)]; 
occs = diff(dividers,1,2)-1; % all paritions

sqrprimetag= sqrt(primes(n^2));
sqrprimetag = sqrprimetag(1:n);
tags= occs*sqrprimetag';

%%
phi=0.2*pi;
ens=1;
seed=9;
rng(seed);
filestrEig = append('canbosParisiN', num2str(n), 'K', num2str(k),'Phi0p2PiEigsSeed', num2str(seed),'.txt');
filestrEigSpacRatio =  append('canbosParisiN', num2str(n), 'K', num2str(k),'Phi0p2PiSpacRaSeed', num2str(seed),'.txt');
fileEigID = fopen(filestrEig,'w');
fileSpacRatioID = fopen(filestrEigSpacRatio,'w');
%%

for w = 1:ens
flux= ranPhasesDiscrete(n, phi);
hami = sparse(m,m);
for i = 1:n-1
    toper = sparse(m,m);%will become T^+_i * T^-_{i+1}
   for j = 1: m
      u=j; 
       if  occs(u,i+1) ==0
           continue
       end
      tranformedOcc= occs(u,:);
      tranformedOcc(i+1) = tranformedOcc(i+1)-1;
      tranformedOcc(i) = tranformedOcc(i) +1;
             magnitude =  sqrt(occs(u,i+1)) * sqrt(occs(u,i) + 1);
  
          phase = exp(1j/2 * flux(i+1,i)) * exp(1j/2 * flux(i,i+1) *(tranformedOcc(i+1)-tranformedOcc(i)));
          for kk=1:i-1
              phase = phase * exp(1j/2 * (flux(i,kk)-flux(i+1,kk))* tranformedOcc(kk));
          end
            for kk=i+2:n
              phase = phase * exp(1j/2 * (flux(i,kk)-flux(i+1,kk))* tranformedOcc(kk));
          end
      vtag = tranformedOcc*sqrprimetag';
      v= find(abs(tags - vtag)<0.0001);

      toper(v,u) = magnitude * phase;
   end
      hami = hami + toper;
end
hami = (hami +ctranspose(hami))/sqrt(2*n);

lowspec = eigs(hami,100);
lowspec = lowspec(lowspec<0);
lowspec = sort(lowspec);
lowspacings = diff(lowspec);
lowspacRatio = [];
for i =1: length(lowspacings) - 1
    lowspacRatio = [lowspacRatio min(lowspacings(i),lowspacings(i+1))/max(lowspacings(i),lowspacings(i+1))];
end

fprintf(fileEigID,'%.10f\n', lowspec);
fprintf(fileSpacRatioID,'%.10f\n', lowspacRatio);
end
fclose(fileEigID);
fclose(fileSpacRatioID);


min(lowspec)