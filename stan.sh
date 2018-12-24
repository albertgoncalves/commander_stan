#!/usr/bin/env bash

set -e

export stan_repo=$(pwd)

make_path=$stan_repo/../cmdstan

# $stan_path points to directory containing *.stan and *.data.R
# inside $stan_path, $stan_file points to the specific files
    # $stan_repo/$stan_path/$stan_file.stan
    # $stan_repo/$stan_path/$stan_file.data.R
stan_path=$stan_repo/$1
stan_file=$2

cd $make_path
make $stan_path/$stan_file

cd $stan_path
./$stan_file sample num_samples=1000 data file=$stan_file.data.R
$make_path/bin/stansummary output.csv

grep -v "#" output.csv > $stan_file.csv

nix-shell \
    -p python36Packages.csvkit \
    --run "head $stan_file.csv | csvlook --no-inference"
