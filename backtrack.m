function next = backtrack(sequence_bit1,sequence_bit2, n_path)

    next = -10;
    reverse_1 = flip(sequence_bit1);
    reverse_2 = flip(sequence_bit2);
    if n_path == 1 
        temp = reverse_1;
        next = 0;
    else
        temp = reverse_2;
        next = 1;
    end
    
    for i=1:length(reverse_1)
        if i == 1
            if n_path == 1 && temp(i) == 'd'
                temp = reverse_2;
                next = 1;
                n_path = 2;
            elseif n_path == 2 && temp(i) == 'u'
                temp = reverse_1;
                next = 0;
                n_path = 1;
            end
        else
            if n_path == 1 && temp(i) == 'd'
                temp = reverse_2;
                next = 1;
                n_path = 2;
            elseif n_path == 2 && temp(i) == 'u'
                temp = reverse_1;
                next = 0;
                n_path = 1;
            end
        end
    end
    
    
   