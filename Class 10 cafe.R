# 크롤링 및 텍스트 마이닝
library(rvest)
library(dplyr)

basic_url <- 'http://https://m.cafe.daum.net/-ohmygirl/XthE?prev_page=5&firstbbsdepth=022eC&lastbbsdepth=022do&page='

urls <- NULL
for(x in 0:5){
  urls[x+1] <- paste0(basic_url, as.character(x*5+1))
  }

links <- NULL
for(url in urls){
  html <- read_html(url)
  links <- c(links, html %>% html_nodes('.searchCont') %>% html_nodes('a') %>% html_attr('href') %>% unique())
  }
links <- links[-grep("pdf", links)]

txts <- NULL
for(link in links){
  html <- read_html(link)
  txts <- c(txts, html %>% html_nodes('.article_txt') %>% html_text())
  }

write.csv(txts, "text.csv")
