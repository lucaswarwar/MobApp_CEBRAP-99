### Setup ###

source("setup.R")

### Recover dataset #####################################################

pof_design_pos <- readr::read_rds("03_regress_data/pof_design_pof.rds")


#### Regression functions  --------------------------

# Age regression -------------

my_age_reg <- function(y){
  
  message(paste('working on, ', y))
  # y = 'ride-hailing' 
  
  # select survey design 
  temp_design <- pof_design_pos # here I can work on subsets of the survey design (gender, city...)
  
  # regression specification
  specification <- paste0( y, "  ~ faixa_etaria + as.factor(decil_renda)") # keep income fixed
  
  # survey glm model
  reg1 <- survey::svyglm(                     
    formula= as.formula(specification),
    design= temp_design,
    family= binomial,
    na.action = 'na.omit')
  
  # create table with results
  output <- broom::tidy(reg1)
  output <- output %>% 
    dplyr::filter((grepl('faixa_etaria',term))==T) %>% 
    dplyr::mutate(
      group = gsub('faixa_etaria','',term),
      transport = y,
      odds_ratio = exp(estimate),
      int2.5= exp(confint(reg1, level = 0.95)[2:5,1]),
      int97.5=exp(confint(reg1, level = 0.95)[2:5,2]),
      p_value = p.value) %>% 
    dplyr::select(
      group,transport,odds_ratio,int2.5,int97.5,p_value)
  
  return(output)
}

# Age x Sex regression --------------

my_sex_age_reg <- function(y){
  
  message(paste('working on, ', y))
  # y = 'ride-hailing' 
  
  # select survey design 
  temp_design <- pof_design_pos # here I can work on subsets of the survey design (gender, city...)
  
  # regression specification
  specification <- paste0( y, "  ~ sex_age + as.factor(decil_renda) + faixa_etaria") # keep income fixed
  
  # survey glm model
  reg1 <- survey::svyglm(                     
    formula= as.formula(specification),
    design= temp_design,
    family= binomial,
    na.action = 'na.omit')
  
  # create table with results
  output <- broom::tidy(reg1)
  output <- output %>% 
    dplyr::filter((grepl('sex_age',term))==T) %>% 
    dplyr::mutate(
      group = gsub('sex_age','',term),
      transport = y,
      odds_ratio = exp(estimate),
      int2.5= exp(confint(reg1, level = 0.95)[2:10,1]),
      int97.5=exp(confint(reg1, level = 0.95)[2:10,2]),
      p_value = p.value) %>% 
    dplyr::select(group,transport,odds_ratio,int2.5,int97.5,p_value)
  
  return(output)
}

# Race x Sex regression --------------

my_sex_race_reg <- function(y){
  
  message(paste('working on, ', y))
  # y = 'ride-hailing' 
  
  # select survey design 
  temp_design <- pof_design_pos # here I can work on subsets of the survey design (gender, city...)
  
  # regression specification
  specification <- paste0( y, "  ~ sex_race + as.factor(decil_renda)+ faixa_etaria") # keep income fixed
  
  # survey glm model
  reg1 <- survey::svyglm(                     
    formula= as.formula(specification),
    design= temp_design,
    family= binomial,
    na.action = 'na.omit')
  
  # create table with results
  output <- broom::tidy(reg1)
  output <- output %>% 
    dplyr::filter((grepl('sex_race',term))==T) %>% 
    dplyr::mutate(
      group = gsub('sex_race','',term),
      transport = y,
      odds_ratio = exp(estimate),
      int2.5= exp(confint(reg1, level = 0.95)[2:6,1]),
      int97.5=exp(confint(reg1, level = 0.95)[2:6,2]),
      p_value = p.value) %>% 
    dplyr::select(group,transport,odds_ratio,int2.5,int97.5,p_value)
  
  return(output)
}

# Race x Age regression --------------

