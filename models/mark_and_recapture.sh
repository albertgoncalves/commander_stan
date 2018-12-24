#!/usr/bin/env bash

set -e

model="mark_and_recapture"

stan_path=$model
stan_file=$model
ocaml_file="$model"_data

cd $stan_path
nix-shell ../../shell.nix \
    --run "ocamlfind ocamlopt ../utils/utils.ml -I ../utils -linkpkg $ocaml_file.ml -o $ocaml_file && ./$ocaml_file"

cd ../
sh ../stan.sh $stan_path $stan_file
