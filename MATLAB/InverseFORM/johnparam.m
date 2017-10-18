function param = johnparam(m)
%This is an external call to solve an unbounded Johnson distribution
%parameter estimation problem with interval data. 
%The arguments of this function are
%m   list of data of moments of interval data sets

%Program returns the value for johnson distrubution parameters, 'param'

% Start with the default options
options = optimset;
% Modify options setting
options = optimset(options,'Display' ,'off');
options = optimset(options,'MaxFunEvals' ,1000);
options = optimset(options,'LargeScale' ,'on');

x0=[5 10 15 20];
% Call to zero finding routine
param = fsolve(@johnsonresid, x0, options);   


%function to be used in fsolve:
   function r = johnsonresid(params)
   %This function calculates the error in moments of the unbounded  
   %Johnson distribution. It calculates the first four moments of the original
   %data, calculates the first four moments of an unbounded Johnson distribution 
   %with the specified vector of parameters, and calculates the difference 
   %in each of the first four moments.
   %
   %The arguments of the function are
   % 
   %params   vector of Johnson distribution parameters, where
   %params(1) = delta
   %params(2) = lambda
   %params(3) = gamma
   %params(4) = xi
    
          
     %Calculate moments of Johnson Distribution with specified parameters
     
     %set up transform from a standard random variable z to the Johnson 
     %distributed variable Y
        p = [0.01 : 0.01 : 0.99];
        Z = norminv(p,0,1);
        for i = 1:length(Z);
             Y(i)= params(4)+ params(2)*((exp((Z(i)-params(3))/params(1))-exp(-((Z(i)-params(3))/params(1)))))/2;
        end
        
     %calculate moments of Johnson distribution
        j = [0 0 0 0]';
        j(1)=mean(Y);
        j(2)=moment(Y,2);
        j(3)=moment(Y,3);
        j(4)=moment(Y,4);
     %calculate the residuals   
     for i=1:4
        r(i) = m(i)-j(i);
        
end
    end
end


