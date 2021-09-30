# library(NOS)
# library(usethis)
# library(devtools)
# library(tidyverse)
# library(doParallel)
#
# # parallelization parameters
#
# num_cores = parallel::detectCores() - 1
#
# my.cluster <- parallel::makeCluster(
#   num_cores,
#   type = "PSOCK"
# )
#
# print(my.cluster)
#
# doParallel::registerDoParallel(cl = my.cluster)
#
# # parameters
#
#
# leak_fun = leak_linf
# one_sided = TRUE
# max_rank = 10
# max_order = 2^max_rank
# num_candidates = 100000
# N_set = 1:256
#
# subgroup_list_list = foreach(
#   n = N_set,
#   .packages= c('NOS', 'tidyverse')
# ) %dopar% {
#   name = paste0("linf_100k_subgroups_max", max_order, "_n", n)
#   usethis::use_data_raw(name)
#   subgroup_list = construct_near_oracle_subgroup_path(n, num_candidates, max_rank, leak_fun, one_sided)
#   subgroup_list
# }
#
# stopCluster(my.cluster)
#
# for (i in seq_along(N_set)) {
#   n = N_set[i]
#   name = paste0("linf_100k_subgroups_max", max_order, "_n", n)
#   assign(name, subgroup_list_list[[n - min(N_set) + 1]])
# }
# paste0("data-raw/linf_100k_subgroups_max", max_order, "_n", N_set, ".R") %>% map(source)
