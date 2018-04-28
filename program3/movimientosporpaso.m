function Mpp = movimientosporpaso(nmat);
  I = abs(nmat);
  n = length(I);

  %..Cantidad de intervalos por paso diat�nicos.........
  idiat = 0; 
  for i=1:n
      if (abs(I(1,i))==1) || (abs(I(1,i))==2)
          idiat = idiat+1;
      end
  end

  %..Calcular el descriptor........
  Mpp=idiat/n;
end