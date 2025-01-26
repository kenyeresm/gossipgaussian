Kl = [];
PS = [];
x_vys = [];
error = [];
W_gp = zeros(size(A,1),size(A,1));
%dame same jednicky na diagonalu
for i = 1:size(A,1)
    W_gp(i,i) = 1; 
end

for q = 1:1:100
    %if mod(q,100)==0
       %q 
    %end
    x = INI(1:size(A,1));
    k = 0;
    %d = 0.01;%0.0001;


    while abs(max(x(:,k+1))-min(x(:,k+1)))>P
          %nahodne vyber vysielajuci uzol
          nahoda1 = datasample([1:size(A,1)],1);
          %teraz vyber suseda aby si mal par
          nahoda2 = datasample(find(A(nahoda1,:)==1),1);
          %upravim W maticu
          W = W_gp;
          W(nahoda1,nahoda2) = 1/2;
          W(nahoda2,nahoda1) = 1/2;
          W(nahoda1,nahoda1) = 1/2;
          W(nahoda2,nahoda2) = 1/2;
          %teraz si vymenia spravy
          x(:,k+2)= W*x(:,k+1);
          k=k+1;
    end
    Kl = [Kl k]; 
    PS = [PS 2*k];
    x_vys = [x_vys x(:,end)];
    error = [error mse(x(:,end), zeros(size(A,1),1))];
end

