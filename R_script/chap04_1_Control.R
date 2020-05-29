# chap04_1_Control 제어문과 함수문

# <실습> 산술연산자 
num1 <- 100 # 피연산자1
num2 <- 20  # 피연산자2
result <- num1 + num2 # 덧셈
result # 120
result <- num1 - num2 # 뺄셈
result # 80
result <- num1 * num2 # 곱셈
result # 2000
result <- num1 / num2 # 나눗셈
result # 5

result <- num1 %% num2 # 나머지 계산
result # 0

result <- num1^2 # 제곱 계산(num1 ** 2)
result # 10000
result <- num1^num2 # 100의 20승
result # 1e+40 -> 1 * 10의 40승과 동일한 결과


# <실습> 관계연산자 
# (1) 동등비교 
boolean <- num1 == num2 # 두 변수의 값이 같은지 비교
boolean # FALSE
boolean <- num1 != num2 # 두 변수의 값이 다른지 비교
boolean # TRUE

# (2) 크기비교 
boolean <- num1 > num2 # num1값이 큰지 비교
boolean # TRUE
boolean <- num1 >= num2 # num1값이 크거나 같은지 비교 
boolean # TRUE
boolean <- num1 < num2 # num2 이 큰지 비교
boolean # FALSE
boolean <- num1 <= num2 # num2 이 크거나 같은지 비교
boolean # FALSE

# <실습> 논리연산자(and, or, not, xor)
logical <- num1 >= 50 & num2 <=10 # 두 관계식이 같은지 판단 
logical # FALSE
logical <- num1 >= 50 | num2 <=10 # 두 관계식 중 하나라도 같은지 판단
logical # TRUE

logical <- num1 >= 50 # 관계식 판단
logical # TRUE
logical <- !(num1 >= 50) # 괄호 안의 관계식 판단 결과에 대한 부정
logical # FALSE

# xor 서로 상반된 결과값을 갖고있다면 T
x <- TRUE; y <- FALSE
xor(x,y) # [1] TRUE
x <- TRUE; y <- TRUE
xor(x,y) # FALSE

###################################################
################## 1. 조건문  #####################
###################################################

# 1) if(조건식) - 조건식 : 산술, 관계, 논리연산자
x <- 10
y <- 5
z <- x * y
z
if (z >= 200){
  cat('z는 20보다 크다.')#실행문
}else{cat('작다')}


# 형식1) if(조건식){참}else{거짓}
z <- 10
if(z >= 20){
  cat('z는 20보다 크다.')
}else{
  cat('z는 20보다 작다.')
}

# 형식1.1) if(조건식1){참}else if(조건식2){참} else{거짓}
score <- 100 # 0~100 
score

# score -> grade( A, B, C, D, F)
grade <- ""
if(score >= 90){ 
  grade <- "A"
}else if( score >= 80){
  grade <- "B"
}else if( score >= 70){
  grade <- "C"
}else if( score >= 60){
  grade <- "D"
}else{
  grade <- "F"
}

cat('점수는', score, '이고, 등급은', grade, '이다.')

# 문) 키보드로 임의 숫자를 입력받아서 짝수/홀수 판별하기
num <- scan()
num
if(num %% 2 == 0){
  cat('짝수이다')
}else{cat('홀수이다')}

# 문) 주민번호를 이용하여 성별 판별하기 (남성 : 뒷자리 1,3으로 시작, 여성 : 뒷자리 2,4로 시작)
library(stringr)
jumin <- "123456-1234567"
# 성별 추출하기 : str_sub
if(str_sub(jumin, 8,8) %in% c(1,3)){
  cat('남성이다')
}else if(str_sub(jumin, 8,8) %in% c(2,4)){
  cat('여성이다')
}else{cat('잘못된 주민번호이다.')}

gender <- 3

if(gender == 1 | gender == 3){
  cat('남성이다')
}else if (gender == 2 | gender == 4){
  cat('여성이다')
}else {'주민번호 양식 틀림'}


c <- "5"
str(c)
v <- 5
str(v)
c == v

# 2) ifelse : if + else
# 형식) ifelse(조건식, 참, 거짓) = 3항연산자
# vector 입력 -> 처리 -> vector 출력

score <- c(78, 85, 95, 45, 65)
grade <- ifelse(score >= 60, "합격", "불합격") # 합격/불합격 60 기준


excel <- read.csv(file.choose()) # excel.csv
str(excel)
q5 <- excel$q5
table(q5)

# 5점 척도 -> 범주형 변수
q5_re <- ifelse(q5 >= 3 ,'큰 값', '작은 값')
table(q5_re)

# NA -> 평균 대체
x <- c(75, 85, 45, NA, 85)
x_na <- ifelse(is.na(x), mean(x, na.rm = T), x )
x_na2 <- ifelse(is.na(x), mean(x, na.rm = T), ifelse(x >= 80, x , 0))

d <-ifelse(is.na(x), print("NA"), "")

# 3) switch()
# 형식) switch(비교 구문, 실행구문1, 실행구문2, 실행구문3 )
switch("pwd", age=105, name ="홍길동", id = "hong", pwd = "1234")
switch("id", age=105, name ="홍길동", id = "hong", pwd = "1234")
# name : "홍길동
# pwd : "1234


# 4) which
name <- c("kim", "lee", "choi", "park")
which(name == "choi")

