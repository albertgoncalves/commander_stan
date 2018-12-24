module L = List
module P = Printf
module R = Random
module S = String
module U = Utils

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
    L.flatten @@ L.map (label_samples ~pop) sample_sizes

let main () =
    let pop = 500 in (* population to be estimate from generated data *)
    let subpop = 25 in (* "true" sample event rate *)
    let n_samples = 7 in (* number of capture events *)
    let sample_sizes = sample_counts ~subpop ~n_samples in
    let labels = label_captures ~pop ~sample_sizes in (* sampled pop labels *)
    let freq = histogram labels in

    let data_list = L.map U.export [ U.Int ("n_samples", n_samples)
                                   ; U.Int ("n_freq", L.length freq)
                                   ; U.IntList ("sample_sizes", sample_sizes)
                                   ; U.IntList ("freq", freq)
                                   ] in

    U.write_to_file ~filename:"mark_and_recapture.data.R" data_list

let () = main ()
