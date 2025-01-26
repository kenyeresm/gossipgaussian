tic
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
    pocet_sprav = 0;
    %d = 0.0001;

    while abs(max(x(:,k+1))-min(x(:,k+1)))>P
          %nahodne vyber vysielajuci uzol
          nahoda1 = datasample([1:size(A,1)],1);
          %teraz vyber suseda aby si mal par - okrem seba
          OSTATNE = [1:size(A,1)];
          OSTATNE(nahoda1) = [];%vyhodim seba
          %vyberiem prijemcu
          nahoda2 = datasample(OSTATNE,1);
          %urcim pocet hopov kolko je vzdialeny
          cd('C:\SAV\clanok Future internet\djikstra')%zmenim na folder kde je Djikstra
          pocet_hopov = dijkstra(A,nahoda1);%tuto je pocet hopov je vysielatela po primatela
          poslane_spravy = 2*pocet_hopov(nahoda2); %nasobim 2 lebo ideme aj spat
          
          x(:,k+2) = x(:,k+1);
          x(nahoda2,k+2) = (x(nahoda2,k+1)+x(nahoda1,k+1))/2;
          x(nahoda1,k+2) = (x(nahoda1,k+1)+x(nahoda2,k+1))/2;    
          k = k+1;
          pocet_sprav = pocet_sprav + poslane_spravy;
    end
    
    Kl = [Kl k];
    PS = [PS pocet_sprav];
    x_vys = [x_vys x(:,end)];
    error = [error mse(x(:,end), zeros(size(A,1),1))];
end
