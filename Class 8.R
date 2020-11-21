# 그래프 만들기
# ggplot2 레이어 구조
# 배경 설정(축) -> 그래프 추가(점, 막대, 선) -> 설정 추가(축 범위, 색, 표식)

# 산점도 만들기
library(ggplot2)

# 배경 설정하기
# ggplot(data = mpg, aes(x = displ, y = hwy))   # x축은 displ, y축은 hwy로 지정해 배경 생성
# ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()    # 배경에 산점도 추가
# ggplot(data = mpg, aes(x = displ, y = hwy)) +
#   geom_point() +
#   xlim(3,6) +
#   ylim(10,30)
# x축 범위 3~6, y축 범위 10~30 지정

# 막대 그래프 - 집단간 차이 표현하기
# 집단별 평균표 만들기
library(dplyr)
# df_mpg <- mpg %>%
#   group_by(drv) %>%
#   summarise(mean_hwy = mean(hwy))
# ggplot(data = df_mpg, aes(x=drv, y=mean_hwy)) + geom_col()
# ggplot(data = df_mpg, aes(x=reorder(drv, -mean_hwy), y=mean_hwy)) + geom_col()
# reorder()를 사용하면 막대를 값의 크기 순으로 정렬할 수 있다. -를 붙이면 내림차순


# 빈도 막대 그래프 만들기
# ggplot(data = mpg, aes(x=drv)) + geom_bar()
# 빈도 막대 그래프는 x축만 지정하고 geom_col() 대신 geom_bar()를 사용
# ggplot(data = mpg, aes(x=hwy)) + geom_bar()


# 시계열 그래프 만들기
# ggplot(data = economics, aes(x=date, y=unemploy)) + geom_line()

# 상자 그림 만들기
# ggplot(data = mpg, aes(x=drv, y=hwy)) + geom_boxplot()