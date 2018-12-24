#!/usr/bin/env bash

set -e

ocamlfind ocamlopt ../utils/utils.ml \
    -I ../utils \
    -linkpkg $1.ml \
    -o $1
./$1
