# Commander Stan

Had trouble getting [PyStan](https://pystan.readthedocs.io/en/latest/index.html) or [RStan](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started) to work in a [Nix](https://nixos.org/nix/) environment so I put together a simple toolbox to make things happen with [CmdStan](https://github.com/stan-dev/cmdstan).

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
