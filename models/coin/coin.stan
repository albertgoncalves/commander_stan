data {
    int<lower=1> n;
    int<lower=0, upper=1> obs[n];
    int<lower=1> m;
}

parameters {
    real<lower=0, upper=1> theta;
}

model {
    theta ~ beta(1, 1);
    obs ~ bernoulli(theta);
}

generated quantities {
    int<lower=0, upper=1> gen[m];

    for (i in 1:m) {
        gen[i] = bernoulli_rng(theta);
    }
}
