#!/usr/bin/env bash

set -e

model="mark_and_recapture"

stan_path=$model
stan_file=$model
ocaml_file="$stan_file"_data

cd $stan_path
nix-shell ../../shell.nix --run "sh ../ocaml.sh $ocaml_file"

cd ../
sh ../stan.sh $stan_path $stan_file
