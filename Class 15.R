# R 내장함수, 변수 타입과 데이터 구
# R 내장함수로 데이터 추출하기

# 행 번호로 행 추출하기
exam <- read.csv("/Users/kimsiwoo/Desktop/WORKSPACE/RSTUDIO/Doit_R-master/Data/csv_exam.csv")
# exam[]    # 조건 없이 전체 데이터 출력

# exam[1,]    # 1행 추출
# exam[exam$class == 1,]    # class가 1인 행 추출
# exam[exam$math >= 80,]    # 수학 점수가 80잠 이상인 행 추출
# exam[exam$class == 1 & exam$math >= 50,]  # 1반 이면서 수학 점수가 50점 이상
# exam[exam$english < 90 | exam$science < 50,]  # 영어 점수가 90점 미만이거나 과학 점수가 50점 미만

# 열 번호로 변수 추출하기
# exam[,1]    # 첫 번째 열 추출

# 변수명으로 변수 추출하기
# exam[,"class"]    # class 변수 추출
# exam[,c("class", "math", "english")] # class, math, english 변수 추출

# 행, 변수 동시 추출
# exam[exam$math >= 50, c("english", "science")] # 행 부등호 조건, 열 변수명

# 수학 점수 50이상, 영어점수 80이상인 학생들을 대상으로 각 반의 전 과목 총평균을 구하라
exam$tot <- (exam$math + exam$english + exam$science)/3
# aggregate(data=exam[exam$math>=50 & exam$english>=80,], tot~class,mean)

# 변수 타입
# 변수의 종류는 연속변수와 범주변수가 있다.

# 연속 변수 -Numeric 타입
# 예) 키, 몸무게, 소득처럼 연속적이고 크리를 의미하는 값으로 구성된 변수

# 범주 변수 -Factor 타입
# 예) 값이 대상을 분류하는 의미를 지니는 변수. 성별, 지역등

var1 <- c(1,2,3,1,2)
var2 <- factor(c(1,2,3,2,1))

# factor 변수는 연산이 안된다
# var2+2

# 변수타입 확인   class
# factor 변수의 구성 범주 확인하기    levels()

# 변수 타입 변환
# var2 <- as.numeric(var2)
# as.factor, character, Date, data.frame

# 다양한 변수 타입
# numeric : 실수    integer : 정수    complex : 복소수
# character : 문자  logical : 논리    factor : 범주     Date : 날짜


# 데이터 구조
# 벡터(1차원) : 한가지 변수 타입으로 구성    a <- 1
# 데이터 프레임(2차원) : 다양한 변수 타입으로 구성   x1 <- data.frame(var1 = c(1,2,3))
# 매트릭스(2차원) : 한 가지 변수 타입으로 구성   x2 <- matrix(c(1:12), ncol=2)
# 어레이(다차원) : 2차원 이상의 매트릭스     x3 <- array(1:20, dim=c(2,5,2))
# 리스트(다차원) : 서로 다른 데이터 구조 포함    x4 <- list(f1=a, f2=x1, f3=x2, f4=x3)

# boxplot() 출력결과는 리스트 형태
# x$stats[,1]   # 요약 통계량 추출