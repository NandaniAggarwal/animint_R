library(animint2)
library(dplyr)

strata_data <- data.frame(
  id = 1:60,
  group = rep(c("A", "B", "C"), each = 20),
  val = c(rnorm(20, 5), rnorm(20, 10), rnorm(20, 15))
)

max_iter <- 10
strat_history <- data.frame()
mean_history <- data.frame()

for(i in 1:max_iter){
  sampled <- strata_data %>% group_by(group) %>% sample_n(5)
  temp_sample <- sampled
  temp_sample$iteration <- i
  strat_history <- rbind(strat_history, temp_sample)
  
  iter_summary <- sampled %>% group_by(group) %>% summarize(m = mean(val))
  iter_summary$iteration <- i
  mean_history <- rbind(mean_history, iter_summary)
}

plot_strat <- ggplot() +
  geom_point(data = strata_data, aes(x = group, y = val), color = "grey", alpha = 0.4) +
  geom_point(data = strat_history, aes(x = group, y = val, fill = group), 
             size = 4, shape = 21, showSelected = "iteration") +
  labs(title = "Stratified Sampling", x = "Group", y = "Value") +
  theme_minimal()

plot_means <- ggplot() +
  geom_tallrect(data = mean_history, 
                aes(xmin = iteration - 0.5, xmax = iteration + 0.5),
                clickSelects = "iteration", alpha = 0.2) +
  geom_line(data = mean_history, aes(x = iteration, y = m, color = group)) +
  labs(title = "Mean Tracking", x = "Iteration", y = "Mean") +
  theme_minimal()

viz <- animint(
  sampling = plot_strat,
  means = plot_means,
  time = list(variable = "iteration", ms = 1500),
  title = "Stratified Sampling Port",
  source="https://github.com/NandaniAggarwal/animint_R/blob/main/samplestrat.R"
)

viz

if(FALSE){
  animint2pages(viz, "sample.strat_R")
}
