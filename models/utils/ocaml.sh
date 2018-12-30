#!/usr/bin/env bash

set -e

ocamlfind ocamlopt ../utils/data.ml ../utils/math.ml \
    -I ../utils \
    -linkpkg $1.ml \
    -o $1
./$1
