{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "CmdStan";
    buildInputs = [
        (with ocaml-ng.ocamlPackages_4_07; [
            ocaml
            findlib
            ocp-indent
            utop
        ])
        fzf
        (with rPackages; [
            R
            # rPackages.lintr
        ])
    ] ++ (with python36Packages; [
        (csvkit.overridePythonAttrs (oldAttrs: {checkPhase = "true";}))
    ]);
    shellHook = ''
        if [ $(uname -s) = "Darwin" ]; then
            alias ls='ls --color=auto'
            alias ll='ls -al'
        fi

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

        lintr() {
            R -e "library(lintr); lint('$1')" \
                | awk '/> /{ found=1 } { if (found) print }'
        }

        export -f lintr
    '';
}
