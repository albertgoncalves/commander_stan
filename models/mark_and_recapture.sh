#!/usr/bin/env bash

set -e

model="mark_and_recapture"

stan_path=$model
stan_file=$model

cd $stan_path
nix-shell ../../shell.nix --run "ocaml $stan_file.ml"

cd ../
sh ../stan.sh $stan_path $stan_file