my_race_age_reg <- function(y){
  
  message(paste('working on, ', y))
  # y = 'ride-hailing' 
  
  # select survey design 
  temp_design <- pof_design_pos # here I can work on subsets of the survey design (gender, city...)
  
  # regression specification
  specification <- paste0( y, "  ~ race_age + as.factor(decil_renda)+ faixa_etaria") # keep income fixed
  
  # survey glm model
  reg1 <- survey::svyglm(                     
    formula= as.formula(specification),
    design= temp_design,
    family= binomial,
    na.action = 'na.omit')
  
  # create table with results
  output <- broom::tidy(reg1)
  output <- output %>% 
    dplyr::filter((grepl('race_age',term))==T) %>% 
    dplyr::mutate(
      group = gsub('race_age','',term),
      transport = y,
      odds_ratio = exp(estimate),
      int2.5= exp(confint(reg1, level = 0.95)[2:15,1]),
      int97.5=exp(confint(reg1, level = 0.95)[2:15,2]),
      p_value = p.value) %>% 
    dplyr::select(group,transport,odds_ratio,int2.5,int97.5,p_value)
  
  return(output)
}

# strata regression --------------

my_strata_reg <- function(y){
  
  message(paste('working on, ', y))
  # y = 'ride-hailing' 
  
  # select survey design 
  temp_design <- pof_design_pos # here I can work on subsets of the survey design (gender, city...)
  
  # regression specification
  specification <- paste0( y, "  ~ strata + as.factor(decil_renda)+ faixa_etaria") # keep income fixed
  
  # survey glm model
  reg1 <- survey::svyglm(                     
    formula= as.formula(specification),
    design= temp_design,
    family= binomial,
    na.action = 'na.omit')
  
  # create table with results
  output <- broom::tidy(reg1)
  output <- output %>% 
    dplyr::filter((grepl('strata',term))==T) %>% 
    dplyr::mutate(
      group = gsub('strata','',term),
      transport = y,
      odds_ratio = exp(estimate),
      int2.5= exp(confint(reg1, level = 0.95)[2:6,1]),
      int97.5=exp(confint(reg1, level = 0.95)[2:6,2]),
      p_value = p.value) %>% 
    dplyr::select(group,transport,odds_ratio,int2.5,int97.5,p_value)
  
  return(output)
}

# Age x Strata regression --------------

my_age_strata_reg <- function(y){
  
  message(paste('working on, ', y))
  # y = 'ride-hailing' 
  
  # select survey design 
  temp_design <- pof_design_pos # here I can work on subsets of the survey design (gender, city...)
  
  # regression specification
  specification <- paste0( y, "  ~ age_strata + as.factor(decil_renda)+ faixa_etaria") # keep income fixed
  
  # survey glm model
  reg1 <- survey::svyglm(                     
    formula= as.formula(specification),
    design= temp_design,
    family= binomial,
    na.action = 'na.omit')
  
  # create table with results
  output <- broom::tidy(reg1)
  output <- output %>% 
    dplyr::filter((grepl('age_strata',term))==T) %>% 
    dplyr::mutate(
      group = gsub('age_strata','',term),
      transport = y,
      odds_ratio = exp(estimate),
      int2.5= exp(confint(reg1, level = 0.95)[2:15,1]),
      int97.5=exp(confint(reg1, level = 0.95)[2:15,2]),
      p_value = p.value) %>% 
    dplyr::select(group,transport,odds_ratio,int2.5,int97.5,p_value)
  
  return(output)
}

# Sex x Strata regression --------------

my_sex_strata_reg <- function(y){
  
  message(paste('working on, ', y))
  # y = 'ride-hailing' 
  
  # select survey design 
  temp_design <- pof_design_pos # here I can work on subsets of the survey design (gender, city...)
  
  # regression specification
  specification <- paste0( y, "  ~ sex_strata + as.factor(decil_renda)+ faixa_etaria") # keep income fixed
  
  # survey glm model
  reg1 <- survey::svyglm(                     
    formula= as.formula(specification),
    design= temp_design,
    family= binomial,
    na.action = 'na.omit')
  
  # create table with results
  output <- broom::tidy(reg1)
  output <- output %>% 
    dplyr::filter((grepl('sex_strata',term))==T) %>% 
    dplyr::mutate(
      group = gsub('sex_strata','',term),
      transport = y,
      odds_ratio = exp(estimate),
      int2.5= exp(confint(reg1, level = 0.95)[2:6,1]),
      int97.5=exp(confint(reg1, level = 0.95)[2:6,2]),
      p_value = p.value) %>% 
    dplyr::select(group,transport,odds_ratio,int2.5,int97.5,p_value)
  
  return(output)
}
# Race x Strata regression --------------

