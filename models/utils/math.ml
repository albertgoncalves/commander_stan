module F = Float
module R = Random

(* https://www.johndcook.com/blog/2010/06/14/generating-poisson-random-values/ *)

let poisson ~theta =
    let l = exp (-.theta) in
    let rec loop k p =
        if p > l then loop (k + 1) (p *. R.float 1.0) else k in
    loop 0 1.0

(* https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform#Basic_form *)

let gaussian ~mu ~sigma =
    let u1 = R.float 1.0 and u2 = R.float 1.0 in
    let r = sqrt ((-2.0) *. (log u1)) in
    let theta = cos (F.pi *. 2.0 *. u2) in
    let z0 = r *. theta in
    (z0 *. sigma) +. mu
