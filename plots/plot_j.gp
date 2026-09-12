set terminal pdfcairo size 5,3 font "Verdana,15" enhanced
set output '../j.pdf'

set xrange [0:15.5]

set ylabel "J"
set xlabel "Iteration"

set border linewidth 1.5
set style line 1 lc rgb '#0060ad' pt 7 ps 1.5 lt 1 lw 2

unset key

set title "K-Means Objective Function"

plot "../data/outputs/j_history.dat" using 1:2 with linespoints pt 7 ps 1.2 lw 1.5

