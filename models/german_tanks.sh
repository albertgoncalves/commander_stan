#!/usr/bin/env bash

set -e

model="german_tanks"

stan_path=$model
stan_file=$model
ocaml_file="$stan_file"_data

cd $stan_path
nix-shell ../../shell.nix --run "sh ../utils/ocaml.sh $ocaml_file"

cd ../
sh ../stan.sh $stan_path $stan_file
