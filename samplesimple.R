library(animint2)
library(dplyr)

grid_size <- 10
pop_df <- expand.grid(x = 1:grid_size, y = 1:grid_size)
pop_df$id <- 1:nrow(pop_df)
max_iter <- 10
sample_size <- 15

sampling_history <- data.frame()
stats_df <- data.frame()

for(i in 1:max_iter){
  selected_ids <- sample(pop_df$id, sample_size)
  temp_pop <- pop_df
  temp_pop$iteration <- i
  temp_pop$selected <- ifelse(temp_pop$id %in% selected_ids, "Yes", "No")
  sampling_history <- rbind(sampling_history, temp_pop)
  stats_df <- rbind(stats_df, data.frame(iteration = i, count = sample_size))
}

plot_grid <- ggplot() +
  geom_point(data = sampling_history, aes(x = x, y = y, color = selected), 
             size = 5, showSelected = "iteration") +
  scale_color_manual(values = c("No" = "grey80", "Yes" = "red")) +
  labs(title = "Simple Random Sampling", x = "X Grid", y = "Y Grid") +
  theme_minimal()

plot_bar <- ggplot() +
  geom_tallrect(data = stats_df, 
                aes(xmin = iteration - 0.5, xmax = iteration + 0.5),
                clickSelects = "iteration", alpha = 0.2) +
  geom_bar(data = stats_df, aes(x = iteration, y = count), stat = "identity", fill = "darkgreen") +
  labs(title = "Sampling Log", x = "Iteration", y = "Count") +
  theme_minimal()

viz <- animint(
  grid = plot_grid,
  selector = plot_bar,
  time = list(variable = "iteration", ms = 1500),
  title = "Simple Random Sampling Port",
  source="https://github.com/NandaniAggarwal/animint_R/blob/main/samplesimple.R"
)

viz

if(FALSE){
  animint2pages(viz, "sample.simple_R")
}
