#!/usr/bin/gnuplot

# Load config
load "config.gp"

DATA = "../data/outputs/classified.dat"

set terminal pdfcairo size 8,3 font "Verdana,15" enhanced
set output '../iris_kmeans.pdf'

set xrange [3:9]
set yrange [1.5:5]

set ylabel SEPALWIDTH_LAB
set xlabel PETALWIDTH_LAB

set border linewidth 1.5 lc rgb "#808080"

set border 3 
set tics nomirror out scale 0.75

set grid
set size ratio 0.7

set multiplot layout 1,2 title "Orig vs. K-Mean" font "Verdana, 18"

# Original Species Plot
set key font "Verdana, 10"

set title "Original Categories"
plot DATA using 1:($5==1 ? $2 : NaN) with points pt 7 lc rgb SETOSA_COL title "Setosa", \
     DATA using 1:($5==2 ? $2 : NaN) with points pt 7 lc rgb VERSICOLOR_COL title "Versicolor", \
     DATA using 1:($5==3 ? $2 : NaN) with points pt 7 lc rgb VIRGINICA_COL title "Virginica"

# Grouped Speccies Plot
# NOTE: need to change color order by hand here
set title "K-Means Categories"
plot DATA using 1:($6==2 ? $2 : NaN) with points pt 7 lc rgb SETOSA_COL title "Setosa", \
     DATA using 1:($6==1 ? $2 : NaN) with points pt 7 lc rgb VERSICOLOR_COL title "Versicolor", \
     DATA using 1:($6==3 ? $2 : NaN) with points pt 7 lc rgb VIRGINICA_COL title "Virginica"

unset multiplot
