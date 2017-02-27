function Im = extracao_Sobel(I, limiar)
s = size(I);
% Máscara de Sobel
h_sobel = fspecial('sobel');
Ix=imfilter(I, h_sobel, 'conv');
Iy=imfilter(I, h_sobel', 'conv');

% Aloca espaço para a imagem de saída
Im = zeros(s(1),s(2), 'uint8');
for j = 1:s(2)   
    for i = 1:s(1)
        G = sqrt(double(Ix(i,j))^2 + double(Iy(i,j))^2);       
        if G > limiar
            % Coloca a branco se deteta contornos
            Im(i,j) = 255;
        else
            % Se não, coloca a preto
            Im(i,j) = 0;
        end
    end  
end 