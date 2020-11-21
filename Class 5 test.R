# 112
# mpg <- as.data.frame(ggplot2::mpg)
# mpg_new <- mpg
# mpg_new <- rename(mpg_new, city = cty, highway = hwy)
# head(mpg_new)

#123
# midwest <- as.data.frame(ggplot2::midwest)
# library(ggplot2)
# library(dplyr)
# summary(midwest)
# midwest <- rename(midwest, total = poptotal, asian = popasian)
# midwest$per <- midwest$asian/midwest$total*100
# hist(midwest$per)
# per_mean <- mean(midwest$per)
# midwest$size <- ifelse(midwest$per >= per_mean, "large", "small")
# table(midwest$size)
# qplot(midwest$size)