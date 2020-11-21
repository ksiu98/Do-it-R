# 데이터 정제 - 빠진 데이터, 이상한 데이터 제거하기
# 빠진 데이터를 찾아라 - 결측치 정제하기

# df <- data.frame(sex = c("M", "F", NA, "M", "F"),
#                  score = c(5,4,3,4, NA))

# 결측치 확인하기
# is.na(df)     # 결측치 확인
# table(is.na(df))  # 결측치 빈도 출력
# mean(df$score)    # 결측치가 있으면 산출 안됨

# 결측치 제거하기
library(dplyr)
# df %>% filter(is.na(score))   # score가 NA인 데이터만 출력
# df %>% filter(!is.na(score))    # score 결측치를 제거한 데이터 출력
# df %>% filter(!is.na(score) & !is.na(sex))  # score, sex 결측치 제거

# 결측치가 하나라도 있으면 제거하기
# df_nomiss <- na.omit(df)      # 모든 변수에 결측치 없는 데이터 추출
# na.omit()을 이용하면 변수를 지정하지 않고 결측치가 있는 행을 모두 제거 할수 있슴.
# 하지만 필요한 행까지 제거될수 있으므로 filter()로 분석에 필요한 변수들만 남기고 결측치 제거하는것이 효과적.

# 함수의 결측치 제외기능 이용하기
# mean(df$score, na.rm = T)     # 결측치 제외하고 평균 산
exam <- read.csv("/Users/kimsiwoo/Desktop/WORKSPACE/RSTUDIO/Doit_R-master/Data/csv_exam.csv")
# exam[c(3,8,15), "math"] <- NA   # 3,8,15행의 math에 NA 할당
# 참고) []는 데이터의 위치를 지칭하는 역할.   [ 행위치, 열위치 ]

# exam %>% summarise(mean_math = mean(math))    # 결측치 있어서 산출 불가
# exam %>% summarise(mean_math = mean(math, na.rm = T))    # 결측치 제회하고 평균 산출
# exam %>% summarise(mean_math = mean(math, na.rm = T),
#                    sum_math = sum(math, na.rm = T),
#                     median_math = median(math, na.rm = T))


# 결측치 대체하기
# exam$math <- ifelse(is.na(exam$math), 55, exam$math)    # 결측치면 55로 대체
# table(is.na(exam$math))

# 이상치 제거하기 - 존재할 수 없는 값
# outlier <- data.frame(sex = c(1,2,1,3,2,1),
#                  score = c(5,4,3,4,2,6))

# 이상치 확인하기
# table(outlier$sex)
# table(outlier$score)

# outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)    # sex가 3이면 결측치
# outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)   # 점수가 5보다크면 결측치

# outlier %>%
#   filter(!is.na(sex) & !is.na(score)) %>%
#   group_by(sex) %>%
#   summarise(mean_score = mean(score))

mpg <- as.data.frame(ggplot2::mpg)
# boxplot(mpg$hwy)$stats    # 상자 그림 통계치 출력
# 통계치는 다섯가지로 나오는데 위에서 부터, 아래쪽 극단치 경계, 1사분위수, 중앙값, 3사분위수, 위쪽 극단치 경계

# 결측 처리하기
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy >37, NA, mpg$hwy)
# table(is.na(mpg$hwy))
mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))