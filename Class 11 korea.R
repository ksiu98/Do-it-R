# 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기

# devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)
library(dplyr)
library(ggplot2)
library(ggiraphExtra)

# korpop1 <- rename(korpop1,
#                   pop = 총인구_명,
#                   name = 행정구역별_읍면동)
# str(changeCode(korpop1))

# ggChoropleth(data = korpop1,
#              aes(fill = pop,
#                  map_id = code,
#                  tooltip = name),
#              map =  kormap1,
#              interactive = T)

# str(changeCode(tbc))

ggChoropleth(data = tbc,          # 지도에 표현할 데이터
             aes(fill = NewPts,   # 색깔로 표현할 변수
                 map_id = code,   # 지역 기준 변수
             tooltip = name),     # 지도 위에 표시할 지역명
             map = kormap1,       # 지도 데이터
             interactive = T)