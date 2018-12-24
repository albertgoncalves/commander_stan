#!/usr/bin/env bash

set -e

model="german_tanks"

stan_path=$model
stan_file=$model

sh ../stan.sh $stan_path $stan_file
