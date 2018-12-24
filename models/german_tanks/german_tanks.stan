data {
    // $ python; population = 1000; obs = np.random.randint(0, population, n)
    int n;
    real obs[n];
}

parameters {
    real<lower=max(obs)> pop;
}

model {
    obs ~ uniform(0, pop);
}
