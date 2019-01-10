data {
    int n;
    real obs[n];
}

parameters {
    real<lower=max(obs)> pop;
}

model {
    obs ~ uniform(0, pop);
}
