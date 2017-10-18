function cdfvalue = johnsoncdf(x,theta)

%this can be obtained as a function of standard normal cdf
%unbounded johnson distribution

delta=theta(1);
lambda=theta(2);
gamma=theta(3);
xi=theta(4);

%take STD normal of this number
cdfvalue=cdf('norm',gamma+delta*asinh((x-xi)/lambda),0,1);





