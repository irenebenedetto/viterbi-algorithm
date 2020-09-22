clear all 
clc

w = [100, 2, 5];
wrong_bits = 100;

for ww=1:3
    
    window = w(ww);
    n_errors = 0;
    ber = 1;
    denominator = 0;
    db_snr = 0;
    plot_err = [];
    plot_power = [];
    final_output = [];

    while db_snr <= 5
         x = [randi([0, 1], 1, 100) zeros(1, window)];

    %     fprintf('x\t');
    %     fprintf('%d ', x);
    %     fprintf('\n');
        snr = 10^(db_snr/10);
        n0 = 1/snr;

        out = [];
        mapped_out = [];
        L = length(x);
        if x(1) == 0
            out = [0 0];
        else
            out = [1 1];
        end

        for i=2:length(x)
            out = [out trellis(x(i-1), x(i))];
        end

        for i=1:length(out)
            if out(i) == 1
                mapped_out = [mapped_out 1];
            else
                mapped_out = [mapped_out -1];
            end
        end

        noise = normrnd(0, 1, [1, length(out)]);
         y = mapped_out + noise*sqrt(n0/2);
   
        out_decided = [];
        for i=1:length(y)
            if y(i) > 0
                out_decided = [out_decided 1];
            else
                out_decided = [out_decided 0];
            end
        end

    %     fprintf('decided\t');
    %     fprintf('%d ', out_decided);
    %     fprintf('\n');

        past_cost = [0 0];
        final_output = [];
        complete_sequence_bit1 = [];
        complete_sequence_bit2 = [];
        for i = 1:2:(length(out_decided)-(window*2))
            rx = out_decided(i:window*2 + i -1);
    %         fprintf('\nsequence entering--> ');
    %         fprintf('%d', rx);
    %         
            [exit, sequence_bit1, sequence_bit2, past_cost] = viterbi_algorithm(rx, past_cost, complete_sequence_bit1(2:length(complete_sequence_bit1)), complete_sequence_bit2(2:length(complete_sequence_bit2)), i);

    %         fprintf('\nsequence_bit2 lenght: \t');
    %         fprintf('%d ', length(sequence_bit2));
            if i == 1
                complete_sequence_bit1 = sequence_bit1;
                complete_sequence_bit2 = sequence_bit2;
            else
                complete_sequence_bit1 = [complete_sequence_bit1(2:length(complete_sequence_bit1)), sequence_bit1(length(sequence_bit1))];
                complete_sequence_bit2 = [complete_sequence_bit2(2:length(complete_sequence_bit2)), sequence_bit2(length(sequence_bit2))];
            end

    %         fprintf('\ncomplete_sequence_bit1 lenght: \t');
    %         fprintf('%d ', length(complete_sequence_bit1));
    %         fprintf('\ncost: \t');
    %         
    %         fprintf('%d ', past_cost);
            final_output = [final_output exit];




        end
    %     fprintf('\n\nexit:\t');
    %     fprintf('%d ', final_output);
    %     fprintf('\n');

        for i=1:length(x)-window
            n_errors = n_errors + abs(x(i) - final_output(i));
        end

        denominator = denominator + length(x)-window;

        if n_errors >= wrong_bits

            ber = n_errors/denominator;
            fprintf('\n');
            fprintf('snr: %.5f\n', snr);
            fprintf('errors: %.10f\n', n_errors);
            fprintf('BER: %.10f\n', ber);
            plot_err = [plot_err ber];
            plot_power = [plot_power db_snr];

            db_snr = db_snr + 1;

            n_errors = 0;
            denominator = 0;
        end


    end
                  
    semilogy(0:5, plot_err), title('Bit error rate of Viterbi Algorithm');
    disp(plot_err);
    hold on
end

xlabel('SNR');
ylabel('Bit error rate ');
legend('No early decision', 'delay of 2', 'delay of 5');

hold off
