function [dca,dcd]=direcciondecontorno(nmat);
%Se extrae la columna de Pitch
  P = nmat;
  n = length(P);
  I = diff(P);

  %contar los intervalos ascendentes y descendentes
  Ia = 0; %..intervalos ascendentes
  Id = 0; %..intervalos descendentes

  for i=1:n-1
      if I(1,i)>0
          Ia=Ia+1; 
      else
          Id=Id+1;   
      end
  end

  %Calcular las densidades
  dca = Ia/(n-1); %..densidad de intervalos ascendentes
  dcd = Id/(n-1); %..densidad de intervalos descendentes
end