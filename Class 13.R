# 통계 분석 기법을 이용한 가설 검정
# t 검정 - 두 집단의 평균 비교

mpg <- as.data.frame(ggplot2::mpg)
library(dplyr)
mpg_diff <- mpg %>%
  select(class, cty) %>%
  filter(class %in% c("compact", "suv"))

# head(mpg_diff)
# table(mpg_diff$class)

# t.test(data=mpg_diff, cty ~ class, var_equal = T)

# mpg_diff 데이터를 지정하고 ~ 기호를 이용해 비교할 값인 cty 변수와 비교할 집단인  class 변수를 지정.
# t 검정은 비교하는 집단의 분산이 같은지 여부에 따라 적용하는 공식이 다름
# 여기서는 집단간 분산이 같다고 가정하고 var.equal = T 를 지정
# 유의확률 5%를 판단기준으로 삼고, p값이 0.05 미만이면 집단간 차이가 통계적으로 유의하다고 판단
# 분석 결과 : compact 와 suv 간 평균 도시 연비 차이가 통계적으로 유의하다
# suv보다 compact의 도시연비가 더 높다고 할수 있다.

mpg_diff2 <- mpg %>%
  select(fl, cty) %>%
  filter(fl %in% c("r", "p"))  # r:regular, p:premium

# table(mpg_diff2$fl)

# t.test(data = mpg_diff2, cty ~ fl, var.equal = T)

# p값이 0.05이상이므로, 일반 휘발유의 고급 휘발유를 사용하는 자동차 간 도시 연비 차이가 통계적으로 유의x
# 따라서, 고급 휘발유의 연비 평균이 더 높지만 이차이는 우연히 발생했을 가능성이 큼




# 상관분석 - 두 변수의 관계성 분석
# 실업자 수와 개인 소비 지출의 상관관계
economics <- as.data.frame(ggplot2::economics)
cor.test(economics$unemploy, economics$pce)
# p값이 0.05 미만이라 실업자 수와 개인 소비 지출의 상관이 통계적으로 유의함
# 상관계수는 양수 0.61이므로, 실업자계 수와 개인 소비 지출은 한 변수가 증가하면 다른 변수가 증가하는 정비례관

# 상관행렬 히트맵 만들기
# head(mtcars)

car_cor <- cor(mtcars)    # 상관행렬 생성
# round(car_cor, 2)   # 소수점 셋째 자리에서 반올림해 출력

install.packages("corrplot")
library(corrplot)
# corrplot(car_cor)
# corrplot(car_cor, method = "number")    # 원대신 상관계수로 표현

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD",
                          "#4477AA"))

corrplot(car_cor,
         method = "color",        # 색깔로 표현
         col = col(200),          # 색상 200개 선정
         type = "lower",          # 왼쪽 아래 행렬만 표시
         order = "hclust",        # 유사한 상관계수끼리 군집화
         addCoef.col = "black",   # 상관계수 색깔
         tl.col = "black",        # 변수명 색깔
         tl.srt = 45,             # 변수명 45도 기울임
         diag = F)                # 대각 행렬 제외