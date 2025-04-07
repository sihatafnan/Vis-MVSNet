#!/bin/bash

DIR=./outputs/tnt
mkdir -p ${DIR}
tanksandtemples_dir=/content/drive/MyDrive/MVS/tankandtemples
load_dir=/content/Vis-MVSNet/pretrained_model/vis

job_name=("model_cas")  # Correct way to define an array in Bash

for M in "${job_name[@]}"; do
    for S in {0..7}; do
        for NS in 7; do
            echo "----------Processing scan $S with model $M and ${NS} views----------"
            mkdir -p ${DIR}/depth_${S}_${M}_${NS}
            SCAN=${S} python /content/Vis-MVSNet/test.py \
                --data_root ${tanksandtemples_dir} \
                --dataset_name tanksandtemples \
                --model_name model_cas \
                --num_src ${NS} \
                --max_d 256 \
                --interval_scale 1 \
                --cas_depth_num 64,32,16 \
                --cas_interv_scale 4,2,1 \
                --resize 1920,1080 \
                --crop 1920,1056 \
                --mode soft \
                --load_path ${load_dir}/ \
                --write_result \
                --result_dir ${DIR}/depth_${S}_${M}_${NS}
        done
    done
done
