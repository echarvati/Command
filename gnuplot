set terminal pngcairo size 1000,800 enhanced font 'Times New Roman,25'
set output "1.png"
set border lw 1.5

# used in panel (a) (b)...
set label '(a)' at ,0

# set the x,y axis
set xlabel "Pressure(MPa)"
set ylabel "Viscosity(mPa s)"

# set x,y range
set xr [0,100]
set yr [0,100]

# define line style, type, length, colors, see https://blog.csdn.net/ztguang/article/details/72763095 for more colors
set style line 1 lt 1 lw 3 lc rgb "#000000" # black
set style line 2 lt 1 lw 3 lc rgb "#ff0000" # red
set style line 3 lt 1 lw 3 lc rgb "#0000ff" # blue
set style line 4 lt 1 lw 3 lc rgb "#00eeee" # dark-cyan

# set the position of legend
set key top left horizontal sample 1.

# using logscale
set logscale y

# define function
f(x)=exp(x+1)

# plot
pl
f(x) ls 1 title "f(x)"
"1.txt" u 1:2 with lines ls 1 title "plot 1"
"1.txt" u 1:2:3 with errorbars ls 1 title "plot 1"
