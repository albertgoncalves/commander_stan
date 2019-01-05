#!/usr/bin/env bash

set -e

stan_file="solver"
model_path="../models/solver"

cd ../cmdstan/
make $model_path/$stan_file
./$model_path/$stan_file sample \
    adapt engaged=0 \
    num_samples=1 \
    num_warmup=0 \
    algorithm=fixed_param \
    random seed=1
bin/stansummary ./$model_path/output.csv

cd $model_path
grep -v "#" output.csv > $stan_file.csv

nix-shell \
    -p python36Packages.csvkit \
    --run "head -n 2 $stan_file.csv | csvlook --no-inference"
