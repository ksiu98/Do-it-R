# 인터랙티브 그래프
# install.packages("plotly")
library(plotly)

library(ggplot2)
# p <- ggplot(data = mpg, aes(x=displ, y=hwy, col = drv)) + geom_point()

# ggplotly(p)

# p <- ggplot(data=diamonds, aes(x=cut, fill = clarity)) +
#   geom_bar(position = "dodge")

# ggplotly(p)

# install.packages("dygraphs")
library(dygraphs)

economics <- ggplot2::economics
# head(economics)

library(xts)
eco <- xts(economics$unemploy, order.by = economics$date)
# head(eco)

# dygraph(eco) %>% dyRangeSelector()

# 여러값 표현하기
eco_a <- xts(economics$psavert, order.by = economics$date)  # 저축률
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)  # 실업자수

eco2 <- cbind(eco_a, eco_b)       # 데이터 결합
colnames(eco2) <- c("psavert", "unemploy")    # 변수명 바꾸기
head(eco2)

dygraph(eco2) %>% dyRangeSelector()
