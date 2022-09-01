dmax=100;
%q = sin(phi)/(phi);
%flux = ranPhases(dmax,phi);
rais = (pauli(1) + 1i*pauli(2))/2;
%fileID = fopen('parisiLowestEigs0p05PidStartsAt14.txt','w');
%fileID2 = fopen('parisiOnlyLowestEigs0p1PidStartsAt24.txt','w');
%fileID3 = fopen('parisiLowestEigs0p3PidStartsAt14.txt','w');

phi = 0.4 * pi;
fileID4 = fopen('parisiDiscreteFluxLowestEigs0p4Pi27seed129another.txt','w');
%fidrel = fopen('relcount.txt','w');
rng(129);
for rel =1:1
    flux = ranPhasesDiscrete(dmax,phi);
for d =27:27
%emax = sqrt(4*d/(1-q));
%qRen = q -i(q+1)/d;
%emaxRen=sqrt(4*d/(1-qRen));
zerofluxGround = [1;1];
hamiP = sparse(zeros(2,2));
for k=2:d
    hamiP = sparse(kron(hamiP,zeros(2,2)));
        zerofluxGround = kron(zerofluxGround,[1;1]);
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

ev= eigs(hami,4,'largestabs','StartVector',zerofluxGround);
%ev=ev(ev>0)

%tic
%[vec,lambda]=lobpcg(rand(2^d,2),hami);
%lambda

%fprintf(fileID,'%.10f\n', ev);
%fprintf(fileID2,'%.10f\n', ev);
%fprintf(fileID3,'%.10f\n', ev);
fprintf(fileID4,'%.10f\n', ev);
%d
end
%fprintf(fidrel,rel);
end
%fclose(fileID);
%fclose(fileID2);
%fclose(fileID3);
fclose(fileID4);
%fclose(fidrel);
