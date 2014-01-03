set terminal png size 1100,600
set xdata time
set timefmt "%b-%d-%H:%M:%S-%Y"
set grid
set output "/var/www/data/load_`echo $time_period`.png"
set multiplot

set size 1,0.333
set origin 0,0.666
set title "Resource Usage"
set ylabel "Load"
set y2label "% RAM Usage"
set y2tics
set yrange [0:4]
set y2range [0:100]
plot "< tail `echo -$time_period` /var/www/data/data.txt" using 1:2 title "CPU" w lp axes x1y1, "< tail `echo -$time_period` /media/Backup/data.txt" using 1:3 title "RAM" w lp axes x1y2
unset y2label
unset y2tics

set size 1,0.333
set origin 0,0.333
set title "Hardware Temperature"
set ylabel "Temperature"
set yrange [30:70]
plot "< tail `echo -$time_period` /var/www/data/data.txt" u 1:4 w lp t "CPU"

set size 1,0.333
set origin 0,0
set title "Disk Usage"
set ylabel "% Disk Used"
set yrange [0:100]
plot "< tail `echo -$time_period` /var/www/data/data.txt" using 1:5 title "/" w lp axes x1y1, "< tail `echo -$time_period` /media/Backup/data.txt" using 1:6 title "/boot" w lp axes x1y1, "< tail `echo -$time_period` /media/Backup/data.txt" using 1:7 title "/media/Share" w lp axes x1y1

