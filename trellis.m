function out = trellis(precedente, corrente)
out = [];

if precedente == 1
    if corrente == 0
        out = [1 1];
    else
        out = [1 0];
    end
else
    if corrente == 1
        out = [0 1];
    else
        out = [0 0];
    end
end
