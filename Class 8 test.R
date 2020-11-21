#188
mpg <- as.data.frame(ggplot2::mpg)
library(ggplot2)
# ggplot(data = mpg, aes(x=mpg$cty, y=mpg$hwy)) + geom_point()

# midwest <- as.data.frame(ggplot2::midwest)
# ggplot(data = midwest, aes(x=midwest$poptotal, y=midwest$popasian)) +
#   geom_point() +
#   xlim(0,500000) +
#   ylim(0,10000)

#193
mpg_cty <- mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)

# ggplot(data = mpg_cty, aes(x=reorder(manufacturer, -mean_cty), y=mean_cty)) + geom_col()
# ggplot(data = mpg, aes(x=class)) + geom_bar()


#195
# ggplot(data = economics, aes(x=date, y=psavert)) + geom_line()

#198
mpg_class <- mpg %>%
  filter(class == c("compact", "subcompact", "suv"))

ggplot(data=mpg_class, aes(x=class, y=cty)) + geom_boxplot()