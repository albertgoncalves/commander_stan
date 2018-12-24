#!/usr/bin/env bash

set -e

model="bernoulli"

stan_path="../cmdstan/examples/$model"
stan_file=$model

sh ../stan.sh $stan_path $stan_file
