# NOSdata
Data package containing a database of 'near-oracle' subgroups of the sign-flipping group. Each subgroup is represented as an n by m matrix, where n is the number of signs and m is the order of the group. Each column corresponds to an element of the group, under element-wise multiplication. The identity element is contained in the first column.

# Construction
The package also contains two files that were used to generate the near-oracle subgroups ([group_construction.R](https://github.com/nickwkoning/NOSdata/blob/main/R/group_construction.R), [group_construction_parallel.R](https://github.com/nickwkoning/NOSdata/blob/main/R/group_construction_parallel.R)). These are based on the algorithm described in Koning & Hemerik (2022) implemented in the package [NOS](https://github.com/nickwkoning/NOS), and can be used to construct near-oracle subgroups that are not currently stored in the database.

# Installation
You can install the data package using:
```{r}
devtools::install_github("nickwkoning/NOSdata")
```

# Example
Suppose we have n = 10 independent observations from a sign-flipping invariant distribution with mean .1 and standard deviation 1.
```{r}
n = 10
mu = .1
x = mu + rnorm(n)
```
We want to test the null-hypothesis that the mean is zero against the alternative that it is non-zero at level .05. We use a sign-flipping subgroup of order 2^(6 - 1), which means it has rank 6. As we test against a two-sided alternative, we select a near-oracle subgroup whose name starts with "max_abs".
```{r}
alpha = .05
rank = 6
subgroup = t(get(paste0("max_100k_subgroups_max1024_n", n))[[rank]])
```
To conduct the test, we compute the sign-flipped test statistics and compute the proportion of the test statistics on the sign-flipped data weakly exceed the test statistic on the actual data. The test statistic on the actual data coincides with the first element, as the identity is the first column of each subgroup. If this proportion is smaller than our level .05, we reject the null nypothesis.
```{r}
test_stats = t(subgroup) %*% x
p_val = mean(test_stats[1] <= test_stats)
p_val < alpha
```
