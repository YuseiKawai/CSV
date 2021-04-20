housing <- 
  read.table("http://www.jaredlander.com/data/housing.csv",
             sep = ",", header = TRUE, stringsAsFactors = FALSE)
housing <- housing %>% set_names( c("Neighborhood", "Class", "Units", "YearBuilt", 
                        "SqFt", "Income", "IncomperSqFt", "Expence",
                        "ExpencePerSqFt", "NetIncom", "Value", "ValuePerSqFt",
                        "Boro"))
## ヒストグラム作成
ggplot(housing, aes(x = ValuePerSqFt)) +
  geom_histogram(binwidth = 10) +
  labs(x = "Value per Square Foot")
## Boroごとにマッピング
housing %>%
  ggplot() +
  aes(x = ValuePerSqFt, fill = Boro) +
  geom_histogram(binwidth = 10) +
  labs(x = "Value per Squre Foot")

housing %>%
  ggplot() +
  aes(x = ValuePerSqFt, fill = Boro) +
  geom_histogram(binwidth = 10) +
  labs(x = "Value per Squre Foot") +
  facet_wrap(~Boro)
## 面積とユニット数
housing %>%
  ggplot() +
  aes(x = SqFt) +
  geom_histogram()
housing %>%
  filter(Units < 1000) %>%
  ggplot() +
  aes(x = SqFt) + geom_histogram()

## 散布図による外れ値の検討
housing %>% 
  ggplot() +
  aes(x = SqFt, y = ValuePerSqFt) +
  geom_point()
sum(housing$Units >= 1000)

## 外れ値を除く
housing <- housing %>%
  filter(Units < 1000)
