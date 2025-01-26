Kl = [];
PS = [];
x_vys = [];
error = [];


for q = 1:1:100
    %if mod(q,100)==0
       %q 
    %end
    x = INI(1:size(A,1));%(1:1:size(A,1))';
    k = 0;
     
    while abs(max(x(:))-min(x(:)))>P
          %kazdy uzol vyberie niekoho so svojich susedov
          for i=1:1:size(A,1) 
              %kazdy uzol nahodne vyberie suseda a vymeni si s nim spravy - hned si tie spravy updatuju este v ramci iteracie 
              nahoda = datasample(find(A(i,:)==1),1);
              hodnota_i = x(i);
              hodnota_suseda = x(nahoda);
              x(i) = (hodnota_i + hodnota_suseda)/2;
              x(nahoda) = (hodnota_i + hodnota_suseda)/2;
          end
                   
          k=k+1;          
    end
    
    Kl = [Kl k];
    PS = [PS 2*size(A,1)*k];
    x_vys = [x_vys x(:)];
    error = [error mse(x(:,end), zeros(size(A,1),1))];
end
