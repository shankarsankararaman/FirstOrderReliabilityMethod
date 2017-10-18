function param = normparam( m )
%NORMALPARAM Summary of this function goes here
%The inputs to this function are the first and second central moments
%The function returns the two parameters of a normal distribution


param(1)=m(1);
param(2)=sqrt(m(2));
param(3)=0;
param(4)=0;