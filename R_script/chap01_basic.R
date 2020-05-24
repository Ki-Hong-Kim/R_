# chap01_basic.R

# 수업내용
# 1. 패키지와 세션
# 2. 패키지 사용법
# 3. 변수와 자료형
# 4. 기본함수와 작업공간

# 1. 패키지와 세션
# package
dim(available.packages())
a<-available.packages()
# [1] 15297 (사용가능한 패키지 수) 17(패키지 정보)
# dim() 행렬로 표현해주는 기능

# session
sessionInfo() # 세션 정보 제공
# R 환경, OS 환경, locale(다국어 정보), 기본 패키지
install.packages()
# 주요 단축키
#  script 실행  : ctrl + enter
#   save 저장   : ctrl + s
# 자동완성 기능 : ctrl + sapce bar
#  여러줄 주석  : ctrl + shift + c (토글)


a <- 10 # a 라는 값에 10을 할당한다는 의미 <- 로 할당하는 방향을 알 수 있다
b <- 20
c <- a+b
print(c) # 결과 출력 함수인 print()


# 2. 패키지 사용법 : package = function + data set
# 1) 패키지 설치

install.packages("stringr") # stringr 이 의존하는 패키지 : glue, magrittr, stringi, stringr
# 패키지 설치시 입력한 패키지 그리고 해당 패키지가 연관성있는 의존성 패키지까지 설치된다.
# 하지만 설치만 한다고 설치된 패키지를 사용할 수 있는게 아니다
library(stringr) # library로 패키지를 활성화시켜줘야 관련 작업을 수행 할 수 있다.

# 2) 패키지 설치 경로
.libPaths()

# 3) in memory : 패키지 -> upload
library(stringr)
# 패키지에 대한 정보 : library(help = 'stringr') 

# memory 로딩된 패키지 확인
search()

# str_extract('stirng', 'pattern')
# string에서 가장 먼저 pattern에 해당되는 부분
str_extract('홍길동35이순신45', '[가-힣]{3}') 
# 정규표현식 [가-힣] : 한글로된 문자 전체
# 정규표현식에 매칭이되는 {3} 연속되는 3글자

# string에서 pattern에 해당되는 부분 전체
str_extract_all('홍길동35이순신45', '[가-힣]{3}')

# 4) 패키지 삭제
remove.packages('stringr') # 물리적 삭제 가능
install.packages('stringr')
library(stringr)

#############################
## 패키지 설치 Error 해결법##
#############################

# 1. 최초 패키지 설치 
# - rstudio 관리자 모드로 실행 후 설치

# 2. 기존 패키지 설치 
# 1) remove.packages("패키지")
# 2) 컴퓨터 재부팅
# 3) install.packages("패키지")


# 3. 변수와 자료
# 1) 변수 : 메모리 이름 

# 2) 변수 작성 규칙
# - 첫자는 영문으로 시작 두번째이후로는 숫자, 특수문자(_, .) 가능
# ex) score2020, score_2020, score.2020

# - 예약어, 함수명 사용 불가

# - 대소문자 구분 (ex NUM != num )
# - 변수 선언시 type 선언 없음
# - socre = 90(R) vs int score = 90(c)
# - 변수는 가장 최근 값으로 변경됨
# - R의 모든 변수는 객체(object)

var1 <- 0 # var1 = 0 으로도 사용 가능
var1 <- 1
var1 # 아무리 저장한다고 해도 마지막으로 저장된 값만 저장됨
print(var1)

10 -> var2 # 이런식도 가능하지만 되도록이면 통일하는게 좋다
var3 = 20
var4 = c(10, 20, 30, 40)

var1; var2; var3; var4
# [1] 1
# [1] 10
# [1] 20
# [1] 10 20 30 40 50 60

# 색인(index) : 저장 위치 
var4 <- c(10, 20, 30, 40, 50, 60)
var4[3] # 30  // var4 에 3번째로 저장된 값

# 대소문자
NUM <- 100
num <- 200
print(NUM == num) # 관계식의 결과 T/F로나옴

# object.member
member.id = "hong" #   "" == ''
member.name = "홍길동"
member.age = 35

member.id ; member.name ; member.age

# scala(0차원) vs vector(1차원) 
score <- 95  # scala
scores <- c(75, 75, 80, 100, 95) # vector
score
scores

# 3) 자료형(데이터 타입) : 숫자형, 문자형, 논리형... 등등
int <- 100
float <- 125.23
string <- "대한민국"
bool <- T # TRUE T FALSE F

# mode : 자료형 반환 함수
mode(int)   # numeric
mode(float) # numeric
mode(string)# character
mode(bool)  # logical
str(string) # 자료형 반환과 동시에 값도 보여준다

# is.xxx()
is.numeric(int)
is.logical(bool)
is.numeric(string)

datas <- c(84,85,62,NA,45)
is.na(datas)

# 4) 자료형 변환 함수 
# (1) 문자형 -> 숫자형 변환
x <- c(10,20,30, '35') # vector
x
mode(x) # "numeric" -> "character"
x*2 # error

x <- as.numeric(x)
x*2
x
plot(x) #그래프 생성

# (2) 요인형 (factor)
# 범주형(집단) 변수 생성
gender <- c( '남','여','남','남')
mode(gender)

fgender <- as.factor(gender)
mode(fgender)
plot(fgender) # 범주형 데이터에 plot을 사용하면 자동으로 counting 해서 바그래프를 생성함
fgender

# mode vs class
str(fgender)
mode(fgender)  # numeric -> 자료형 확인 // 숫자로서의 의미는 없음 (더미변수)
class(fgender) # factor -> 자료 구조 확인

x <- c(4,2,4,2)
mode(x)  # "numeric"
class(x) # "numeric"

z <- as.factor(x)
mode(z)  # "numeric" 범주를 구분하기 위한 숫자
# z[1] + z[2] 숫자로 인식되긴하지만 연산은 안됨
class(z) # "factor"



# (숫자형 -> 요인형) -> 숫자형 
x2 <- as.numeric(z)
# x2 != x 결과가 바뀜
x2

# 그렇다면 원상태로 복구하기 위해서는?
# (숫자형 -> 요인형) -> 문자형 -> 숫자형
z2 <-as.character(z)
print(z2)
mode(z2)
class(z2)

z3<-as.numeric(z2)
mode(z3)
class(z3)
z3

# 4. 기본함수와 작업공간
# 1) 기본함수 : 바로 사용가능한 7개 패키지에 있는 함수
sessionInfo()

# 패키지 도움말
library(help = 'stats')

# 함수 도움말
help(sum)
x <- c(10,20,30,NA)
sum(x, na.rm=T) # na 값은 remove 해라 (na.rm의 기본값은 False)
# na 값이 있으면 사칙연산이 불가능해서 결과가 na값으로 나옴


?mean
mean(10,20,30,NA, na.rm = T) # 10 
mean(x, na.rm = T) # 20

# 2) 기본 데이터 셋
data() # 데이터 셋 확인
data("Nile")

Nile
length(Nile) #100
mode(Nile) # "numeric
plot(Nile)
hist(Nile)

# 3) 작업공간
getwd()
setwd("C:/ITWILL/2_Rwork/Part-I")

emp <- read.csv("emp.csv", header = T) # header은 열이름의 유무를 뜻함
emp

rep(1:3, times =3) # 1~3 을 3번
rep(1:3, each =3 ) # 1, 2, 3 을 각각 3번씩 






