function finalbeta = FORM(y)

% generalized FORM code to generate cdf value at "y"
% Y = G(X)
% the Distribution details are stored in a file called distributionparameters.mat
% variable "inputdistparam" contains the distribution parameters
% variable "inputpdfstr" contains the distribution name
% variable "inputdistmean" contains the distribution name
% variable 

%the initial guess is the mean value

load distributionparameters

% variable "inputdistparam" contains the distribution parameters
% variable "inputpdfstr" contains the distribution name
% variable "inputdistmean" contains the distribution name

%Please note that the variable "inputdistparam" by default contains 4
%parameters.
%If the distribution has only 2 parameters, the last two are zero


initguess=inputdistmean;
finalbeta=-1;
initbeta=0;
Gvalue=1;

final=initguess; %initial for this loop

while abs(initbeta-finalbeta) > 0.0001 && abs(Gvalue) > 0.0001

    initial=final;
    initbeta=finalbeta;

    Gvalue=Gfunction(initial)-y;

    %transformation into normal space
    [uspacevar,mu,sigma]=transformintostdnormalspace(initial);

    %calulate derivatives at initial
    for i=1:length(inputdistmean)

        %find the partial derivative of ith variable


        temp1=initial(i);
        delta=initial(i)*0.0001;
        temp2=temp1+delta;

        argofGfunction=initial;

        argincremented=initial;
        argincremented(i)=temp2;




        alphaXspace(i)=(Gfunction(argincremented)-Gfunction(argofGfunction))/delta;
    end

    alphauspace=alphaXspace.*sigma;




    finaluspace=((alphauspace*uspacevar')-Gvalue)*(alphauspace)/(alphauspace*alphauspace');

    final=(finaluspace.*sigma)+mu;

    finalbeta=-alphauspace*finaluspace'/(sqrt(alphauspace*alphauspace'));

end


