library(NOS)
library(usethis)
library(devtools)
library(tidyverse)
library(doParallel)

# parallelization parameters

num_cores = parallel::detectCores() - 1

my.cluster <- parallel::makeCluster(
  num_cores,
  type = "PSOCK"
)

print(my.cluster)

doParallel::registerDoParallel(cl = my.cluster)

# parameters


leak_fun = leak_l1
max_rank = 10
max_order = 2^max_rank
num_candidates = 100000
N_set = 12:22

subgroup_list_list = foreach(
  n = N_set,
  .packages= c('NOS', 'tidyverse')
) %dopar% {
  subgroup_list = construct_near_oracle_subgroup_path(n, num_candidates, max_rank, leak_fun)
  subgroup_list
}

stopCluster(my.cluster)

for (i in seq_along(N_set)) {
  n = N_set[i]
  name = paste0("l1_100k_subgroups_max", max_order, "_n", n)
  assign(name, subgroup_list_list[[n - min(N_set) + 1]])
  usethis::use_data_raw(name)
}
paste0("data-raw/l1_100k_subgroups_max", max_order, "_n", N_set, ".R") %>% map(source)
