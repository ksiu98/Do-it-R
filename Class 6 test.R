#133
mpg <- as.data.frame(ggplot2::mpg)
library(dplyr)
# displ4 <- mpg %>% filter(mpg$displ <= 4)
# displ5 <- mpg %>% filter(mpg$displ >= 5)
# displ4_hwy_mean <- mean(displ4$hwy)
# displ5_hwy_mean <- mean(displ5$hwy)
# displ4_hwy_mean
# displ5_hwy_mean

# audi <- mpg %>% filter(mpg$manufacturer == "audi")
# toyota <- mpg %>% filter(mpg$manufacturer == "toyota")
# cty_audi_mean <- mean(audi$cty)
# cty_toyota_mean <- mean(toyota$cty)
# cty_audi_mean
# cty_toyota_mean

# threemanu <- mpg %>% filter(mpg$manufacturer == "chevrolet" | mpg$manufacturer == "ford" | mpg$manufacturer == "honda")
# threemanu <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
# mean(threemanu$hwy)


#138
# mpg_new <- mpg %>% select(class, cty)
# head(mpg_new)
# mpg_new_class <- mpg_new %>% filter(mpg$class %in% c("suv","compact"))
# class_suv <- mpg_new_class %>% filter(mpg_new_class$class %in% "suv")
# class_compact <- mpg_new_class %>% filter(mpg_new_class$class %in% "compact")
# mean(class_suv$cty)
# mean(class_compact$cty)

# 정답
# class_suv <- mpg_new %>% filter(class == "suv")
# class_compact <- mpg_new %>% filter(class == "compact")
# mean(class_suv$cty)
# mean(class_compact$cty)

#141
# mpg_audi <- mpg %>% filter(mpg$manufacturer == "audi")
# head(mpg_audi %>% arrange(desc(hwy)), 5)
# 정답
# mpg %>%
#  filter(manufacturer == "audi") %>%
#    arrange(desc(hwy)) %>%
#    head(5)

#144
# mpg %>%
#   mutate(total = cty + hwy,
#          mean = total/2) %>%
#   arrange(desc(mean)) %>%
#   head(3)

#150
# mpg %>%
#   group_by(class) %>%
#   summarise(mean_cty = mean(cty)) %>%
#   arrange(desc(mean_cty))

# mpg %>%
#   group_by(manufacturer) %>%
#   summarise(mean_hwy = mean(hwy)) %>%
#   arrange(desc(mean_hwy)) %>%
#   head(3)

# 정답
# mpg %>%
#   filter(class == "compact") %>%
#   group_by(manufacturer) %>%
#   summarise(count = n()) %>%
#   arrange(desc(count))

#156
# fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
#                    price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
#                 stringsAsFactors = F)
# 참고) stringsAsFactors = F는 문자를 factor 타입으로 변환하지 않도록 설정하는 파라미터.
# data.frame()은 변수에 문자가 들어있으면 factor 타입으로 변환하도록 기본설정 되어있음

# mpg <- left_join(mpg, fuel, by = "fl")
# mpg %>%
#   select(model, fl, price_fl) %>%
#   head(5)


#160
midwest <- as.data.frame(ggplot2::midwest)
midwest_new <- midwest %>%
  mutate(pop_kid_per = (1-popadults/poptotal)*100,
         volume = ifelse(pop_kid_per >= 40, "large",
                         ifelse(pop_kid_per >= 30, "middle", "small"))) %>%
  select(pop_kid_per, county, volume) %>%
  arrange(desc(pop_kid_per))

table(midwest_new$volume)

midwest %>%
  mutate(popasian_per = popasian/poptotal*100) %>%
  select(state, county, popasian_per) %>%
  arrange(popasian_per) %>%
  head(10)