n=20; %system size
k=6; %occupation number
m = nchoosek(k+n-1,n-1); % this will be the dim of hilbert space
dividers = [zeros(m,1),nchoosek((1:(k+n-1))',n-1),ones(m,1)*(k+n)]; 
occs = diff(dividers,1,2)-1; % all paritions

sqrprimetag= sqrt(primes(n^2));
sqrprimetag = sqrprimetag(1:n);
tags= occs*sqrprimetag';


%%
phi=0.2*pi;
ens=100;
seed=17;
rng(seed);
filestrEig = append('canbosParisiN', num2str(n), 'K', num2str(k),'uniformPhi0p2PiJdisorderEigsSeed', num2str(seed),'.txt');
filestrEigSpacRatio =  append('canbosParisiN', num2str(n), 'K', num2str(k),'uniformPhi0p2PiJdisorderSpacRaSeed', num2str(seed),'.txt');
fileEigID = fopen(filestrEig,'w');
fileSpacRatioID = fopen(filestrEigSpacRatio,'w');
%%
tagerr = 10^(-10);%tolerence must be small enough to find the correct tags
for w = 1:ens
 flux= ranPhases(n, phi);
%flux= ranPhases(n, phi);
hami = sparse(m,m);
for i = 1:n-1
  for l= i+1 : n
    toper = sparse(m,m);%will become T^+_i * T^-_{l}
      for j = 1: m
         u=j; 
         if  occs(u,l)> 0
    
          tranformedOcc= occs(u,:);
          tranformedOcc(l) = tranformedOcc(l)-1;
          tranformedOcc(i) = tranformedOcc(i) +1;
           magnitude =  sqrt(occs(u,l)) * sqrt(occs(u,i) + 1);
  
          phase = exp(1j/2 * flux(l,i)) * exp(1j/2 * flux(i,l) *(tranformedOcc(l)+ tranformedOcc(i)));
             for kk=1:n 
                 if (kk ~= i) && (kk ~= l)
                phase = phase * exp(1j/2 * (flux(i,kk)-flux(l,kk))* tranformedOcc(kk));
                 end
             end
     
           vtag = tranformedOcc*sqrprimetag';
           v= find(abs(tags - vtag)<tagerr);
           toper(v,u) = magnitude * phase;
        end
      end
      hami = hami + randn* toper;
  end
end
hami = (hami +ctranspose(hami))/sqrt(n*(n-1));

%%
% ev = eig(full(hami));
% hist(ev)
%%
lowspec = eigs(hami,300);
lowspec = sort(lowspec);
lowspec = lowspec(1:100);
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


