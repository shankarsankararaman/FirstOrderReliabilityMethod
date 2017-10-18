% This function estimates the pdf of johnson distribution numerically 
%evaluated at 'x' using parameters 'Theta'

function f=johnsonpdf(x,Theta)

x1=x;
x2=x+1e-6;


%z- Intermediate variable
%Z- Standard normal variable
%x- original space variable

z1=(x1-Theta(4))/Theta(2);
Z1=Theta(3)+Theta(1)*asinh(z1);

z2=(x2-Theta(4))/Theta(2);
Z2=Theta(3)+Theta(1)*asinh(z2);

f= (normcdf(Z2)-normcdf(Z1))/(x2-x1);% pdf of johnson distribution










