#170
mpg <- as.data.frame(ggplot2::mpg)
library(dplyr)
library(ggplot2)
# mpg[c(65,124,131,153,212), "hwy"] <- NA   # 결측치 할당

# table(is.na(mpg$drv))
# table(is.na(mpg$hwy))

# mpg %>%
#   filter(!is.na(hwy)) %>%     # hwy 결측치 제거
#   group_by(drv) %>%           # 결측치 제거한 wy를 dvr별로 그룹화
#   summarise(hwy_mean = mean(hwy))

#178
mpg[c(10,14,58,93), "drv"] <- "k"     # drv 이상치 할당
mpg[c(29,43,129,203), "cty"] <- c(3,4,39,42)    # cty 이상치 할당

# table(mpg$drv)  # drv 결측치 확인
mpg$drv <- ifelse(mpg$drv %in% c(4,"f", "r"), mpg$drv, NA)
# table(mpg$drv)    # k값 사라졌는지 확인
# table(is.na(mpg$drv))   # k값이 결측치로 바꼈는지 확인

mpg$cty <- ifelse(mpg$cty > 26 | mpg$cty < 9, NA, mpg$cty)
# boxplot(mpg$cty)

mpg %>%
  filter(!is.na(drv) & !is.na(cty)) %>%
  group_by(drv) %>%
  summarise(mean_cty = mean(cty))
