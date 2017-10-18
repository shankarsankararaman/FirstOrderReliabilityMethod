function Y = InverseFORM(cdfvalues,inputs)

% generalized FORM code to generate "y" value corresponding to given "cdf" value
% Y = G(X)
% the Distribution details are stored in a file called distributionparameters.mat
% variable "inputdistparam" contains the distribution parameters
% variable "inputpdfstr" contains the distribution name
% variable "inputdistmean" contains the distribution name variable 

%the initial guess is the mean value


% structure "inputs" contain the following information about inputs
% variable "inputdistparam" contains the distribution parameters
% variable "inputpdfstr" contains the distribution name
% variable "inputdistmean" contains the distribution mean

%Please note that the variable "inputdistparam" by default contains 4
%parameters.
%If the distribution has only 2 parameters, the last two are zero

Xvalue=inputs.inputdistmean;
requiredBeta=-norminv(cdfvalues);
%------------------------------------------------------------------------------------
%%Interation-based Implementation
%This does not guarantee convergence. Generally, if this method works,
%convergence should occur in 5-6 iterations. Else, convergence will not
%occur.
for ijk=1:length(cdfvalues)

    iteration_number=0;

    while iteration_number<5

        iteration_funvalue=Gfunction(Xvalue);
        
        %transformation into normal space
        [uspacevar,eqnormalmean,eqnormalsigma]=transformintostdnormalspace(Xvalue,inputs);

        %derivative in original space
        %calulate derivatives at original space
        for i=1:length(inputs.inputdistmean)
            %find the partial derivative of ith variable
            temp1=Xvalue(i);
            delta=Xvalue(i)*0.0001;
            temp2=temp1+delta;
            argincremented=Xvalue;
            argincremented(i)=temp2;
            alphaXspace(i)=(Gfunction(argincremented)-iteration_funvalue)/delta;
        end

        %calculate derivative in standard normal space
        alphauspace=alphaXspace.*eqnormalsigma;
        %Normalize
        alphauspace=alphauspace/sqrt(alphauspace*alphauspace');

        %Actual Inverse FORM Update --> "-beta" times "alphavector"
        new_uspace=-alphauspace.*requiredBeta(ijk);

        %transfer back to originalspace
        %Below line is to first translate to uniform distribution
        %Xvalue=transformintooriginalspace(new_uspace,inputs);
        Xvalue=eqnormalmean+new_uspace.*eqnormalsigma;

        iteration_number=iteration_number+1;
    end
    
    Y(ijk)=Gfunction(Xvalue);

end