my_race_strata_reg <- function(y){
  
  message(paste('working on, ', y))
  # y = 'ride-hailing' 
  
  # select survey design 
  temp_design <- pof_design_pos # here I can work on subsets of the survey design (gender, city...)
  
  # regression specification
  specification <- paste0( y, "  ~ race_strata + as.factor(decil_renda)+ faixa_etaria") # keep income fixed
  
  # survey glm model
  reg1 <- survey::svyglm(                     
    formula= as.formula(specification),
    design= temp_design,
    family= binomial,
    na.action = 'na.omit')
  
  # create table with results
  output <- broom::tidy(reg1)
  output <- output %>% 
    dplyr::filter((grepl('race_strata',term))==T) %>% 
    dplyr::mutate(
      group = gsub('race_strata','',term),
      transport = y,
      odds_ratio = exp(estimate),
      int2.5= exp(confint(reg1, level = 0.95)[2:9,1]),
      int97.5=exp(confint(reg1, level = 0.95)[2:9,2]),
      p_value = p.value) %>% 
    dplyr::select(group,transport,odds_ratio,int2.5,int97.5,p_value)
  
  return(output)
}

# city regression --------------

my_city_reg <- function(y){
  
  message(paste('working on, ', y))
  # y = 'ride-hailing' 
  
  # select survey design 
  temp_design <- pof_design_pos # here I can work on subsets of the survey design (gender, city...)
  
  # regression specification
  specification <- paste0( y, "  ~ RM + as.factor(decil_renda)+ faixa_etaria") # keep income fixed
  
  # survey glm model
  reg1 <- survey::svyglm(                     
    formula= as.formula(specification),
    design= temp_design,
    family= binomial,
    na.action = 'na.omit')
  
  # create table with results
  output <- broom::tidy(reg1)
  output <- output %>% 
    dplyr::filter((grepl('RM',term))==T) %>% 
    dplyr::mutate(
      group = gsub('RM','',term),
      transport = y,
      odds_ratio = exp(estimate),
      int2.5= exp(confint(reg1, level = 0.95)[2:15,1]),
      int97.5=exp(confint(reg1, level = 0.95)[2:15,2]),
      p_value = p.value) %>% 
    dplyr::select(group,transport,odds_ratio,int2.5,int97.5,p_value)
  
  return(output)
}

#### Apply Regression functions  --------------------------

transport <- list('ride_hailing', 'transporte_pub', 'transporte_ind', 'taxi')

# age 
df_age <- purrr::map(.x= transport, .f=my_age_reg) %>% data.table::rbindlist()
#write.csv(df_age,'03_regress_data/results/df_age.csv')

# income 
#df_income <- purrr::map(.x= transport, .f=my_income_reg) %>% data.table::rbindlist()
#write.csv(df_age,'03_regress_data/results/df_age.csv')

# age + sex 
df_sex_age <- purrr::map(.x= transport, .f=my_sex_age_reg) %>% data.table::rbindlist()
#write.csv(df_sex_age,'03_regress_data/results/df_sex_age.csv')

# sex + race
df_sex_race <- purrr::map(.x= transport, .f=my_sex_race_reg) %>% data.table::rbindlist()
#write.csv(df_sex_race,'03_regress_data/results/df_sex_race.csv')

# age + strata
df_age_strata <- purrr::map(.x= transport, .f=my_age_strata_reg) %>% data.table::rbindlist()
#write.csv(df_age_strata,'03_regress_data/results/df_age_strata.csv')

# sex + strata
df_sex_strata <- purrr::map(.x= transport, .f=my_sex_strata_reg) %>% data.table::rbindlist()
#write.csv(df_sex_strata,'03_regress_data/results/df_sex_strata.csv')

# race + strata
df_race_strata <- purrr::map(.x= transport, .f=my_race_strata_reg) %>% data.table::rbindlist()
#write.csv(df_race_strata,'03_regress_data/results/df_race_strata.csv')

# age + race
#df_race_age <- purrr::map(.x= transport, .f=my_race_age_reg) %>% data.table::rbindlist()
#write.csv(df_race_age,'03_regress_data/results/df_race_age.csv')

# strata
df_strata <- purrr::map(.x= transport, .f=my_strata_reg) %>% data.table::rbindlist()
#write.csv(df_strata,'03_regress_data/results/df_strata.csv')

# city
df_city <- purrr::map(.x= transport, .f=my_city_reg) %>% data.table::rbindlist()
#write.csv(df_city,'03_regress_data/results/df_city.csv')

#################################################################