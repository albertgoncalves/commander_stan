# Commander Stan

Had trouble getting **PyStan** or **RStan** to work so I put together an extremely simple toolbox to make things happen with **CmdStan**.

Needed things
---
 - [Nix](https://nixos.org/nix/)

Getting started
---
```
$ git clone https://github.com/albertgoncalves/commander_stan.git
$ cd commander_stan
$ wget https://github.com/stan-dev/cmdstan/releases/download/v2.18.0/cmdstan-2.18.0.tar.gz
$ tar -xzvf cmdstan-2.18.0.tar.gz
$ cd cmdstan-2.18.0
$ make build
```

```
$ cd ../
$ sh {bernoulli|coin|german_tanks}.sh
```
