# 자유자재로 데이터 가공하기
library(dplyr)

# 조건에 맞는 데이터만 추출하기
exam <- read.csv("/Users/kimsiwoo/Desktop/WORKSPACE/RSTUDIO/Doit_R-master/Data/csv_exam.csv")

# exam %>% filter(class ==1)      # exam에서 class가 1인 경우만 추출해 출력
#exam %>% filter(class != 1)     # 1반이 아닌 경우

# 초과, 미만, 이상, 이하 조건걸기
# exam %>% filter(math > 50)

# 여러조건을 충족하는 행 추출하기
# exam %>% filter(class ==1 & math >= 50)   # 1반이면서 수학 점수가 50점 이상인 경우     # filter에서는 &로 나열

# 여러조건중 하나 이상 충족하는 행 추출하기
# exam %>% filter(math >= 90 | english >= 90)   # 수학가 점수가 90점 이상이거나 영어 점수가 90점 이상인 경우  # | 는 '또는(or)'
# exam %>% filter(class == 1 | class == 3) # 1반, 3반 학생들 추출
# exam %>% filter(class %in% c(1,3))    # '%in%'는 변수의 값이 지정한 조건 목록에 해당하는지 확인하는 기능

# 추출한 행으로 데이터 만들기
# class1 <- exam %>% filter(class == 1)
# class2 <- exam %>% filter(class == 2)
# mean(class1$math)
# mean(class2$math)

# 필요한 변수만 추출하기
# exam %>% select(class, math, english)
# 변수 제외하기
# exam %>% select(-math, -english)

# dplyr함수 조합하기
# exam %>% filter(class == 1) %>% select(english)    # 1반의 영어만 추출
# 가독성 있게 줄 바꾸기
# exam %>%
#  filter(class == 1) %>%
#  select(english)             # %>% 뒤에서 엔터로 줄바꾸면 자동으로 일정간격이 띄어져서 나옴
# 일부만 출력하기
#exam %>%
#  select(id, math) %>%
#  head                        # head()를 dplyr에 조합해 사용가능.  dplyr구문의 마지막에 %>%로 연결해 head 입력


# 순서대로 정렬하기
# exam %>% arrange(math)  #math 오름차순 정렬
# exam %>% arrange(desc(math))   #math 내림차순 정렬
# exam %>% arrange(class, math)   #class, math 오름차순 정

# 파생변수 추가하기
# exam %>%
#  mutate(total = math + english + science) %>%  # 총합 변수 추가
#  head

# 여러 파생변수 한 번에 추가하기
# exam %>%
#  mutate(total = math + english + science,    # 총합 변수 추가
#         mean = total/3) %>%                  # 총평균 변수 추가
#  head

# mutate()에 ifelse() 적용하기
# exam %>%
#   mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
#   head

# 추가한 변수를 dplyr코드에 바로 활용하기
# exam %>%
#   mutate(total = math + english + science) %>%
#   arrange(total) %>%
#   head

# 집단별로 요약하기
# exam %>% summarise(mean_math = mean(math))

# exam %>%
#   group_by(class) %>%           # class별로 분리
#   summarise(mean_math = mean(math))   # math 평균 산출

# 여러 요약 통계량 한 번에 산출하기
# exam %>%
#   group_by(class) %>%                   # class별로 분리
#   summarise(meam_math = mean(math),     # math 평균
#             sum_math = sum(math),       # math 합계
#             median_math = median(math), # math 중앙값
#             n = n())                    # 학생 수
# 코드 맨 아랫줄에 있는 n()은 데이터가 몇 행으로 되어있는지 빈도를 구하는 기능
# group_by를 이용해 반별로 집단 나눴으니 n이 의미하는것은 반별로 4명의 학생의 데이터가 있다는것

mpg <- as.data.frame(ggplot2::mpg)
# mpg %>%
#   group_by(manufacturer) %>%    # 회사별로 분리렬
#   filter(class == "suv") %>%    # suv 추출
#   mutate(tot = (cty + hwy)/2) %>%   # 통합 연비 변수 생성
#   summarise(mean_tot = mean(tot)) %>%   # 통합 연비 평균 산출
#   arrange(desc(mean_tot)) %>%       # 내림차순 정
#   head(5)


# 데이터 합치기
# 가로로 합치기
test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60, 80, 70, 90, 85))
test2 <- data.frame(id = c(1,2,3,4,5),
                    final = c(70, 83, 65, 95, 80))

total <- left_join(test1, test2, by = "id")   # id를 기준으로 합쳐 total에 할당
# left_join()을 이용하면 데이터를 가로로 합칠 수 있다 (열 합병)
# 괄호 안에 합칠 데이터 프레임명을 나열하고 by 파라미터로 기준 변수를 지정

name <- data.frame(class = c(1,2,3,4,5),
                    teacher = c("kim", "lee", "park", "choi", "jung"))
exam_new <- left_join(exam, name, by = "class")

# 세로로 합치기
group_a <- data.frame(id = c(1,2,3,4,5),
                      test = c(60, 80, 70, 90, 85))
group_b <- data.frame(id = c(6,7,8,9,10),
                      test = c(70, 83, 65, 95, 80))

group_all <- bind_rows(group_a, group_b)
# bind_rows()를 이용하면 데이터를 세로로 합칠 수 있다 (행 합병)
