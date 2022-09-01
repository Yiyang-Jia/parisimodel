dmax=100;
%q = sin(phi)/(phi);
%flux = ranPhases(dmax,phi);
rais = (pauli(1) + 1i*pauli(2))/2;
%fileID = fopen('parisiLowestEigs0p05PidStartsAt14.txt','w');
%fileID2 = fopen('parisiOnlyLowestEigs0p1PidStartsAt24.txt','w');
%fileID3 = fopen('parisiLowestEigs0p3PidStartsAt14.txt','w');

phi = 0.26 * pi;
fileID4 = fopen('parisiDiscreteFluxLowestEigs0p26Pi10Realizations.txt','w');

for rel =1:10
    flux = ranPhasesDiscrete(dmax,phi);
for d =14:23
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

ev=eigs(hami,4);
ev=ev(ev>0)



%fprintf(fileID,'%.10f\n', ev);
%fprintf(fileID2,'%.10f\n', ev);
%fprintf(fileID3,'%.10f\n', ev);
fprintf(fileID4,'%.10f\n', ev);
%d
end
rel
end
%fclose(fileID);
%fclose(fileID2);
%fclose(fileID3);
fclose(fileID4);

