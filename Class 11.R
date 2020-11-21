# 미국 주별 강력 범죄율 단계 구분도 만들기
# install.packages("ggiraphExtra")
library(ggiraphExtra)
# str(USArrests)
# head(USArrests)
library(tibble)

crime <- rownames_to_column(USArrests, var = "state")
crime$state <- tolower(crime$state)
# str(crime)

# install.packages("maps")
# install.packages("mapproj")

# 미국 주 지도 데이터 준비
library(ggplot2)
states_map <- map_data("state")

# 단계 구분도 만들기
ggChoropleth(data = crime,            # 지도에 표현할 데이터
             aes(fill = Murder,       # 색깔로 표현할 변수
                 map_id = state),     # 지역 기준 변수
             map = states_map,        # 지도 데이터
             interactive = T)         # 인터랙티브
