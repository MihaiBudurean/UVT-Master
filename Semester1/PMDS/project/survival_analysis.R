rm(list = ls(all.names = TRUE))
gc()
options(max.print = .Machine$integer.max, scipen = 999, stringsAsFactors = F, dplyr.summarise.inform = F) # avoid truncated output in R console and scientific notation

set.seed(123)

library(tidyverse)
library(survival)
library(ggsurvfit)
library(survminer)

my_theme <- theme(plot.title = element_text(size = rel(2)),
                            panel.grid.major.y = element_line(colour = 'gray'),
                            panel.grid.minor.y = element_line(colour = 'gray'),
                            panel.grid.major.x = element_blank(),
                            panel.grid.minor.x = element_blank(),
                            plot.background = element_rect(fill = NULL, 
                                                           colour = 'white'),
                            panel.background = element_rect(fill = 'white'),
                            axis.line = element_line(colour = 'black', 
                                                     linewidth = 1),
                            axis.text = element_text(colour = "black", 
                                                     face = 'bold'),
                            axis.text.x = element_text(size = rel(1)),
                            axis.text.y = element_text(size = rel(1)),
                            axis.title = element_text(size = rel(1.2)),
                            axis.ticks = element_line(colour = 'black', 
                                                      linewidth = 1.2),
                            legend.position = "bottom",
                            legend.margin = margin(6, 6, 6, 6),
                            legend.title = element_text(face = 'bold'),
                            legend.background = element_blank(),
                            legend.box.background = element_rect(colour = "black"))

output_file <- file('output.txt', 'w')

delimitator <- function() {
  write(paste(rep("-", 80), collapse = ""), output_file)
}

output <- function(result) {
  writeLines(capture.output(result), output_file)
}

# ----- Dataset Information -----

# Description
# The rotterdam data set includes 2982 primary breast cancers patients whose
# records were included in the Rotterdam tumor bank.

# Format
# pid    - patient identifier
# year   - year of surgery
# age    - age of surgery
# meno   - menopausal status (0 = premenopausal, 1 = postmenopausal)
# size   - tumor size, a factor with levels <= 20, 20 - 50, > 50
# grade  - differentiation grade
# nodes  - number of positive lymph nodes
# pgr    - progresterone receptors (fmol / l)
# er     - estrogen_receptors
# hormon - hormonal treatment (0 = no, 1 = yes)
# chemo  - chemotherapy
# rtime  - days to relapse or last follow-up
# recur  - 0 = no relapse, 1 = relapse
# dtime  - days to death or last follow-up
# death  - 0 = alive, 1 = dead

# For many information run: > ?rotterdam

# ----- Dataset Preparation -----

my_data <- survival::rotterdam

my_data <- my_data %>%
  # mutate(hormon = factor(hormon, levels = c(0, 1), labels = c('no', 'yes'))) %>%
  # mutate(recur = factor(recur, levels = c(0, 1), labels = c('no relapse', 'relapse'))) %>%
  # mutate(meno = factor(meno, levels = c(0, 1), labels = c('premenopausal', 'postmenopausal'))) %>%
  # mutate(death = factor(death, levels = c(0, 1), labels = c('alive', 'dead'))) %>%
  mutate(dtime = dtime / 365.25)

delimitator()
write('Column names for survival::rotterdam dataset:', output_file)
writeLines(colnames(my_data), output_file)
delimitator()

# ----- Censoring Status -----
write('Censoring Status (death values):', output_file)
output(table(my_data$death))
delimitator()

# ----- Time to event -----

# Add date of the surgery and date of the last follow-up
date_samples <- data.frame(
  surgery_date = sample(seq(as.Date('1999/01/01'), 
                            as.Date('2000/01/01'), by = 'day'), 12),
  day_of_last_followup = sample(seq(as.Date('2000/01/01'), 
                                    as.Date('2020/01/01'), by = 'day'), 12))

