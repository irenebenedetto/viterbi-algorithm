# Implementation of Viterbi algorithm
Matlab implementation of <a href="https://en.wikipedia.org/wiki/Viterbi_algorithm">Viterbi</a> algorithm with early decision for binary encoding.
The code containes several files:
- `trellis.m`: returns the trellis structure for the encoding;
- `viterbi_algorithm.m`: it carries out the choice of the less cost path for the sequence of bits in the window considered, by calling the function `get_cost_enter()` and then selecting the bits associated with the less cost path with the function `backtrack()`;
- `run.m`: it randomly generates a signal mapped with the function `trellis()`  and adds some noise. Then call the function `viterbi_algorithm()` to reconstruct the original signal. This operation is repeted until the Signal-To-Noise rate is below a certain threshold;
- `get_cost_enter.m`: computes the cost for a sequence of 2 mapped bits;
- `backtrack.m`: reconstruct the original signal from the trellis considered in the `trellis()` function.


## Usage
Choose three window lenghts and the confidence interval size in terms of minimum number of wrong bits in the file `run.m`: the files plots the trends of the Bit Error Rate over the Signal-To-Noise rate for the three windows chosen.

<img src="https://raw.githubusercontent.com/irenebenedetto/viterbi-algorithm/master/imgs/output.png" height="400px">

As displayed in the image, the higher is the delay, the more the BIR of the signal is close to a Viterbi algorithm without windows and consequently, the quickly BIR decreases while SNR increases.
