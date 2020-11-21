# 데이터 분석 프로젝트 - 한국인의 삶을 파악하라
# install.packages("foreign")

library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss(file = "/Users/kimsiwoo/Desktop/WORKSPACE/RSTUDIO/Doit_R-master/Data/Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)

welfare <- raw_welfare
welfare <- rename(welfare,
                  sex = h10_g3,             # 성별
                  birth = h10_g4,           # 태어난 연도
                  marriage = h10_g10,       # 혼인 상태
                  religion = h10_g11,       # 종교
                  income = p1002_8aq1,      # 월급
                  code_job = h10_eco9,      # 직업 코드
                  code_region = h10_reg7)   # 지역 코드

# 성별에 따른 월급 차이
# class(welfare$sex)
# table(welfare$sex)

# 전처리
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)   # 이상치 결측 처리
# table(is.na(welfare$sex))

welfare$sex <- ifelse(welfare$sex == 1, "male", "female") # 성별 항목 이름 부여
# qplot(welfare$sex)

# class(welfare$income)
# summary(welfare$income)
# qplot(welfare$income) + xlim(0,1000)

welfare$income <- ifelse(welfare$income == c(0, 9999), NA, welfare$income)
# table(is.na(welfare$income))  # 결측치 확인

# sex_income <- welfare %>%
#   filter(!is.na(income)) %>%
#   group_by(sex) %>%
#   summarise(mean_income = mean(income))

# ggplot(data = sex_income, aes(x=sex, y=mean_income)) + geom_col()



# 나이와 월급의 관계 - 몇 살 때 월급을 가장 많이 받을까
# class(welfare$birth)
# summary(welfare$birth)
# qplot(welfare$birth)

welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
# table(is.na(welfare$birth))
welfare$age <- 2015 - welfare$birth + 1
# summary(welfare$age)
# qplot(welfare$age)

# age_income <- welfare %>%
#   filter(!is.na(income)) %>%
#   group_by(age) %>%
#   summarise(mean_income = mean(income))
# head(age_income)

# ggplot(data = age_income, aes(x=age, y=mean_income)) + geom_line()


# 연령대에 따른 월급 차이 - 어떤 연령대의 월급이 가장 많을까
welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <=59, "middle", "old")))

# ageg_income <- welfare %>%
#   filter(!is.na(income)) %>%
#   group_by(ageg) %>%
#   summarise(mean_income = mean(income))

# ggplot(data = ageg_income, aes(x=ageg, y=mean_income)) + geom_col() +
#   scale_x_discrete(limits = c("young", "middle", "old"))  # x축 변수들의 순서를 자유자재로 설정


# 연령대 및 성별 월급 차이 - 성별 월급 차이는 연령대 별로 다를까
# sex_income <- welfare %>%
#   filter(!is.na(income)) %>%
#   group_by(ageg, sex) %>%
#   summarise(mean_income = mean(income))

# ggplot(data= sex_income, aes(x=ageg, y=mean_income, fill=sex)) +
#   geom_col(position = "dodge") +
#   scale_x_discrete(limits = c("young", "middle", "old"))
# fill로 성별에 색깔을 입혀서 구분지음.
# geom_col()의 position 파라미터를 "dodge"로 설정해 막대를 분리

# 나이 및 성별 월급 차이 분석
# sex_age <- welfare %>%
#   filter(!is.na(income)) %>%
#   group_by(age, sex) %>%
#   summarise(mean_income = mean(income))

# ggplot(data = sex_age, aes(x=age, y=mean_income, col = sex)) + geom_line()
# aex()의 col 파라미터에 sex를 지정해서 성별에 따라 다른 색으로 표현



# 직업별 월급 차이 - 어떤 직업이 월급을 가장 많이 받을까
# class(welfare$code_job)
# table(welfare$code_job)
# install.packages("extrafont")
# library(extrafont)
# font_import()
theme_set(theme_gray(base_family='NanumGothic'))  # 글꼴을 나눔고딕으로 하여 한글깨짐 해결

list_job <- read_excel("/Users/kimsiwoo/Desktop/WORKSPACE/RSTUDIO/Doit_R-master/Data/Koweps_Codebook.xlsx",
                       col_names = T, sheet = 2)

welfare <- left_join(welfare, list_job, id = "code_job")
# welfare %>%
#   filter(!is.na(code_job)) %>%
#   select(code_job, job) %>%
#   head(10)

# job_income <- welfare %>%
#   filter(!is.na(job) & !is.na(income)) %>%
#   group_by(job) %>%
#   summarise(mean_income = mean(income))

