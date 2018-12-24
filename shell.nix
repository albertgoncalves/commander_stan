{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "stan";
    buildInputs = [ ocaml-ng.ocamlPackages_4_07.ocaml
                    ocaml-ng.ocamlPackages_4_07.findlib
                    ocaml-ng.ocamlPackages_4_07.ocp-indent
                    ocaml-ng.ocamlPackages_4_07.utop
                    python36Packages.csvkit
                    fzf
                  ];
    shellHook = ''
        strcd() { cd "$(dirname $1)"; }
        withfzf() {
            local h
            h=$(fzf)
            if (( $? == 0 )); then
                $1 "$h"
            fi
        }

        alias cdfzf="withfzf strcd"
        alias vimfzf="withfzf vim"

        export -f withfzf
    '';
}
