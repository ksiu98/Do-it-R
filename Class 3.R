# 변수 넣는법
# var1 <- c(1,2,5,7,8)        숫자 5개로 구성된 var1 생성
# var2 <- c(1:5)              1에서 5까지 연속 값으로 var2 생성
# var3 <- seq(1,5)            seq 함수 또한 연속 값을 생성할수 있다. 이때는 쉼표로 표시
# var4 <- seq(1,10, by = 2)   by파라미터를 이용하면 1에서 10까지 2간격 연속값으로 생성가능
# var1+2                      var1 각 변수에 +2한 값들이 생성된다 (3,4,7,9,10)
# var1+var2                   var1,2 같은 순서에 위치한 값끼리 연산함
# var1,2 에 들어있는 변수개수가 다르다면 변수 개수가 많은 쪽에 적은쪽이 순서대로 연산됨
# var5 <- c(0,2,0)
# var1 <- c(1,2,3,4,5)
# var5+var1          result) [1] 1 4 3 4 7

# 문자로 된 변수 만들기
# str3 <- "Hello World!"
# str5 <- c("Hello", "World", "is", "good!")
#  "Hello"   "World"   "is"    "good!"
# 문자로 된 변수로는 연산할수 없다    ex) str3+2

# 함수 이해하기
# x <- c(1,2,3)     mean(x)     [1] 2   max(x)   min(x)
# paste(str5, collapse = ",")     쉼표를 구분자로 str5의 단어들 하나로 합치기
# [1] "Hello!,World,is,good!"
# paste(str5, collapse = " ")
# [1] "Hello! World is good!"

# 함수의 결과물로 새 변수 만들기
# x_mean <- mean(x)     str5_paste <- paste(str5, collapse = " ")

# 함수 사용하기
# library(ggplot2)
# x <- c("a","b","c","a")
# x
# qplot(x)

# ggplot2의 mpg데이터로 그래프 만들기
library(ggplot2)
# qplot(data = mpg, x = hwy)         data에 mpg, x축에 hwy 변수 지정해 그래프 생성
# qplot(data = mpg, x = cty)         x축 cty
# qplot(data = mpg, x = drv, y = hwy)         x축 drv    y축 hwy
# qplot(data = mpg, x = drv, y = hwy, geom = "line")         x축 drv, y축 hwy, 선그래프 형태
# qplot(data = mpg, x = drv, y = hwy, geom = "boxplot")         x축 drv, y축 hwy, 상자그림 형태
 qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)
# x축 drv, y축 hwy, 상자그림 형태, drv별 색 표현

