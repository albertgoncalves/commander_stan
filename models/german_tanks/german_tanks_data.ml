module D = Data
module L = List
module R = Random

let main () =
    let pop = 10000 in
    let n = 7 in
    let obs = L.init n (fun _ -> R.int pop) in

    let data_list =
        L.map D.export
            [ D.Int ("n", n)
            ; D.IntList ("obs", obs)
            ] in

    D.write_to_file ~filename:"german_tanks.data.R" data_list

let () = main ()
