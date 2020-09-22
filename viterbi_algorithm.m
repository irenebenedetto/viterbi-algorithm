function [out,sequence_bit1, sequence_bit2, past_cost] = viterbi_algorithm(y, past_cost, sequence_bit1, sequence_bit2, i)
    
    out = -1000;
    if i == 1
        for level = 1:2:length(y)-1
            rx = [y(level) y(level+1)];

    %         fprintf('entering sequence: ');
    %         fprintf('%d ', rx);
    %         fprintf('\n');
    %         
            cost = get_cost_enter(rx, level, 0);
            cost = [cost; get_cost_enter(rx, level, 1)];

            if level == 1
    %             fprintf('cost matrix:\t');
    %             fprintf('%d ', cost(1, :));
    %             fprintf('\n\t\t');
    %             fprintf('%d ', cost(2, :));
    %             fprintf('\n');

                current_cost = cost + past_cost;
    %             fprintf('current cost matrix:\t');
    %             fprintf('%d ', current_cost(1, :));
    %             fprintf('\n\t\t');
    %             fprintf('%d ', current_cost(2, :));
    %             fprintf('\n');
    %             
                sequence_bit1 = [];
                sequence_bit2 = [];
                past_cost = [min(cost(1, :)) min(cost(2, :))];

            else
                cost = get_cost_enter(rx, level, 0);
                cost = [cost; get_cost_enter(rx, level, 1)];
%                 fprintf('cost matrix:\t');
%                 fprintf('%d ', cost(1, :));
%                 fprintf('\n\t\t');
    %             fprintf('%d ', cost(2, :));
    %             fprintf('\n');
    %             
                current_cost = cost + past_cost;
    %             fprintf('current cost matrix:\t');
    %             fprintf('%d ', current_cost(1, :));
    %             fprintf('\n\t\t\t');
    %             fprintf('%d ', current_cost(2, :));
    %             fprintf('\n');
    %           
                for i=1:2
                    [m, ind] = min(current_cost(i, :));
                    past_cost(i) = m;
                    if i == 1
                        if ind == 1
                            sequence_bit1 = [sequence_bit1 'u'] ;
                        else
                            sequence_bit1 = [sequence_bit1 'd'] ;
                        end
                    else
                        if ind == 1
                            sequence_bit2 = [sequence_bit2 'u'] ;
                        else
                            sequence_bit2 = [sequence_bit2 'd'] ;
                        end
                    end

                end
                
    %             fprintf('evolving sequence_bit1:\t');
    %             fprintf('%c ', sequence_bit1);
    %             
    %             fprintf('\nevolving sequence_bit2:\t');
    %             fprintf('%c ', sequence_bit2);
    %             fprintf('\n');
    %             
%                 fprintf('\ncost until now:\t');
%                 fprintf('%d ', past_cost);
%                 fprintf('\n');
           end

            if level == length(y)-1
                [min_path, index_min] = min(past_cost);
                
                if index_min == 1
                    out = backtrack(sequence_bit1,sequence_bit2, 1);
                else
                    out = backtrack(sequence_bit1,sequence_bit2, 2);

                end
               

            end
        end
    else
        
        %         CONSIDERO SOLO L'ULTIMO RX
        rx = [y(length(y) -1) y(length(y))];
       
        %         fprintf('entering sequence: ');
        %         fprintf('%d ', rx);
        %         fprintf('\n');
        %
       
        
        cost = get_cost_enter(rx, length(y) -1, 0);
        cost = [cost; get_cost_enter(rx, length(y) -1, 1)];
        %             fprintf('cost matrix:\t');
        %             fprintf('%d ', cost(1, :));
        %             fprintf('\n\t\t');
        %             fprintf('%d ', cost(2, :));
        %             fprintf('\n');
        %
        current_cost = cost + past_cost;
        %             fprintf('current cost matrix:\t');
        %             fprintf('%d ', current_cost(1, :));
        %             fprintf('\n\t\t\t');
        %             fprintf('%d ', current_cost(2, :));
        %             fprintf('\n');
        %
        for i=1:2
            [m, ind] = min(current_cost(i, :));
            past_cost(i) = m;
            if i == 1
                if ind == 1
                    sequence_bit1 = [sequence_bit1 'u'] ;
                else
                    sequence_bit1 = [sequence_bit1 'd'] ;
                end
            else
                if ind == 1
                    sequence_bit2 = [sequence_bit2 'u'] ;
                else
                    sequence_bit2 = [sequence_bit2 'd'] ;
                end
            end
            
            
            %             fprintf('evolving sequence_bit1:\t');
            %             fprintf('%c ', sequence_bit1);
            %
            %             fprintf('\nevolving sequence_bit2:\t');
            %             fprintf('%c ', sequence_bit2);
            %             fprintf('\n');
            %
            %             fprintf('\ncost until now:\t');
            %             fprintf('%d ', past_cost);
            %             fprintf('\n');
        end
        
        [min_path, index_min] = min(past_cost);
        
        if index_min == 1
            out = backtrack(sequence_bit1,sequence_bit2, 1);
        else
            out = backtrack(sequence_bit1,sequence_bit2, 2);
            
        end
        
            
        end
        
    end
    
    
    

