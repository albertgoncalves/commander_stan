#!/usr/bin/env Rscript

if (sys.nframe() == 0) {
    data = read.csv("mark_and_recapture.csv")
    plot(density(data$pop))
    abline(v=1500, col="red")
}
