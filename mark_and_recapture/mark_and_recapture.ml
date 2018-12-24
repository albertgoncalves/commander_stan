module L = List
module P = Printf
module R = Random
module S = String

type data =
    | Int of string * int
    | IntList of string * int list
    | FloatList of string * float list

let histogram xs =
    let xs = L.sort compare xs in
    let rec loop count accu = function
        | [] -> []
        | [x] -> count::accu
        | x::(xx::_ as xs) ->
            if x = xx then loop (count + 1) accu xs
            else loop 1 (count::accu) xs in
    loop 1 [] xs

let poisson ~theta =
    let l = exp (-.theta) in
    let k = 0 in
    let p = 1.0 in
    let rec loop k p =
        let p = (p *. R.float 1.0) in
        if p < l then k else loop (k + 1) p in
    loop k p

let sample_counts ~subpop ~n_samples =
    let theta = float_of_int subpop in
    L.init n_samples (fun _ -> poisson ~theta)

let label_samples ~pop samples =
    L.init samples (fun _ -> R.int pop)

let label_captures ~pop ~sample_sizes =
    L.flatten @@ List.map (label_samples ~pop) sample_sizes

let export data =
    let indiv k v = P.sprintf "%s <- %s" k v in
    let vector k v = P.sprintf "%s <- c(%s)" k v in
    let export = function
        | Int (k, v) ->
            let v = string_of_int v in
            indiv k v
        | IntList (k, v) ->
            let v = S.concat ", " @@ L.map string_of_int v in
            vector k v
        | FloatList (k, v) ->
            let v = S.concat ", " @@ L.map string_of_float v in
            vector k v in
    export data

let main () =
    let pop = 500 in (* population to be estimate from generated data *)
    let subpop = 25 in (* "true" sample event rate *)
    let n_samples = 9 in (* number of capture events *)
    let sample_sizes = sample_counts ~subpop ~n_samples in
    let labels = label_captures ~pop ~sample_sizes in (* sampled pop labels *)
    let freq = histogram labels in

    let data_list = [ Int ("n_samples", n_samples)
                    ; Int ("n_freq", L.length freq)
                    ; IntList ("sample_sizes", sample_sizes)
                    ; IntList ("freq", freq)
                    ] in

    L.iter (fun data -> print_endline @@ export data) data_list
