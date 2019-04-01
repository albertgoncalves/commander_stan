module A = Array
module L = List
module F = Float
module R = Random
module P = Printf

let (|.) (f : 'b -> 'c) (g : 'a -> 'b) : ('a -> 'c) = fun x -> f (g x)

let sequence (a : unit -> 'a) (b : unit -> 'b) : 'b =
    let f _ = b () in
    (f |. a) ()

let swap (a : 'a array) (i : int) (j : int) : unit =
    let t = a.(i) in
    sequence
        (fun () -> a.(i) <- a.(j))
        (fun () -> a.(j) <- t)

let shuffle_knuth (xs : 'a list) : 'a list =
    let ys = A.of_list xs in
    let n = L.length xs in
    let rand i = i + R.int (n - i) in
    let swap_index i _ =
        if i <> n - 1 then
            swap ys i (rand i)
        else
            () in
    sequence
        (fun () -> A.iteri swap_index ys)
        (fun () -> A.to_list ys)

let rec shuffle = function
    | [] -> []
    | [x] -> [x]
    | xs ->
        let (before, after) = L.partition (fun _ -> R.bool ()) xs in
        L.rev_append (shuffle before) (shuffle after)

(*
 * https://www.johndcook.com/blog/2010/06/14/generating-poisson-random-values/
 *)

let poisson ~(theta : float) : int =
    let l = -.theta |> exp in
    let rec loop k p =
        if p > l then
            loop (k + 1) (p *. R.float 1.0)
        else
            k in
    loop 0 1.0

(*
 * https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform#Basic_form
 *)

let gaussian ~(mu : float) ~(sigma : float) : float =
    let u1 = R.float 1.0 and u2 = R.float 1.0 in
    let r = -.2.0 *. (log u1) |> sqrt in
    let theta = F.pi *. 2.0 *. u2 |> cos in
    let z0 = r *. theta in
    (z0 *. sigma) +. mu
