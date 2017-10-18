%input to solve the problem of estimating cdf of Y

% Y = G(x)
% input distributions of x are known

% scope : x can be normal/uniform/lognormal/johnson

Ninputs=input(sprintf('How Many Inputs The Model Has ? '));

s=sprintf('Input PDF of Prior\nPress 1 for Normal Distribution\nPress 2 for Uniform Distribution\nPress 3 for Log Normal Distribution\nPress 4 for Johnson Distribution\n\n');
tempstr=('Input Can Be Either 1 Or 2 Or 3');


%Get Priors for each of the input.

for i=1:Ninputs

    clc
    disp(sprintf('Distribution Number No. %d',i));



    k=0; %This variable is for user input validation, so as to reject the input if its anything other than 1,2,3,4

    while k==0


        pdftype(i)=input(s);


        switch pdftype(i)

            case 1 %normal

                k=1; %user input validation variable


                %obtain two central moments
                for j=1:2

                    CM(i,j)=input(sprintf('Enter Moment Number %d : ',j));

                end

                inputdistparam(i,:)=normparam(CM(i,:));
                inputpdfstr(i,:)='norm';
                inputdistmean(i)=CM(i,1);
                
                
            case 2 %uniform

                k=1;

                %obtain two central moments
                for j=1:2

                    CM(i,j)=input(sprintf('Enter Moment Number %d : ',j));

                end

                inputdistparam(i,:)=unifparam(CM(i,:));
                inputpdfstr(i,:)='unif';
                inputdistmean(i)=CM(i,1);
                
      

            case 3 %log normal

                k=1;

                %obtain two central moments
                for j=1:2

                    CM(i,j)=input(sprintf('Enter Moment Number %d : ',j));

                end

                inputdistparam(i,:)=lognparam(CM(i,:));
                inputpdfstr(i,:)='logn';
                inputdistmean(i)=CM(i,1);                
                

            case 4 %johnson

                k=1;

                %obtain four central moments
                for j=1:4

                    CM(i,j)=input(sprintf('Enter Moment Number %d : ',j));

                end

                inputdistparam(i,:)=johnparam(CM(i,:));
                inputpdfstr(i,:)='john';
                inputdistmean(i)=CM(i,1);                
                
            otherwise %the user has not provided correct input!
                
                %prompt again

                k=0;
                clc
                disp(tempstr);
                disp(sprintf('\nDistribution Number No. %d',i));

        end
        
        %end of switch case


    end
    %The input for one distribution is complete.

end

%input for all distributions complete
%these are saved in a file called "pdfdetails"
save distributionparameters inputpdfstr inputdistmean inputdistparam


%please type FORM([arg]) in command window to estimate the cdf
%or just add an iterative FORM call to estimate the cdf
