#!/usr/bin/env bash
# #BSUB -G spnflcgc ustruct cmi amsdnn
#BSUB -G cmi
#BSUB -q pbatch
#BSUB -nnodes 1
#BSUB -W 12:00

module load cuda/11.1 gcc/8
PYTHON=$HOME/lassen-space/anaconda2021/envs/PT19/bin/python
DAT=/g/g90/zhou6/amsdnn/CMI/April2022/ML100-HDDR-0T/512x512
DIR=experiment/April2022_HDDR

# remove bottom row of information; split into smaller images
# cd /g/g90/zhou6/amsdnn/CMI/April2022/ML100-HDDR-0T;
# for i in Hddr*.tif; do convert $i -gravity South -chop 0x70 crop_${i}; done
# python scripts/split_image.py /g/g90/zhou6/amsdnn/CMI/April2022/ML100-HDDR-0T/crop_*.tif --mode=I --wstep=150 --hstep=150

$PYTHON train.py --outdir=$DIR --data=$DAT \
  --cfg=stylegan3-r --gpus=4 --batch=32 --gamma=8 --snap=15

#  --resume=$DIR/00003-stylegan3-r-512x512-gpus4-batch32-gamma8/network-snapshot-000480.pkl \
