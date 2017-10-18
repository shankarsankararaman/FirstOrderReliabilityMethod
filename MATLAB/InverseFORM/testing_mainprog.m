clc
clear
close all

load distributionparameters.mat

inputs.inputdistparam=inputdistparam;
inputs.inputpdfstr=inputpdfstr;
inputs.inputdistmean=inputdistmean;

%%Monte Carlo Simulation

Nsam=1000;
U=lhsdesign(Nsam,3);
X1=icdf(inputs.inputpdfstr(1,:),U(:,1),inputs.inputdistparam(1,1),inputs.inputdistparam(1,2));
X2=icdf(inputs.inputpdfstr(2,:),U(:,2),inputs.inputdistparam(2,1),inputs.inputdistparam(2,2));
X3=icdf(inputs.inputpdfstr(3,:),U(:,3),inputs.inputdistparam(3,1),inputs.inputdistparam(3,2));
Y=Gfunction([X1 X2 X3]);
[Ycdfy,Ycdfx]=ecdf(Y);


%%Inverse FORM

cdfvalues=[0.01 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.95 0.99];
Yiform=InverseFORM(cdfvalues,inputs);

%%Compare
plot(Ycdfx,Ycdfy)
hold on
plot(Yiform,cdfvalues,'r');