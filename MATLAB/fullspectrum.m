dmax=100;
phi = 0.26*pi;
%q = sin(phi)/(phi);
flux = ranPhasesDiscrete(dmax,phi);
rais = (pauli(1) + 1i*pauli(2))/2;
fileID = fopen('parisiDiscreteFluxFullEigs0p26PiOneReld14.txt','w');

for d =14:14
%emax = sqrt(4*d/(1-q));
%qRen = q -(q+1)/d;
%emaxRen=sqrt(4*d/(1-qRen));
hamiP = sparse(zeros(2,2));
for k=2:d
    hamiP = sparse(kron(hamiP,zeros(2,2)));
end
sigList = cell(1,d);
  for m=1:d
      for n =1:d
          sigList{n}  = [exp(1i* flux(m,n)/4),0;0,exp(-1i* flux(m,n)/4)];
      end
      sigList{m} = rais;
      
      gamP = sigList{1};
      for s = 2:d
          gamP = sparse(kron(gamP,sigList{s}));
      end
      hamiP = hamiP + gamP;
  end
  hami  = hamiP + hamiP';

ev=eig(full(hami));

%tic
%[vec,lambda]=lobpcg(rand(2^d,2),hami);
%lambda

%fprintf(fileID,'%.10f\n', ev);
%fprintf(fileID2,'%.10f\n', ev);
%fprintf(fileID3,'%.10f\n', ev);
fprintf(fileID,'%.10f\n', ev);
%d
end

fclose(fileID);


      
