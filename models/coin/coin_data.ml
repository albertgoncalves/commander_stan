module D = Data
module G = Generate
module L = List
module R = Random

let main () =
    let ones = L.init 10 (fun _ -> 1) in
    let zeros = L.init 4 (fun _ -> 0) in
    let obs = G.shuffle @@ L.concat [ones; zeros] in
    let n = L.length obs in

    let data_list =
        L.map D.export
            [ D.Int ("n", n)
            ; D.IntList ("obs", obs)
            ; D.Int ("m", 5)
            ] in

    D.write_to_file ~filename:"coin.data.R" data_list

let () = main ()
