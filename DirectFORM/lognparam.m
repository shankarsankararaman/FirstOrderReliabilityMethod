function param = lognparam(m)
%LOGNPARAM Summary of this function goes here
%The inputs to this function are the first and second moments
%The output is the two parameters, lambda and psi of the LogNormal Dist. 
%   Detailed explanation goes here

mu=m(1);
sig=sqrt(m(2));
psi=sqrt(log(1+(sig/mu)*(sig/mu)));
             
param(1)=log(mu)-0.5*psi*psi;
param(2)=psi;
param(3)=0;
param(4)=0;
