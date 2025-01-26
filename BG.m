Kl = [];
PS = [];
x_vys = [];
%PSI = 0.1;
error = [];

for q = 1:1:100
    %if mod(q,100)==0
       %q 
    %end
    x = INI(1:size(A,1));
    k = 0;

    while abs(max(x(:,k+1))-min(x(:,k+1)))>P
          %nahodne vyber vysielajuci uzol
          nahoda1 = datasample([1:size(A,1)],1);
          %susedia si updatuju
          for i = 1:size(A,1)
              if A(i,nahoda1)==1
                 x(i,k+2) = PSI*x(i,k+1) + (1-PSI)*x(nahoda1,k+1); 
              end
              if A(i,nahoda1)==0
                 x(i,k+2) = x(i,k+1); 
              end    
          end
          k=k+1;
          
    end
    
    Kl = [Kl k];
    PS = [PS k];
    x_vys = [x_vys x(:,end)];
    error = [error mse(x(:,end), zeros(size(A,1),1))];
end

