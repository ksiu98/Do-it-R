# 트위터 텍스트 마이닝
library(base64enc)
library(KoNLP)
library(NIADic)
# library(RmecabKo)
library(rtweet)
library(tidyverse)
library(igraph)
library(twitteR)
library(reshape2)
library(wordcloud2)
library(tm)

api_key <- "vIyuPExh7CmsDXKgydYx0rITK"
api_secret_key <- "9u1QAfRezqohqpexGFYrTscDDtsT4DYRHYs0Ss5k3tiFfYtgvc"
access_token <- "1326211406769790976-AAwzw246uzfRoCTbGIqNFlR7VASOyi"
access_token_secret <- "iTmQmPzyvFemDgAtjkaefYeFa3eo8AT0I2vpCwwT8Bl7l"
options(httr_oauth_cache = TRUE)
setup_twitter_oauth(api_key,api_secret_key,access_token,access_token_secret)

getCurRateLimitInfo()      ## 어떠한 프레임으로 데이터를 크롤링하는지 알수 있습니다
keyword_ko <- enc2utf8("오마이걸")      ## 오늘은 한글 키워드만 모아서 시각화까지 해봅시다
keyword_ja <- enc2utf8("おまごる")    ## 일본어 키워드 입니다
keyword_en1 <- enc2utf8("OHMYGIRL")        ## 영어 키워드 입니다
keyword_en2 <- enc2utf8("ohmygirl")
keyword_en3 <- enc2utf8("OMG")

omg_ko <- searchTwitter(keyword_ko, n=1000, lang="ko", since="2020-11-10", until="2020-11-12")

omg_ko_df <- twListToDF(omg_ko)

# length(omg_ko)
# length(omg_ja)
# length(omg_en)

omg_ko_word <- sapply(omg_ko,function(t) t$getText()) # 텍스트 파일만 추출

omg_ko_words <- omg_ko_word %>% SimplePos09()  # 한글-품사별 정리

# 데이터 셋 만들기
omg_ko_words <- omg_ko_words %>%
                   melt() %>%
                   as_tibble() %>%
                   select(3,1)    ## 3열과 1열 추출

omg_ko_명사 <- omg_ko_words %>%
                  mutate(명사=str_match(value,'([가-힣]+)/N')[,2]) %>%      ## "명사" variable을 만들고 한글만 저장
                  na.omit() %>%            ## ([가-힣]+)/P') 한글 중 명사(N)만을 선택하는 정규표현식
                  mutate(글자수=str_length(명사)) %>%   ## "글자수" variable을 만듭니다
                  filter(str_length(명사)>=2)              ## 2글자 이상만 추려냅니다

omg_ko_용언 <- omg_ko_words %>%
                   mutate(용언=str_match(value,'([가-힣]+)/P')[,2]) %>%   ## "용언" variable을 만들고 한글만 저장
                   na.omit() %>%                           ## ([가-힣]+)/P') 한글 중 용언(P)만을 선택하는 정규표현식
                   mutate(글자수=str_length(용언)) %>%        ## "글자수" variable을 만듭니다
                   filter(str_length(용언)>=2)                         ##  2글자 이상만 추려냅니다

omg_ko_수식언 <- omg_ko_words %>%
                mutate(수식언=str_match(value,'([가-힣]+)/M')[,2]) %>%    ## "수식언" variable을 만들고 한글만 저장
                na.omit() %>%                                ## ([가-힣]+)/M') 한글 중 수식언(M)만을 선택하는 정규표현식
                mutate(글자수=str_length(수식언)) %>%  ## "글자수" variable을 만듭니다
                filter(str_length(수식언)>=2)                 ##  2글자 이상만 추려냅니다

