#!/usr/bin/env bash

set -e

model="bernoulli"

make_path="/home/albert/Home/stan/cmdstan-2.18.0"
stan_path="$make_path/examples/$model"
stan_file=$model

sh stan.sh $make_path $stan_path $stan_file
