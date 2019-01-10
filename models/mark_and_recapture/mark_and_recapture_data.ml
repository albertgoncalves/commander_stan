module D = Data
module G = Generate
module L = List
module P = Printf
module R = Random
module S = String

let histogram xs =
    let xs = L.sort compare xs in
    let rec loop count accu = function
        | [] -> []
        | [x] -> count::accu
        | x::(xx::_ as xs) ->
            if x = xx then loop (count + 1) accu xs
            else loop 1 (count::accu) xs in
    loop 1 [] xs

let sample_counts ~subpop ~n_samples =
    let theta = float_of_int subpop in
    L.init n_samples (fun _ -> G.poisson ~theta)

let label_samples ~pop samples =
    L.init samples (fun _ -> R.int pop)

let label_captures ~pop ~sample_sizes =
    L.flatten @@ L.map (label_samples ~pop) sample_sizes

let main () =
    let pop = 1500 in (* population to be estimate from generated data *)
    let subpop = 50 in (* "true" sample event rate *)
    let n_samples = 3 in (* number of capture events *)
    let sample_sizes = sample_counts ~subpop ~n_samples in
    let labels = label_captures ~pop ~sample_sizes in (* sampled pop labels *)
    let freq = histogram labels in

    let data_list = L.map D.export
        [ D.Int ("n_samples", n_samples)
        ; D.Int ("n_freq", L.length freq)
        ; D.IntList ("sample_sizes", sample_sizes)
        ; D.IntList ("freq", freq)
        ] in

    D.write_to_file ~filename:"mark_and_recapture.data.R" data_list

let () = main ()
