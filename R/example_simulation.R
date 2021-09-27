## Settings
n = 6
mu = .1
rank = 6 # 2^(rank - 1) is the desired order of the subgroup
alpha = .05


## Simulation
num_sim = 100000

p_val = c()
for (i in 1:num_sim) {
  x = mu + rnorm(n)

  # compute sign-flipped test statistics
  iGx = t(get(paste0("max_100k_subgroups_max1024_n", n))[[rank]]) %*% x

  # find p-value
  p_val[i] = mean(iGx[1] <= iGx)
}


# rejection proportion
mean(p_val < alpha)

