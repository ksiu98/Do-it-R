# 데이터 프레임 이해하기
# 행은 가로,  열은  세로를 나타냄.  열(Column)은 속성    행(Row) 은 대상의 정보
# 데이터가 크다 = 행 또는 열이 많다.
# 데이터 분석하는 입장에서 봤을때 열이 많은 것이 더 중요하다.  즉, 열이 많아지면 변수들의 관계를 다루게됨. 고급분석방법 사용
# 빅데이터는 행이 많은 그저 부피만 큰 데이터가 아닌, 열이 많은 '다양한' 데이터임. 그래야 데이터의 의미가 커짐

# 데이터 프레임 만들기
# english <- c(90, 80, 60, 70)
# math <- c(50, 60, 100, 20)
# df_midterm <- data.frame(english, math)
# english, math로 데이터 프레임 생성해서 df_midterm 변수에 할당

# english <- c(90, 80, 60, 70)
# math <- c(50, 60, 100, 20)
# class <- c(1, 1, 2, 2)
# df_midterm <- data.frame(english, math, class)

# 데이터 프레임 분석하기
# mean(df_midterm$english)    df_midterm의 english로 평균산출

# 데이터 프레임 한번에 만들기
# df_midterm <- data.frame(english = c(90, 80, 60, 70),
#                          math = c(50, 60, 100, 20),
#                          class = c(1, 1, 2, 2))
# 참고) 코드가 길어질 경우 쉼표 뒤에서 엔터 눌러 다음줄로 넘겨주면 전체적인 구조가 한눈에 잘 들어옴

# 엑셀 파일 불러오기
library(readxl)
# df_exam <- read_excel("/Users/kimsiwoo/Desktop/WORKSPACE/RSTUDIO/Doit_R-master/Data/excel_exam.xlsx")
# mean(df_exam$english)

# 엑셀 파일 첫 번째 행이 변수명이 아니라면???
# read_excel()은 기본적으로 엑셀 파일의 첫 번째 행을 변수명으로 인식함
# df_exam_novar <- read_excel("/Users/kimsiwoo/Desktop/WORKSPACE/RSTUDIO/Doit_R-master/Data/excel_exam_novar.xlsx",
#                            col_names = F)
# 이럴때는 col_names = F 파라미터를 설정하면, 첫 번째 행을 변수명이 아닌 데이터로 인식해 불러오고, 변수명은 숫자로 자동 지정됨. 이때 대문자 F 유의
# 여기서 F는 False를 뜻함. 따라서 열이름을 가져올것인가? 라는 질문에 거짓으로 답함으로서 열 이름대신 데이터로 인식해서 불러온 것.

# 엑셀 파일에 시트가 여러 개 있다면??
# df_exam_sheet <- read_excel("excel_exam_sheet.xlsx", sheet = 3)
# sheet 파라미터를 사용하여 몇 번째 시트의 데이터를 불러올지 지정

# CSV 파일 불러오기 (별도의 패키지 설치x)
# df_csv_exam <- read.csv("/Users/kimsiwoo/Desktop/WORKSPACE/RSTUDIO/Doit_R-master/Data/csv_exam.csv")
# 첫 번째 행에 변수명이 없는 csv 파일을 불러올정 때는 header = F 파라미터를 지정. 엑셀과 파라미터가 다른점 주의
# 문자가 들어있는 파일을 불러올 때는 stringAsFactors = F 파라미터 사용

# 데이터 프레임을 csv파일로 저장하기
# write.csv(df_midterm, file = "df_midterm.csv")

# RData 파일 활용하기
# save(df_midterm, file = "df_midterm.rda")
# load("df_midterm.rda")
# rm() 함수는 데이터 삭제 함수    rm(df_midterm)