#!/usr/bin/env bash

set -e

stan_repo=$(pwd)

make_path=$stan_repo/../cmdstan

stan_file="solver"
stan_path=$stan_repo/$stan_file

cd $make_path
make $stan_path/$stan_file

cd $stan_path
./$stan_file sample \
    adapt engaged=1 \
    num_samples=2 \
    num_warmup=0 \
    algorithm=fixed_param \
    random seed=1
$make_path/bin/stansummary output.csv

grep -v "#" output.csv > $stan_file.csv

nix-shell \
    -p '(with python36Packages; [
        (csvkit.overridePythonAttrs (oldAttrs: {checkPhase = "true";}))
    ])' \
    --run "csvlook --no-inference $stan_file.csv"
