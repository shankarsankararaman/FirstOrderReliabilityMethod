function [uspacevar,eqnormalmean,eqnormalsigma]=transformintostdnormalspace(Xspace)

%input --> a set of instances of X

load distributionparameters
%load the file containing distribution details

% return three quantities
% 1. New uspace variable values
% 2. Equivalent normal mean-s
% 3. Equivalent normal sigma-s

for i=1:length(Xspace)
    
    
    if inputpdfstr(i)=='john'
        
        pdfvalue=johnsonpdf(Xspace(i),inputdistparam(i,:));
        cdfvalue=johnsoncdf(Xspace(i),inputdistparam(i,:));
    
    else
        
        pdfvalue=pdf(inputpdfstr(i,:),Xspace(i),inputdistparam(i,1),inputdistparam(i,2));
        cdfvalue=cdf(inputpdfstr(i,:),Xspace(i),inputdistparam(i,1),inputdistparam(i,2));
        
    end
    
    

    
    % find out equivalent normal mean and sig
    
    %please see textbooks for these transformations
    eqnormalsigma(i)=1/pdfvalue*(normpdf((norminv(cdfvalue,0,1)),0,1));
    
    %eqnormalmean= normal PDF inverse of pdfvalue*eqnormalsigma
    
    temp=pdfvalue*eqnormalsigma(i);
    
    
    
    eqnormalmean(i)=Xspace(i)-(norminv(cdfvalue,0,1)*eqnormalsigma(i));
    
    uspacevar(i)= (Xspace(i)-eqnormalmean(i))/eqnormalsigma(i);
    
end

