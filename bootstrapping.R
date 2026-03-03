library(animint2)

set.seed(123)
n <- 30
max_iterations <- 10

original_data <- rnorm(n, mean = 10, sd = 2)

original_df <- data.frame(
  id = 1:n,
  val = original_data,
  type = "Original",
  iteration = 0,
  y = 1
)

boot_samples <- data.frame()
boot_means <- data.frame()

# Run the bootstrap resampling loop
for (i in 1:max_iterations) {
  
  sample_vals <- sample(original_data, n, replace = TRUE)
  
  boot_samples <- rbind(
    boot_samples,
    data.frame(
      id = 1:n,
      val = sample_vals,
      type = "Bootstrap",
      iteration = as.integer(i),
      y = 1
    )
  )
  
  
  boot_means <- rbind(
    boot_means,
    data.frame(
      iteration = as.integer(i),
      mean_val = mean(sample_vals)
    )
  )
}


combined_df <- rbind(original_df, boot_samples)
combined_df$iteration <- as.integer(combined_df$iteration)
boot_means$iteration <- as.integer(boot_means$iteration)


viz <- list(
  bootstrapPlot = ggplot() +
    geom_point(
      data = combined_df,
      aes(x = val, y = y, colour = type),
      showSelected = "iteration",
      clickSelects = "type"
    ) +
    geom_point(
      data = boot_means,
      aes(x = mean_val, y = 1.2),
      showSelected = "iteration",
      size = 4,
      colour = "red"
    ) +
    labs(
      title = "Bootstrap Sampling Animation",
      x = "Value", y = "Distribution"
    ),
  width = list(bootstrapPlot = 400), 
  height = list(bootstrapPlot = 700),
  time = list(variable = "iteration", ms = 1000),
  title="Bootstrap Sampling Animation",
  source="https://github.com/NandaniAggarwal/animint_R/blob/main/bootstrapping.R"
)

viz

if(FALSE){
  animint2pages(viz, "bootstrapping_animation_R")
}
