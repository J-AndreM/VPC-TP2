function [Im] = MED_FILTER(I,n)
% Devolve uma imagem de saída com as mesmas dimensões que a imagem de
% entrada, tratada por um filtro de mediana com dimensões n*n

s = size(I);
% Verifica se é uma imagem em escala de cinzentos
if size(s,2) ~= 2
    error('A imagem deve estar em escala de cinzentos!');
end
% Verifica se a dimensão 'n' é ímpar e maior que 0
if (n <= 0 || mod(n,2) == 0)
    error('''n'' deve ser um número ímpar positivo!');
end
% Verifica se a dimensão 'n' é ímpar e maior que 0
if (n > min(s))
    error('''n'' deve ser menor que o tamanho da imagem de entrada!');
end

n=5;
x = (n-1)/2;
% Criamos uma imagem com mais n-1 linhas e colunas para que a imagem
% de saída tenha a mesma dimensão que a imagem de entrada
Iaux = uint8(zeros(s(1)+n-1,s(2)+n-1));
% Introduz a imagem
Iaux(x+1:end-x,x+1:end-x) = I(:,:);
for i=1:x
    % Duplica a primeira e a última linha (n-1)/2 vezes
    Iaux(i,:) = [I(1,1:x) I(1,:) I(1,end-x+1:end)];
    Iaux(end-i+1,:) = [I(end,1:x) I(end,:) I(end,end-x+1:end)];
    % Duplica a primeira e a última coluna (n-1)/2 vezes
    Iaux(x+1:end-x,i) = I(:,1);
    Iaux(x+1:end-x,end-i+1) = I(:,end);
end


% Vizinhança de dimensão n*n
V = uint8(zeros(n,n));
Im = uint8(zeros(s(1),s(2)));
for i=(x+1):(size(Iaux,1)-x)
    for j=(x+1):(size(Iaux,2)-x)
        V = Iaux(i-x:i+x,j-x:j+x);
        Im(i-x,j-x) = median(V(:));
    end
end

end