# Compute the duration between the two dates in years and days
date_samples <- date_samples %>% 
  mutate(os_yrs = as.numeric(as.duration(day_of_last_followup - surgery_date), 
                             'years')) %>%
  mutate(os_days = as.numeric(as.duration(day_of_last_followup - surgery_date), 
                              'days'))

writeLines('Column names for date samples:', output_file)
writeLines(colnames(date_samples), output_file)
delimitator()

# ----- Survival Object -----

survival_object <- Surv(time = my_data$dtime, event = my_data$death)

# ----- Kaplan Meier Curves -----

survival_curve_kmc <- survfit(survival_object ~ 1, data = my_data)
write('Survival Curve used for Kaplan Meier Curves:', output_file)
output(survival_curve_kmc)
delimitator()

km_curve <- ggsurvfit(survival_curve_kmc, linewidth = 1) +
  labs(x = 'Years', y = 'Overall survival') +
  add_confidence_interval() +
  add_risktable() +
  scale_ggsurvfit() + 
  my_theme +
  coord_cartesian(xlim = c(0, 8))

# Estimating survival percent
write('Estimation for survival percent:', output_file)
output(summary(survival_curve_kmc, times = c(0, 0.5, 2, 5, 7))$surv)
delimitator()

png("km_curve.png", width = 690, height = 417)
km_curve +
  geom_vline(xintercept = 1, linetype = 'dashed', colour = 'red', size = 1) +
  geom_hline(yintercept = summary(survival_curve_kmc, times = 5)$surv, 
             linetype = 'dashed', colour = 'red', linewidth = 1) + 
  coord_cartesian(xlim = c(0, 8))
dev.off()

# ----- Log Rank Test -----
write('Table of my_data$chemo:', output_file)
output(table(my_data$chemo))
delimitator()

survival_curve_lrt <- survfit(survival_object ~ chemo, data = my_data)

png("log_rank_test.png", width = 690, height = 417)
ggsurvplot(survival_curve_lrt, data = my_data,
           size = 1,
           palette = c('#E7B800', '#2e9fdf'),
           censor.shape = '|', censor.size = 4,
           conf.int = TRUE,
           pval = TRUE,
           risk.table = TRUE,
           risk.table.col = 'strata',
           legend.labs = list('0' = 'No chemo', '1' = 'Chemo'),
           risk.table.height = 0.25,
           ggtheme = theme_bw())
dev.off()

# p > 0.005 there is no significant difference in survival
# p < 0.005 the difference of survival is significant
# Log Rank Test based on Chemotherapy
lr_test_chemo <- survdiff(survival_object ~ chemo, data = my_data)
write('Log Rank Test based on Chemotherapy:', output_file)
output(lr_test_chemo)
delimitator()

# Log Rank Test based on Hormonal treatment
lr_test_hormon <- survdiff(survival_object ~ hormon, data = my_data)
write('Log Rank Test based on Hormonal Treatment:', output_file)
output(lr_test_hormon)
delimitator()

# ----- Cox Regression Analysis -----

# hazard ratios = exponentiated coefficients
cox_regression <- coxph(survival_object ~ hormon + chemo + size + er + 
                          pgr + nodes + meno + grade + age, data = my_data)

write('Summary of Cox Regression:', output_file)
output(summary(cox_regression))
delimitator()

# Verification of the proportional hazards assumptions

# p-val < 0.05: there is evidence against proportional hazards assumption, 
# HRs are not constant over time

# chisq results: the bigger the value, the stronger violation of assumptions

cox_test <- survival::cox.zph(cox_regression)
write('Verification of the proportional hazards assumptions:', output_file)
output(cox_test)
delimitator()

# Plot for Schoenfeld residuals over time for each covariate

png("cox_regression.png", width = 1380, height = 834)
survminer::ggcoxzph(cox_test, point.size = 0.1)
dev.off()

# ----- Forest Plots -----
png("forest_plots.png", width = 1296, height = 784)
ggforest(cox_regression, data = my_data)
dev.off()

close(output_file)
