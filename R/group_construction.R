# library(NOS)
# library(usethis)
# library(devtools)
# library(tidyverse)
# library(doParallel)
#
#
# leak_fun = leak_l1
# max_rank = 10
# max_order = 2^max_rank
# num_candidates = 100000
#
# for (n in 5:10) {
#   subgroup_list = construct_near_oracle_subgroup_path(n, num_candidates, max_rank, leak_fun)
#
#   name = paste0("l1_100k_subgroups_max", max_order, "_n", n)
#   assign(name, subgroup_list)
#   usethis::use_data_raw(name)
#
#   print(n)
# }
#
# list.files("data-raw", full.names = TRUE) %>% map(source)
#
#
# foreach()
