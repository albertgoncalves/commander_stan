// https://mc-stan.org/docs/2_18/stan-users-guide/coding-an-algebraic-system.html

functions {
    vector system(vector y, vector theta, real[] x_r, int[] x_i) {
        vector[2] z;
        z[1] = y[1] - theta[1];
        z[2] = y[1] * y[2] - theta[2];
        return z;
    }
}

transformed data {
    vector[2] y_guess = [1, 1]';
    real x_r[0];
    int x_i[0];
}

transformed parameters {
    vector[2] theta = [3, 6]';
    vector[2] y;

    y = algebra_solver(system, y_guess, theta, x_r, x_i);
}
