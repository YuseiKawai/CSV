
# 郵便番号のDL
y_file <- tempfile(fileext = "zip")
download.file(url = "http://www.post.japanpost.jp/zipcode/dl/roman/ken_all_rome.zip",
              destfile = y_file)
# file展開と
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

address2 <- c("東京都品川区南品川4丁目22番地")

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
  
output <- test %>% 
  mutate(banchextract = sapply(banchextract, toString)) %>%
  mutate(banchextract = str_replace_all(banchextract, ",|[:space:]", "")) %>%
  print()


output <- test %>% 
  mutate(banchextract = str_replace_all(
    sapply(banchextract, toString),",|[:space:]", "")) %>%
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
