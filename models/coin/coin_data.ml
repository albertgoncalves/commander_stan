module A = Array
module D = Data
module L = List
module R = Random

let swap a i j =
    let t = a.(i) in
    a.(i) <- a.(j);
    a.(j) <- t

let shuffle a =
    let rand i = R.int (i + 1) in
    A.iteri (fun i _ -> swap a i (rand i)) a;
    a

let main () =
    let ones = L.init 10 (fun _ -> 1) in
    let zeros = L.init 4 (fun _ -> 0) in
    let obs = A.to_list @@ shuffle @@ A.of_list @@ L.concat [ones; zeros] in
    let n = L.length obs in

    let data_list = L.map D.export [ D.Int ("n", n)
                                   ; D.IntList ("obs", obs)
                                   ; D.Int ("m", 5)
                                   ] in

    D.write_to_file ~filename:"coin.data.R" data_list

let () = main ()
