library(animint2)
library(dplyr)


set.seed(123)
n <- 30
max_iter <- 20
original_data <- rnorm(n, mean = 10, sd = 2)
original_df <- data.frame(id = 1:n, val = original_data, type = "Original", y_val = 1)

boot_samples <- data.frame()
boot_means <- data.frame()


for(i in 1:max_iter){
  idx <- sample(1:n, n, replace = TRUE)
  resampled_vals <- original_data[idx]
  
  
  boot_samples <- rbind(boot_samples, data.frame(
    iteration = i,
    val = resampled_vals,
    id = 1:n,
    y_val = runif(n, 1.2, 2) # Random Y for visual distribution
  ))
  
  boot_means <- rbind(boot_means, data.frame(
    iteration = i,
    mean_val = mean(resampled_vals)
  ))
}

#  Plots
plot_dist <- ggplot() +
  # Original Data Points
  geom_point(data = original_df, aes(x = val, y = y_val), 
             color = "grey", alpha = 0.5, size = 3) +
  # Bootstrap Sample Points
  geom_point(data = boot_samples, aes(x = val, y = y_val), 
             color = "blue", size = 3, showSelected = "iteration") +
  scale_y_continuous(limits = c(0, 3)) +
  labs(title = "Original Data (Grey) vs Bootstrap Sample (Blue)", 
       x = "Value", y = "Density") +
  theme_minimal()

plot_error <- ggplot() +
  geom_tallrect(data = boot_means, 
                aes(xmin = iteration - 0.5, xmax = iteration + 0.5),
                clickSelects = "iteration", alpha = 0.2) +
  geom_line(data = boot_means, aes(x = iteration, y = mean_val), color = "red") +
  geom_point(data = boot_means, aes(x = iteration, y = mean_val), 
             showSelected = "iteration", size = 3) +
  labs(title = "Mean of Bootstrap Sample over Iterations", x = "Iteration", y = "Sample Mean") +
  scale_x_continuous(breaks = 1:max_iter) +
  theme_minimal()

viz <- animint(
  distribution = plot_dist,
  means = plot_error,
  time = list(variable = "iteration", ms = 1000),
  title = "Bootstrapping i.i.d Data Port",
  source="https://github.com/NandaniAggarwal/animint_R/blob/main/bootid.R"
)

viz

if(FALSE){
  animint2pages(viz, "boot.iid_animation_R")
}
