#!/usr/bin/env bash
export MXNET_CPU_WORKER_NTHREADS=24
export MXNET_CUDNN_AUTOTUNE_DEFAULT=0
export MXNET_ENGINE_TYPE=ThreadedEnginePerDevice

DATA_DIR=../datasets/imdb/

NETWORK=ssr
JOB=imdb
MODELDIR="../models/ssr2_imdb_gender_1_1"
mkdir -p "$MODELDIR"
PREFIX="$MODELDIR/model-$NETWORK-$JOB"
LOGFILE="$MODELDIR/log_ssr_imdb"

PRETRAINED=""

CUDA_VISIBLE_DEVICES='0' python3 -u train_ssr_gender.py --ckpt 2 --data-dir $DATA_DIR --network "$NETWORK" --wd 0.00004 --pretrained "$PRETRAINED" --prefix "$PREFIX" --per-batch-size 128 --lr 0.001 --lr-steps 40000,70000,100000 --max-steps 120000 --netType1 4 --netType2 4 > "$LOGFILE" 2>&1 &

