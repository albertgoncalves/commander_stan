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
$ git clone https://github.com/stan-dev/cmdstan.git --recursive
$ cd cmdstan
$ make build
```

```
$ cd ../models/
$ sh {bernoulli|coin|german_tanks|mark_and_recapture}.sh
```

These scripts wrap up the basic **CmdStan** workflow; if you need a refresher head over to [Getting Started with CmdStan](https://github.com/stan-dev/cmdstan/wiki/Getting-Started-with-CmdStan).