library(MASS)
data("Boston")
str(Boston)
name <- names(Boston)
name
length(name)

# x(독립변수: 영향을 주는), y(종속변수: 영향을 받는) 변수 선택
y_col <- which(name == 'medv')

Y <- Boston[y_col]
head(Y)

X <- Boston[-y_col]
head(X)

# 문) iris 데이터 셋을 대상으로 x변수 (1~4 col), y변수 (5 col)
name <- names(iris)
names(iris)
iris_col <- which(name == "Species")
iris_y <- iris[iris_col]  # 열 자체를 선택 
iris_t <- iris[,iris_col] # 해당 열의 데이터를 선택
str(iris_y)
str(iris_t)
iris_x <- iris[-iris_col]

#################################################
#################  2. 반복문   ##################
#################################################
# 1) for (변수 in 열거형 객체){ 실행문(반복문) }

num <- 1:10

for (i in num){       # num(1:10)에 있는 값들이 i로 순차적으로 입력됨 -> length(num) 만큼 반복한다는 의미이고 1:10의 값들이 들어감 
  cat('i=', i, '\n')  # 실행문
  print(i*2)
}
# cat 에는 자동 바꿈 기능이 없음 '\n'을 입력해 수동으로 줄바꿈 해야함
# 하지만 print에는 자동으로 줄바꿈 기능이 있음 

# 홀수/짝수 출력
for (i in num){
  if ( i %% 2 != 0 ){  # 홀수인 조건을 찾아라
    cat('i=', i, '\n') # 홀수일때 출력하는 결과
  }else{# 홀수가 아닌 값들(=짝수)
  next} # 짝수는 결과 출력없이 스킵
}

# 문) 키보드로 5개 정수를 입력받아서 짝수/홀수 구분하기
num2 <- scan() # 5개 정수 입력

for (i in num2 ){
  if (i %% 2 == 0){
    cat("짝수\n")
  }else{
    cat("홀수\n")
  }
}

# 문2) 홀수의 합과 짝수 합 출력하기
num3 <- 1:100 
even <- 0 # 짝수 합
odd <- 0  # 홀수 합
cnt <- 0  # 카운터 변수 

for ( i in num3 ){
  cnt <- cnt + 1
  if (i %% 2 == 0){
    even = even + i # 짝수 누적
  }else{
    odd = odd + i   # 홀수 누적
  }
}

cat('카운터 변수', cnt ,'짝수의 합 =',even, '홀수의 합 =',odd)
setwd("C:/ITWILL/2_Rwork/Part-I")
#kospi <- read.csv(file.choose())
kospi <- read.csv("sam_kospi.csv")
str(kospi)

kospi$diff <- kospi$High - kospi$Low # 기존 컬럼을 이용해 새로운 컬럼 생성
str(kospi)

row <- nrow(kospi) # row는 숫자 247 전에 사용한 num은 1:100 범주형임 // for에 열거형 객체에 어떤식으로 입력해야하는지 조심해야함
# diff  평균이상 '평균 이상', 아니면 '평균 미만'

diff_result <- "" # 변수 초기화

for (i in 1:row){ 
  if(kospi$diff[i] >= mean(kospi$diff) )
      {diff_result[i] <- "평균 이상"}
  else{diff_result[i] <- "평균 미만"}
}
kospi$diff_result <- diff_result

#바로 추가도 가능
for (i in 1:row){ 
  if(kospi$diff[i] >= mean(kospi$diff) )
  {kospi$diff_result[i] <- "평균 이상"}
  else{kospi$diff_result[i] <- "평균 미만"}
}
table(kospi$diff_result)

# 이중 for 문 
# for( 변수1 in 열거형 ){
#   for (변수2 in 열거형){
#     실행문
#   }
# }

# 이중 for 문 사용 예 : 구구단 & 문장 저장(file save)
# cat 함수로 문자를 출력할 수 있고 출력된 문자를 파일로 저장할 수 있다.
# cat 함수를 여러번 사용했다면 append = T라는 조건을 사용해 누적으로 저장 할 수 있다
for ( i in 2:9){ # i : 단수
  cat('***', i, '단***\n',
      file = 'C:/ITWILL/2_Rwork/output/gg.txt', append = T )
 for ( j in 1:9){# j : 곱수
   cat(i, '*', j, '=', (i*j),'\n',
       file = 'C:/ITWILL/2_Rwork/output/gg.txt', append = T)
   
 } # inner for
  cat('\n',
      file = 'C:/ITWILL/2_Rwork/output/gg.txt', append = T)
}  # outer for

gug.txt <- readLines("C:/ITWILL/2_Rwork/output/gg.txt")

for ( i in 2:9){ # i : 단수
  cat('***', i, '단***\n')
  for ( j in 1:9){# j : 곱수
    cat(i, '*', j, '=', (i*j),'\n')
    
  } # inner for
  cat('\n')
} 


# 2) while(조건식) : 조건에 의해 반복
# while(조건식){실행문}
i <- 0 #초기화

while(i < 5){
  cat('i = ', i, '\n')
  i = i + 1 # 카운터
}

# while을 이용해 각 변량에 제급을 취해보자
x <- c(2, 5, 8, 6, 9)
n <- length(x)
i <- 0 # index(색인) 역할을 함
y <- 0

while ( i < n){
  i <- i + 1
  y[i] <- x[i]^2
 print(y)
 
}











