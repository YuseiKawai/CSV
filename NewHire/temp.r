# bootstrap analysis
th_a <- c(60,80,50,90,40)
th_b <- c(80,40,50,40,50)

set.seed = 42
N = 10000
mean_boot <- numeric(N)

for (k in 1:N) {
  bth_a <- mean(sample(th_a, 5, replace = TRUE))
  bth_b <- mean(sample(th_b, 5, replace = TRUE))
  mean_boot[k] <- (bth_a - bth_b)
}

th_hist <- function(x) {
  tibble(x) %>%
    ggplot() +
    aes(x) +
    geom_histogram(bins = 20, alpha = 0.8, color = "gray") +
    stat_bin(aes(y = cumsum(cnt <<- ..count..) / sum(..count..) * max(..count..)), 
             geom = "line", bins = 20, size = 1.3, color = "hotpink") +
    scale_y_continuous(sec.axis = sec_axis(~ . / max(cnt) * 100, name = "Cumulative percentage[%]")) +
    xlab("差額（万円）")+ 
    labs(title = "既存治療技術と新治療技術の薬剤費の差") +
    theme(legend.position = "none")
}

th_hist(mean_boot)
