


gss %>%
  specify(college ~ partyid, success = "dgree") %>%
  hypothesise(null = "independence")

gss %>%
  specify(college ~ partyid, success = "degree") %>%
  hypothesise(null = "independence")

gss %>%
  ggplot() +
  geom_histogram(x = hours)

gss %>%
  ggplot() +
  geom_histogram(aes(x=hours))


mu01 <- c(1,2,3,4,5,6,7,8,9,10)
mu01 %>%
  tibble()

mu01 %>%
  tibble() %>%
  specify(response = .) %>%
  hypothesise(null = "point", mu = 5 ) %>%
  calculate(stat = "t")

mu01 <- c(1,2,3,4,5,6,7,8,9,10) %>%
  tibble()
colnames(mu01) <- "sample"

mu01 %>%
  tibble() %>%
  specify(response = "sample")

mu01 %>%
  tibble() %>%
  specify(response = sample)

mu01 %>%
  specify(response = sample) %>%
  hypothesise(null = "point", mu = 5 ) %>%
  calculate(stat = "t")

t_test(mu01, response = sample, mu = 5)

sample(1:6, 1, replace = TRUE)


TASK_STRING_00 <- "stressed"
stringr::str_split(string = TASK_STRING_00, pattern = "") %>% 
  unlist %>%
  rev %>%
  stringr::str_c(collapse = "")


# 郵便番号のDL
y_file <- tempfile(fileext = "zip")
download.file(url = "http://www.post.japanpost.jp/zipcode/dl/roman/ken_all_rome.zip",
              destfile = y_file)
# file展開とスペースの削除
unzip(zipfile = y_file, exdir = tempdir(), overwrite = TRUE)
(file.path <- list.files(tempdir()) %>%  
    grep(pattern = ".csv", ., value = TRUE, ignore.case = TRUE) %>% 
    paste(tempdir(), ., sep = "/"))

# 読み込みとデータ整形（列名付与と文字化け対策）
df_post <- fread(input = file.path, header = FALSE)
setnames(df_post, c("Postal Code", "都道府県名", "市区町村名", "町域名", 
                    "都道府県名roman", "市区町村名roman", "町域名roman"))

## test 文字化け治りを確認
df_post %<>%
  mutate_each(funs(iconv(x = ., from = "cp932", to = "utf-8")), -contains("roman"))
df_post %<>% 
  dplyr::mutate(町域名 = sub(pattern = "以下に掲載がない場合", replacement = NA, x = 町域名)) %>% 
  dplyr::mutate_each(funs(gsub("[[:space:]]", "", x = .)), c(市区町村名, 町域名))

## roman を削除
df_post_aws <- df_post %>%
  select(-c("都道府県名roman", "市区町村名roman", "町域名roman"))
df_post_aws %<>%
  rename(postalcode = "郵便番号")

# データテーブルを保管
write.csv(df_post,
          file = "jp_post_address.csv")
write_csv(df_post_aws,
          file = "jp_post_address_aws.csv") #とりあえずこっちだけでOK


# sampleテーブル作成
postalcode <- c("140ー0004", "2770835", "325-0043")
address1 <- c("minamishinagawa4-2-38", "1170-282matugasaki", "zz3-8zzzz")
aws_data <- tibble(postalcode, address1)

# データクレンジング
aws_data_c <- aws_data %>%
  mutate(postalcode = str_replace(postalcode, "-|ー|[:blank:]", "")) %>%
  print()

aws_data %>%
  mutate(postalcode = str_replace(postalcode, "-|ー|[:blank:]", "")) %>%
  left_join(df_post_aws, by = "postalcode") %>%
  mutate(banchextract = str_extract_all(address1, "[:digit:]|[:punct:]")) 
  
test <- aws_data %>%
  mutate(postalcode = str_replace(postalcode, "(-|ー)", "")) %>%
  left_join(df_post_aws, by = "postalcode") %>%
  mutate(banchextract = str_extract_all(address1, "[:digit:]|[:punct:]")) 

test %>%
  mutate(banchextract = union(banchextract))

test1 %>%
  mutate(banchextract = str_replace(banchextract, "[:punct:]", "")) %>%
  print()
  


# 完成形
aws_data %>%
  mutate(postalcode = str_replace(postalcode, "-|ー|[:blank:]", "")) %>%
  left_join(df_post_aws, by = "postalcode") %>%
  mutate(banchextract = str_extract_all(address1, "[:digit:]|[:punct:]")) %>%
  mutate(banchextract = str_replace_all(
    sapply(banchextract, toString),",|[:space:]", ""))

tibble(
  postalcode = c("140ー0004", "2770835", "325-0043"),
  address1 = c("minamishinagawa4-2-38", "1170-282matugasaki", "zz3-8zzzz")
)

bc2 <-
  tibble(
  qu_2 = c(2.8, 2.7, 2.7, 2.7, 3.3, 2.5, 2.7, 2.1, 2.9, 2.2),
  sc_2 = c(78, 80, 79, 75, 79, 79, 80, 80, 77, 76),
  ec_2 = c(53, 56, 54, 53, 55, 56, 57, 58, 55, 54),
  mod_2 = c(68, 70, 68, 70, 70, 70, 71, 72, 72, 71),
  dec_2 = c(48, 47, 46, 46, 53, 43, 46, 39, 48, 39),
  qz_2 = c(7, 9, 8, 9, 7, 6, 6, 6, 7, 8)
 )

bc3 <- 
  tibble(
    qu_3 = c(2.6, 2.6, 2.3, 2.8, 2.6, 1.5, 1.9, 2.7, 2.6, 2.8),
    sc_3 = c(79, 79, 79, 80, 80, 79, 80, 79, 78, 80),
    ec_3 = c(53, 53, 54, 54, 53, 53, 53, 53, 54, 55),
    mod_3 = c(68, 67, 68, 68, 67, 67, 67, 67, 69, 69),
    dec_3 = c(45, 45, 41, 52, 45, 31, 36, 47, 45, 48),
    qz_3 = c(8, 9, 7, 9, 6, 9, 8, 8, 8, 6)
  )

bc23 <- bind_cols(bc2, bc3)

bc2 %>%
  specify(response = qu_2) %>%
  hypothesise(null = "point", mu = 2.8) %>%
  generate(reps = 10000, type = "bootstrap")



null_dis2 <- bc2 %>%
  specify(response = qu_2) %>%
  hypothesise(null = "point", mu = 2.8) %>%
  generate(reps = 10000, type = "bootstrap") %>%
  calculate(stat = "mean")

post_est2 <- bc2 %>%
  specify(response = qu_2) %>%
  calculate(stat = "mean")

null_dis2 %>%
  visualize() +
  shade_p_value(obs_stat = post_est, direction = "two-sided")

null_dis2 %>%
  get_p_value(obs_stat = post_est2, direction = "two-sided")

# start with the null distribution
null_dis2 %>%
  get_confidence_interval(point_estimate = post_est2,
                          level = .95,
                          type = "se")
