module L = List
module P = Printf
module S = String
module U = Utils

type data =
    | Int of string * int
    | IntList of string * int list
    | FloatList of string * float list

let export data =
    let indiv to_string k v =
        let v = to_string v in
        P.sprintf "%s <- %s" k v in
    let vector to_string k v =
        let v = S.concat ", " @@ L.map to_string v in
        P.sprintf "%s <- c(%s)" k v in
    let export = function
        | Int (k, v) -> indiv string_of_int k v
        | IntList (k, v) -> vector string_of_int k v
        | FloatList (k, v) -> vector string_of_float k v in
    export data

let write_to_file ~filename lines =
    let out_channel = open_out filename in
    let lambda ()=
        L.iter (fun line -> P.fprintf out_channel "%s\n" line) lines in
    U.finally
        lambda
        (fun () -> close_out out_channel)
