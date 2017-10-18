function param = unifparam(m)
%UNIFPARAM Summary of this function goes here
%The inputs to this function are the first and second moments
%The function returns the two parameters, lower limit and upper limit
%   Detailed explanation goes here


sum=2*m(1);
diff=sqrt(12*m(2));
param(1)=(sum-diff)/2;
param(2)=(sum+diff)/2;
param(3)=0;
param(4)=0;
        
