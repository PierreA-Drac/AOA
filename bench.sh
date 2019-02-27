tab_size=300
warm_up_rep=100
measure_rep=30

make clean && make && ./baseline $tab_size $warm_up_rep $measure_rep | sort | cut -d' ' -f1 | sed "$(($measure_rep/2))"'!d'
