#!/usr/bin/env bash

set -e

export stan_repo=$(pwd)

make_path=$stan_repo/$1
stan_path=$stan_repo/$2
stan_file=$3

cd $make_path
make $stan_path/$stan_file

cd $stan_path
./$stan_file sample num_samples=4000 data file=$stan_file.data.R
$make_path/bin/stansummary output.csv

grep -v "#" output.csv > $stan_file.csv

nix-shell \
    -p python36Packages.csvkit \
    --run "head $stan_file.csv | csvlook --no-inference"
