# 텍스트 마이닝
library(KoNLP)
library(dplyr)
library(foreign)
library(ggplot2)
library(readxl)

useNIADic()

txt <- readLines("/Users/kimsiwoo/Desktop/WORKSPACE/RSTUDIO/Doit_R-master/Data/oh_my_girl_lyrics.txt")

# 특수문자 제거하기
# install.packages("stringr")
library(stringr)
txt <- str_replace_all(txt, "\\W", " ")

# 명사 추출하기
# extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")

nouns <- extractNoun(txt)                       # 가사에서 명사 추
wordcount <- table(unlist(nouns))                      # 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
df_word <- as.data.frame(wordcount, stringsAsFactors = F)     # 데이터 프레임으로 변환
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)    # 변수명 수정출

df_word <- filter(df_word, nchar(word) >= 2)    # 두 글자 이상 단어 추출

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

# 워드 클라우드 만들기
library(wordcloud)
library(RColorBrewer)
par(family = "AppleGothic")
pal <- brewer.pal(8, "Dark2")   # 단어 색상 목록 만들기
set.seed(1234)                      # 난수 고정하기

wordcloud(words = df_word$word,     # 단어
          freq = df_word$freq,      # 빈도
          min.freq = 2,             # 최소 단어 빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,              # 회전 단어 비율
          scale = c(8,0.6),         # 단어 크기 범위
          colors = pal)             # 색상 목록

#theme_set(theme_gray(base_family='NanumGothic'))  # 글꼴을 나눔고딕으로 하여 한글깨짐 해결
