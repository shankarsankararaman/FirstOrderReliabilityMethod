function [uspacevar,eqnormalmean,eqnormalsigma]=transformintostdnormalspace(Xspace,inputs)

%input --> a set of instances of X



% return three quantities
% 1. New uspace variable values
% 2. Equivalent normal mean-s
% 3. Equivalent normal sigma-s

for i=1:length(Xspace)
    
    
    if inputs.inputpdfstr(i)=='john'
        
        pdfvalue=johnsonpdf(Xspace(i),inputs.inputdistparam(i,:));
        cdfvalue=johnsoncdf(Xspace(i),inputs.distparam(i,:));
    
    else
        
        pdfvalue=pdf(inputs.inputpdfstr(i,:),Xspace(i),inputs.inputdistparam(i,1),inputs.inputdistparam(i,2));
        cdfvalue=cdf(inputs.inputpdfstr(i,:),Xspace(i),inputs.inputdistparam(i,1),inputs.inputdistparam(i,2));
        
    end
    
    

    
    % find out equivalent normal mean and sig
    
    %please see textbooks for these transformations
    eqnormalsigma(i)=1/pdfvalue*(normpdf((norminv(cdfvalue,0,1)),0,1));
    
    %eqnormalmean= normal PDF inverse of pdfvalue*eqnormalsigma
    
    temp=pdfvalue*eqnormalsigma(i);
    
    
    
    eqnormalmean(i)=Xspace(i)-(norminv(cdfvalue,0,1)*eqnormalsigma(i));
    
    uspacevar(i)= (Xspace(i)-eqnormalmean(i))/eqnormalsigma(i);
    
end