# top10 <- job_income %>%
#   arrange(desc(mean_income)) %>%
#   head(10)

# ggplot(data=top10, aes(x=reorder(job, mean_income), y=mean_income)) +
#   geom_col() +
#   coord_flip()      # x축 y축 반전


# 성별 직업 빈도 - 성별로 어던 직업이 가장 많을까
# 남성 직업 빈도 상위 10개 추출
# job_male <- welfare %>%
#   filter(!is.na(job) & sex == "male") %>%
#   group_by(job) %>%
#   summarise(n=n()) %>%
#   arrange(desc(n)) %>%
#   head(10)

# 여성 직업 빈도 상위 10개 추출
# job_female <- welfare %>%
#   filter(!is.na(job) & sex == "female") %>%
#   group_by(job) %>%
#   summarise(n=n()) %>%
#   arrange(desc(n))  %>%
#   head((10))

# ggplot(data = job_male, aes(x=reorder(job, n), y=n)) + geom_col() + coord_flip()
# ggplot(data = job_female, aes(x=reorder(job, n), y=n)) + geom_col() + coord_flip()



# 종교 유무에 따른 이혼율 - 종교가 있는 사람들이 이혼을 덜할까
# class(welfare$religion)
# table(welfare$religion)

welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")

welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                                ifelse(welfare$marriage == 3, "divorce", NA))

# 종교 유무에 따른 이혼률 표 만들기
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
#   summarise(n=n()) %>%
#   mutate(tot_group = sum(n)) %>%
#   mutate(pct = round(n/tot_group*100,1))
  count(religion, group_marriage) %>%
  group_by(religion) %>%
  mutate(pct = round(n/sum(n)*100,1))

# 이혼 추출
divorce <- religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(religion, pct)

# ggplot(data=divorce, aes(x=religion, y=pct)) + geom_col()


# 연령대별 이혼률 표 만들기
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(ageg, group_marriage) %>%
  summarise(n=n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100,1))

# 연령대별 이혼률 그래프 만들기
# 초년 제외, 이혼 추출
ageg_divorce <- ageg_marriage %>%
  filter(ageg != "young" & group_marriage == "divorce") %>%
  select(ageg, pct)

# ggplot(data=ageg_divorce, aes(x=ageg, y=pct)) + geom_col()


# 연령대 및 종교 유무에 다른 이혼률 표, 그래프 만들기

# 연령대, 종교 유무, 결혼 상태별 비율표 만들기
ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  group_by(ageg, religion, group_marriage) %>%
  summarise(n=n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100,1))

# 연령대 및 종교 유무별 이혼률 표 만들기
df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(ageg, religion, pct)

# ggplot(data=df_divorce, aes(x=ageg, y=pct, fill = religion)) +
#   geom_col(position = "dodge")


# 지역별 연령대 비율 - 노년층이 많은 지역은 어디일까
# class(welfare$code_region)
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(경기/인천)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))

# 지역명 변수 추가
welfare <- left_join(welfare, list_region, id = "code_region")
# welfare %>%
#   select(code_region, region)

# 지역별 연령대 비율표 만들기
region_ageg <- welfare %>%
  group_by(region, ageg) %>%
  summarise(n=n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100,2))

# head(region_ageg)

# ggplot(data=region_ageg, aes(x=region, y=pct, fill = ageg)) + geom_col() + coord_flip()

# 노년층 비율 높은 순으로 막대 정렬하기
list_order_old <- region_ageg %>%
  filter(ageg == "old") %>%
  arrange(pct)

order <- list_order_old$region    # 지역명 순서 변수 만들기

# ggplot(data=region_ageg, aes(x=region, y=pct, fill = ageg)) + geom_col() + coord_flip() +
#   scale_x_discrete(limits = order)

# 연령대 순으로 막대 색깔 나열하기
# 막대색깔을 순서대로 나열하려면 fill 파라미터에 지정할 변수의 범주(levels) 순서를 지정하면 됨
#class(region_ageg$ageg)
# levels(region_ageg$ageg)

# factor()를 이용해 ageg 변수를 factor 타입으로 변환하고, level 파라미터를 이용해 순서를 지정
region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old", "middle", "young"))
# class(region_ageg$ageg)
# levels(region_ageg$ageg)

ggplot(data=region_ageg, aes(x=region, y=pct, fill = ageg)) + geom_col() + coord_flip() +
  scale_x_discrete(limits = order)