omg_ko.명사 <- omg_ko_명사$명사
omg_ko.명사 <- omg_ko.명사 %>% unlist()
omg_ko.명사 <- omg_ko.명사 %>% as.vector()
omg_ko.명사 <- str_replace_all(omg_ko.명사, "[^[:alnum:][:blank:]+?&/\\-]","")          ## 특수문자를 처리합니다
omg_ko.명사 <- str_replace_all(omg_ko.명사, "^.{1}$","")         ## 혹시라도  들어갈 수 있는 한글자를 처리합니다
omg_ko.명사 <- str_replace_all(omg_ko.명사, "\\d+","")
omg_ko.명사 <- omg_ko.명사 %>% as.list()
omg_ko.명사[omg_ko.명사 ==""] <- NULL
omg_ko.명사 <- omg_ko.명사 %>% unlist()                         ## 공백을 제거합니다
omg_ko.명사 <- omg_ko.명사 %>% as.data.frame()

omg_ko.용언 <- omg_ko_용언$용언
omg_ko.용언 <- omg_ko.용언 %>% unlist()
omg_ko.용언 <- omg_ko.용언 %>% as.vector()
omg_ko.용언 <- str_replace_all(omg_ko.용언, "[^[:alnum:][:blank:]+?&/\\-]","")          ## 특수문자를 처리합니다
omg_ko.용언 <- str_replace_all(omg_ko.용언, "^.{1}$","")      ## 혹시라도  들어갈 수 있는 한글자를 처리합니다
omg_ko.용언 <- omg_ko.용언 %>% as.list()
omg_ko.용언[omg_ko.용언 ==""] <- NULL
omg_ko.용언 <- omg_ko.용언 %>% unlist()                    ## 공백을 제거합니다
omg_ko.용언 <- omg_ko.용언 %>% as.data.frame()

omg_ko.수식언 <- omg_ko_수식언$수식언
omg_ko.수식언 <- omg_ko.수식언 %>% unlist()
omg_ko.수식언 <- omg_ko.수식언 %>% as.vector()
omg_ko.수식언 <- str_replace_all(omg_ko.수식언, "[^[:alnum:][:blank:]+?&/\\-]","")          ## 특수문자를 처리합니다
omg_ko.수식언 <- str_replace_all(omg_ko.수식언, "^.{1}$","")   ## 혹시라도  들어갈 수 있는 한글자를 처리합니다
omg_ko.수식언 <- omg_ko.수식언 %>% as.list()
omg_ko.수식언[omg_ko.수식언 ==""] <- NULL
omg_ko.수식언 <- omg_ko.수식언 %>% unlist()                ## 공백을 제거합니다
omg_ko.수식언 <- omg_ko.수식언 %>% as.data.frame()

omg_ko <- bind_rows(omg_ko.명사,omg_ko.용언,omg_ko.수식언)

omg_ko_count <- table(omg_ko)                       ## 객체별 빈도를 셉니다
omg_ko_count <- sort(omg_ko_count, decreasing = TRUE)         ##내림차순 정렬 합니다
omg_ko_count50 <- omg_ko_count[1:50]            ## Top 30까지 추립니다

omg_ko_count50df <- omg_ko_count50 %>% as.data.frame()             ## data frame변환하고 그래프 작성
# ggplot(omg_ko_count30df, aes(x=omg_ko, y=Freq)) + geom_bar(stat="identity")
# theme_set(theme_gray(base_family="AppleGothic"))

omg_ko_count50df <- omg_ko_count50df[-1,]
library(wordcloud)
library(RColorBrewer)
par(family = "AppleGothic")

# omg_ko_count %>% wordcloud2()
# omg_ko_count[2:length(omg_ko_count)] %>% wordcloud2()
 pal <- brewer.pal(8, "Dark2")   # 단어 색상 목록 만들기
 set.seed(1234)                      # 난수 고정하기

wordcloud(words = omg_ko_count50df$omg_ko,     # 단어
           freq = omg_ko_count50df$Freq,      # 빈도
           min.freq = 2,             # 최소 단어 빈도
           max.words = 500,          # 표현 단어 수
           random.order = F,         # 고빈도 단어 중앙 배치
           rot.per = .1,              # 회전 단어 비율
           scale = c(6,0.4),         # 단어 크기 범위
           colors = pal)             # 색상 목록
