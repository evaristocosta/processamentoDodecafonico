function intermat_all = intervalo_matriz_total(interv)
intermat_all = zeros(22);

    for x = 1:10
        f = interv(x);
        if f < 0
           f = f+12;
        else
            f = f+11;
        end
        s = interv(x+1);
        if s < 0
            s = s+12;
        else
            s = s+11;
        end
        intermat_all(f,s) = intermat_all(f,s)+1;
    end
end