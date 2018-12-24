#!/usr/bin/env bash

set -e

model="coin"

make_path="cmdstan-2.18.0"
stan_path=$model
stan_file=$model

sh stan.sh $make_path $stan_path $stan_file
