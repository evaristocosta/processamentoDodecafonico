function [intermat] = intervalo_matriz(internone)
intermat = zeros(11);

    for x = 1:10
        f = internone(x);
        s = internone(x+1);
        intermat(f,s) = intermat(f,s)+1;
    end
end