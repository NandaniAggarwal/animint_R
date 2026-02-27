library(animint2)
library(dplyr)

n <- 50
max_iter <- 15
x <- seq(0, 10, length.out = n)
y <- sin(x) + rnorm(n, sd = 0.3)
df <- data.frame(x = x, y = y)

curves_df <- data.frame()
error_df <- data.frame()

for(i in 1:max_iter){
  idx <- sample(1:n, n, replace = TRUE)
  sample_df <- df[idx, ]
  fit <- lowess(sample_df$x, sample_df$y, f = 0.3)
  
  curves_df <- rbind(curves_df, data.frame(
    iteration = i, x = fit$x, y = fit$y
  ))
  
  error_df <- rbind(error_df, data.frame(
    iteration = i, mean_y = mean(fit$y)
  ))
}

plot_lowess <- ggplot() +
  geom_point(data = df, aes(x = x, y = y), alpha = 0.5) +
  geom_line(data = curves_df, aes(x = x, y = y), 
            color = "blue", size = 1.5, showSelected = "iteration") +
  labs(title = "LOWESS Curve Bootstrapping", x = "X", y = "Y") +
  theme_minimal()

plot_iter <- ggplot() +
  geom_tallrect(data = error_df, 
                aes(xmin = iteration - 0.5, xmax = iteration + 0.5),
                clickSelects = "iteration", alpha = 0.2) +
  geom_line(data = error_df, aes(x = iteration, y = mean_y)) +
  labs(title = "Average Trend Level per Iteration", x = "Iteration", y = "Mean Y") +
  theme_minimal()

viz <- animint(
  curve = plot_lowess,
  trend = plot_iter,
  time = list(variable = "iteration", ms = 1200),
  title = "Bootstrapping LOWESS Port",
  source="https://github.com/NandaniAggarwal/animint_R/blob/main/bootlowess.R"
)

viz

if(FALSE){
  animint2pages(viz, "boot.lowess_animation_R")
}
