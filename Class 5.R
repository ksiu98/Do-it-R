# 데이터 파악하기
# head() - 데이터 앞부분 파악하기
# exam <- read.csv("csv_exam.csv")
# head(exam)   앞에서 부터 6행까지 출력
# head(exam, 10)    앞에서부터 10행까지 출력

# tail() - 데이터 뒷부분 확인하기
# tail(exam)    뒤에서부터 6행까지 출력
# tail(exam, 10)  뒤에서부터 10행까지 출력

# View(exam)    데이터 뷰어 창에서 exam 데이터 확인

# dim(exam)     데이터가 몇 행, 몇 열로 구성되어 있는지 알아보기

# str(exam)     데이터 속성 확인

# summary(exam) 요약 통계량 산출하기

# mpg 데이터 파악하기
# mpg <- as.data.frame(ggplot2::mpg)
# ggplot2의 mpg 데이터를 데이터 프레임 형태로 불러오기      ::는 특정 패키지에 들어있는 함수나 데이터를 지정할수 있슴.

# 변수명 바꾸기
# df_raw <- data.frame(var1 = c(4,3,8),
#                     var2 = c(2,6,1))
#df <- df_raw
# df_new <- df_raw
# df_new <- rename(df_new, v2 = var2)     # 순서 중요!!  바꾸고자하는 이름 > 원래이름

# 파생변수 만들기
# df$var_sum <- df$var1 + df$var2     # var_sum 파생변수 생성
# df$var_mean <- df$var_sum/2         # var_mean 파생변수 생성

library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
mpg$total <- (mpg$cty + mpg$hwy)/2    # 도시 연비와 고속도로 연비로 통합 연비 산출
# summary(mpg$total)
# hist(mpg$total)
# 연비가 20 이상인 자동차에 합격판정 내리려면....
#mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
# 빈도표로 합격판정 자동차 수 확인
#table(mpg$test)     # 연비합격 빈도표 생성
#qplot(mpg$test)

# 중첩조건문 활용
mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B","C"))
# table(mpg$grade)
qplot(mpg$grade)