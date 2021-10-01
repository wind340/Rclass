#기본 환경설정 2가지
#1. 자동 줄바꿈 옵션 설정
#[tools-Global options-code- soft-warp R wource files]
#2. 한글 처리
#[tools-project options-code editing- text encoding -UTF-8]



a <- 1
a
var1 <- c(1,2,5,7,8)
var1
var2 <- c(1:5)
var2

var3 <- seq(1,5)
var3

str1 <- 'a'
str2 <- 'text'
str3 <- 'hello world'

str4 <- c("a","b","c")
str4


#R에서 데이터 분석은 함수로 시작해서 함수로 끝난다.

x <- c(1,2,3)
x

mean(x)
max(x)
min(x)


install.packages("ggplot2")
library(ggplot2)
x <- c('a','a','b','c')
x
qplot(x)

qplot(data=mpg, x=hwy)

qplot(data=mpg,x=drv,y=hwy)

qplot(data=mpg,x=drv,y=hwy, geom="boxplot",colour=drv)

#도움말
?qplot

#Q1. 80,60,70,50,90
#다섯명의 학생의 시험 결과를 변수 std로 입력하세요
#Q2. 학생들 평균점수를 구하세요
#Q3. 평균점수를 새로운 변수 avg에 새로 담으세요

std <- c(80,60,70,50,90)
mean(std)
avg <- mean(std)
avg


#데이터 프레임 - 가장 많이 사용하는 데이터 형태, 행과 열로 구성된 사각형 모양의 표처럼.
#열의 속성 - 세로로 나열되는 열은 속성을 나타낸다. 컬럼, 변수 , 피처

#행의 속성 -가로로 나열되는 행. roW, 케이스 레코드

#데이터가 크다는 의미 = 행이 많다 또는 열이 많다.
#데이터 분석의 입장에서는 열이 중요하다.


eng <- c(90,80,60,70)
eng
math <- c(50,60,90,30)
math

df_mid <- data.frame(eng,math)
df_mid

class <- c(1,1,2,2)
df_mid <- data.frame(eng,math,class)
df_mid

mean(df_mid$math)
mean(df_mid$eng)

#데이터 프레임 한번에 만들기

df_mid <- data.frame(eng=c(90,80,60,70),
                     math=c(50,60,90,30),
                     class=c(1,1,2,2))
df_mid

#readxl 패키지 설치와 로드

install.packages("readxl")
library(readxl)

df_exam <- read_excel("excel_exam.xlsx")
#이름행이 없을때는 옵션을 주자
#df_exam <- read_excel("excel_exam.xlsx",col_name = F)
#csv를 읽어 올때는 몇가지 다른점들이 있다.
#df_exam <- read.csv("excel_exam.csv", header = F)


mean(df_exam$english)
mean(df_exam$science)

exam <- read_excel("excel_exam.xlsx")

#데이터를 분석하기 위해 읽어오고, 다양하게 파악하자.
#1. 데이터의 앞부분 확인하기

head(exam)    # 기본은 앞에서 6번행까지 출력한다.
head(exam,10) # 지정한 숫자만큼 출력한다.


#2. 데이터의 뒷부분 확인하기

tail(exam)    #기본은 뒤에서 6개까지 출력한다.
tail(exam,10) #지정한 숫자만큼 뒤에서 출력한다

#3.데이터가 몇행 몇열로 구성되어 있는지 호가인 dim()

dim(exam)


#4. 데이터의 열 값들의 속성과 구조를 파악 str()
str(exam)


#5. 변수들의 값을 요약한 summary()
summary(exam) #요약 통계량

#6. View


library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)

#데이터에 관한 설명 보기
?mpg


# 변수명 바꾸기..
df_raw <- data.frame(var1=c(1,2,1),
                     var2=c(2,3,2))


#데이터 가공
install.packages("dplyr")
library(dplyr)

#버전확인
R.version


#변수명 바꾸기

df_new <- df_raw

df_new <- rename(df_new, v2=var2)

df_new

head(mpg)

#mpg셋의복사본을 만들어서 cty->city hwy->highway 로 이름을 바꾸어라.

mpg_new<-mpg
mpg_new
mpg_new<-rename(mpg_new, city = cty, highway = hwy)
head(mpg_new)

#파생변수 만들기

df <- df_raw

df

df$sum <- df$var1+df$var2
df

#Q1, mpg_new에 city 도시연비 highway고속연비의 평균을 
#계산하여 total이라는 종합연비를 추가하세요.
#종합연비 전체의 평균까지 나타내시오

mpg_new$total <- (mpg_new$city+mpg_new$highway)/2
head(mpg_new)

mean(mpg_new$total)


#조건문을 활용해서 파생변수 만들자ifelse

summary(mpg_new$total)

hist(mpg_new$total)

mpg_new$test <- ifelse(mpg_new$total >=20,"pass","fail")
head(mpg_new,20)

table(mpg_new$test)

library(ggplot2)
qplot(mpg_new$test)

#Quiz 30이상이면 a등급. 20이상이면 b등급. 나머지 20미만은 c등급

mpg_new$grade <- ifelse(mpg_new$total >=30,"A", ifelse(mpg_new$total>=20,"B","c"))

head(mpg_new)

table(mpg_new$grade)
mpg_new <- mpg[]




#종합 퀴즈
#1.ggplot2의 midwest를데이터 프레임으로 가져와서 데이터의 특성을 파악하자 6개
#2.poptotal변수명을 total로 변경 popadian을 asian으로 수정
#3.total과 asian변수로 전체 인구 대비 아시아 인구 백분율을 파생변수로 만들어서 히스토그램 그리기
#4. 아시아인구 백분율의 평균을 구하고 그 평균을 초과하면 large아니면 small파생변수 생성


df_1 <- data.frame(ggplot2::midwest)
head(df_1)
df_1<-rename(df_1,total=poptotal,asian=popasian)
head(df_1)
df_1$asianper <- df_1$asian/df_1$total*100
hist(df_1$asianper)
mean(df_1$asianper)
df_1$asiapermid <- ifelse(df_1$asianper > 0.4872462,"large","small")
head(df_1)


