library(NOS)
library(usethis)
library(devtools)
library(tidyverse)

# P = 1:12
#
# for (i in P) {
#   oracle_subgroup = construct_oracle_subgroup(2^i)
#   name = paste0("subgroup_oracle_", 2^i)
#   assign(name, oracle_subgroup)
#
#   usethis::use_data_raw(name)
# }
#
# list.files("data-raw", full.names = TRUE) %>% map(source)
#
#
# for (i in 1:12) {
#   name = paste0("subgroup_oracle_", 2^i)
#   negative_subgroup = construct_neg_subgroup(get(name))
#
#   name_neg = paste0("subgroup_neg_", 2^(i+1))
#   assign(name_neg, negative_subgroup)
#
#   usethis::use_data_raw(name_neg)
# }
#
# list.files("data-raw", full.names = TRUE)[1:12] %>% map(source)

max_rank = 10
max_order = 2^max_rank

num_candidates = 100000
for (n in 17:64) {
  temp_list = list()
  subgroup = NULL
  counter = 1
  for (ii in 2^(1:max_rank)) {
    if (2^n < ii) {
      break
    }

    subgroup = construct_near_oracle_subgroup(n, num_candidates, ii, leak_l1,
                                                group = construct_oracle_subgroup(n, ii))


    temp_list[[counter]] = subgroup
    counter = counter + 1
  }

  name = paste0("l1_100k_subgroups_max", max_order, "_n", n)
  assign(name, temp_list)
  usethis::use_data_raw(name)

  print(n)
}

list.files("data-raw", full.names = TRUE) %>% map(source)
