%INI = normrnd(0,1,30,1);

Kl = [];
PS = [];
x_vys = [];
error = [];

for q = 1:1:100
    %if mod(q,100)==0
       %q 
    %end
    x = INI(1:size(A,1));%(1:1:size(A,1))';
    w = ones(1,size(A,1))';
    odhad = (1:1:size(A,1))';
    k = 0;
    
    
    while abs(max(odhad(:,k+1))-min(odhad(:,k+1)))>P
          %teraz kazdy uzol vyberie suseda a posle mu hodnotu
          dorucene_spravy = zeros(size(A,1),size(A,1)); %DO RIADKA PIS CO TEN KONKRETNY UZOL PRIJAL, dorucene_spravy(1,:) -> 1 prijala tieto co su tu
          dorucene_vahy = zeros(size(A,1),size(A,1));
          for i=1:1:size(A,1) 
              %vyberiem komu to poslem a ulozim hodnotu xi/2 a wi/2 na prislusne miesto adresata ktory je vybraty nahodne 
              nahoda = datasample(find(A(i,:)==1),1);
              dorucene_spravy(nahoda,i) = x(i,k+1)/2;
              dorucene_vahy(nahoda,i) = w(i,k+1)/2;
          end
          %aktualizacia pre dalsiu iteraciu
          for i=1:1:size(A,1)
              %aktualizace hodnot a vah pre dalsiu iteraciu
              dorucene_spravy(i,i) = x(i,k+1)/2;
              dorucene_vahy(i,i) = w(i,k+1)/2;
              x(i,k+2)=sum(dorucene_spravy(i,:));
              w(i,k+2)=sum(dorucene_vahy(i,:));
          end
                %ratanie odhadov pre jednotlive uzly
          odhad = [odhad zeros(1,size(A,1))'];
          for i=1:1:size(A,1)
              for j=1:1:size(A,1)
                  odhad(i,k+2) = sum(dorucene_spravy(i,:))/sum(dorucene_vahy(i,:));
              end
          end
          
          k=k+1;
          
    end
    
    Kl = [Kl k];
    PS = [PS size(A,1)*k];
    x_vys = [x_vys odhad(:,end)];
    error = [error mse(odhad(:,end), zeros(size(A,1),1))];
end

%PS 960
%PS 2880
%PS 990
%PS 1050
%PS 1080
%PS 990