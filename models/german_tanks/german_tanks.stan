data {
    int n;
    real obs[n];
}

transformed data {
    real max_obs = max(obs);
}

parameters {
    real<lower=max_obs> pop;
}

model {
    obs ~ uniform(0, pop);
}
