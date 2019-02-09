#!/usr/bin/env bash

set -e

ocamlfind ocamlopt \
    -I ../utils \
    -linkpkg ../utils/utils.ml ../utils/data.ml ../utils/generate.ml $1.ml \
    -o $1
./$1
