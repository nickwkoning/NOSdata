## Settings
n = 10
mu = .1
rank = 6 # 2^(rank - 1) is the desired order of the subgroup
alpha = .05

# Generate some data
x = mu + rnorm(n)

# compute sign-flipped test statistics
iGx = t(get(paste0("max_100k_subgroups_max1024_n", n))[[actual_rank]]) %*% x

# find p-value
p_val = mean(iGx[1] <= iGx)

# rejection proportion
mean(p_val < alpha)
