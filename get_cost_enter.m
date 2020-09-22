function cost = get_cost_enter(rx, level, next_bit)

if level == 1
    
    if next_bit == 0
        up = abs(rx(1) - 0) + abs(rx(2) - 0);
        down = 1000;
    else
        up = abs(rx(1) - 0) + abs(rx(2) - 1);
        down = 1000;
    end
    
    
    cost = [up, down];
    
else
    
    if next_bit == 0
        up = abs(rx(1) - 0) + abs(rx(2) - 0);
        down = abs(rx(1) - 1) + abs(rx(2) - 1);
    else
        up = abs(rx(1) - 0) + abs(rx(2) - 1);
        down = abs(rx(1) - 1) + abs(rx(2) - 0);
    end
    
    cost = [up, down];
    
end