#!/usr/bin/env bash

set -e

shared_path="/home/albert/Home/stan"
model="german_tanks"

make_path="$shared_path/cmdstan-2.18.0"
stan_path="$shared_path/$model"
stan_file=$model

sh stan.sh $make_path $stan_path $stan_file
