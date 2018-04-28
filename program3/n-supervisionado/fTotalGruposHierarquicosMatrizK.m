%..indices dos valores positivos por linha ordenados descendentemente
%segundo o valor de K
%..ordenar os vetores segundo o primeiro maior
%..apagar os vizinhos dos valores que são únicos (entre todos os valores ele é o unico, então deve ser fixo nessa linha, apagar os demais do seu vetor)
%..fazer uma busca em profundidade - os elementos  mais para esquerda
%otimizam o problema

% K = [1   0  0;
%      15 25 11;
%      0   1  0];
% K = [16  1   0;
%       7  3   0;
%       3  12  11];
% K = [16  1   0  23;
%       7  3   8  0;
%       3  12  11 3;
%       5  9  8  0];

function [G,nomesEntSaida] = fTotalGruposHierarquicosMatrizK(K);

%...achar os indices dos positivos por cada linha
  c = length(K);
 I1 = cell(c,1);
 I2 = I1;
 for i=1:c
         Im = find(K(i,:)>0);  %..indices dos positivos por linha
         L1 = length(Im);      %..quantidade total de positivos por linha
    if L1>1 
        [Mo,IM] = sort(K(i,Im),'descend'); %..ordenar descendentemente
        IM = Im(IM);                       %..indices originais de Im dos elementos ordenados
    else
       Mo = K(i,Im);                       %..se somente temos um valor positivo
       IM = Im;                            %..indice do positivo
    end
    I1{i,1} = IM;   %..indices dos elementos positivos por cada linha de K
      PM(i) = Mo(1);%..primeiro maior por linha
 end
 %.........................................................................
 
 %...........ordenar os vetores segundo o primeiro maior...................
 [a,b] = sort(PM,'descend'); %..ordenar o primeiro maior de cada linha
 V = [];
 T = zeros(1,c);
 for i=1:c;
     I2{i,1} = I1{b(i),1};   %..ordenar os vetores segundo o primeiro maior
     V = [V I2{i,1}];         %..concatenar os índices em um vetor

 end
 %.........................................................................
 
 %..apagar os vizinhos dos nós que devem ser fixos porque são únicos no vetor
 uV = unique(V);   %..unicos de V
 hV = hist(V,uV);  %..histograma dos únicos de V
 uI = find(hV==1); %..indices dos sozinhos em V
 for i=1:length(uI) 
     a = find(V==uI(i)); %..posição do sozinhos dentro de V
     for j=1:c
         if ismember(V(a),I2{j,1}) 
             I2{j,1} = V(a);       %..fixar V(a)
         end 
     end
 end
 %.........................................................................
 
%c = length(I2);
for i=1:c; T(i) = length(I2{i,1}); end

% I2{1,1}=[1 2 3];
% I2{2,1}=[2 4];
% I2{3,1}=[1 2];
% I2{1,1}=[1 3];
% I2{2,1}=[2 ];
% I2{3,1}=[1 2];
% I2{1,1}=[1 2 5];
% I2{2,1}=[2 3];
% I2{3,1}=[1 3 1];
% I2{4,1}=[2 2 ];

if sum(T)~=c %..se tem mais de uma opção por linha, 

%...busca em profundidade....................
 NOS = zeros(1,c);
   j = 1; i =1;
flag = 0;
XY = zeros(c,2); %..para guardar os nós do caminho
while flag==0
    Va = I2{i,1};             %..nivel atual
    no = Va(j);               %..nó
    if ismember(no,NOS)       %..o novo nó SIM pertence 
        if j<T(i)  %..ainda faltam nós do nível i - usar %T(1,i)
            j = j + 1;        %..sim, então pegar o seguinte nó
        else                  %..acabaram os nós do nível i,então passar o seguinte nó do nível anterior
            k = 1;                               %..para ir subindo nível a nivel superior
            flag2 = 0;                           %..para entrar no while de troca a nó superior
            while flag2==0
            if XY(i-k,2)+1<=T(i-k)               %..procurar o nível anterior que ainda tem nó livres
                i = XY(i-k,1);                   %..nível anterior
                j = XY(i,2)+1;                   %..seguinte nó
                XY(i:end,:) = zeros((c-i)+1,2);  %..apagar as folhas do caminho errado 
                NOS(i:end) = zeros((c-i)+1,1);   %..apagar os nós dos caminhos errados
                flag2 = 1;                       %..sair deste while troca para nó superior, e continuar com a busca neste ponto
            else
                flag2 = 0;                       %..continuar no while               
                k = k + 1;                       %..continuar com a busca em um nível superior
            end
            end
        end
    else               
        NOS(i) = no;      %..nó NÃO pertence, juntar o nó e...
        XY(i,:) = [i j];  %..guardar o nó do caminho
        i = i + 1;        %..passar de nivel
        j = 1;            %..voltar o nó 1
    end
    if i>c                %..se terminou de procurar nos niveis
        flag = 1;         
    end
end

else %...se só tem uma opção em cada linha
    for i=1:c; NOS(i) = I2{i,1}; end %..devolver os nós únicos, não tendo outra opção, ojo podem estar repetidos, não é verificado isso
 
end

%..
for i=1:c
 G(b(i)) = K(b(i),NOS(i));
end
G = G';
nomesEntSaida = [NOS' b'];





 
 
 
 