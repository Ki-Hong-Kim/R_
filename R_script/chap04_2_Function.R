# chap04_2_Function

# 1. 사용자 정의 함수 

# 형식) 
# 함수명 <- function([인수]){
# 실행문       (실행문은 순서대로 진행되므로 작성순서 중요)
# 실행문
#  [return 값]
# }

# 1) 매개변수 없는 함수 
f1 <- function(){
  cat('f1 함수')
}

f1() # 함수 호출 (실행결과)

# 2) 매개변수 있는 함수
f2 <- function(x){
  x2 <- x^2
  cat('x2 = ',x2)
}

f2(10) # 실인수

# 3) 인수가 2개이고 return이 있는 함수
f3 <- function(x,y){
  add <- x + y
 return(add)
  }
f3(10,5)

# 함수 호출 -> 반환값 -> 원하는 변수에 저장
add_result <- f3(10,5)
add_result

num <- 1:10
tot_func <- function(x){
  tot <- sum(x)
  return(tot)
}

tot_re <- tot_func(num)

avg <- tot_re / length(num)
avg

# 문) calc 함수를 정의
# 100 + 20 = 120
# 100 - 20 = 80
# 100 * 20 = 2000
# 100 / 20 = 5

calc <- function(x,y){
 cat(x, '+', y, '=', x+y, '\n')
  add <- x + y
  sub <- x - y
  mul <- x * y
  div <- x / y
  cat(x, '-', y,'=' , sub, '\n')
  cat(x, '*', y, '=',mul, '\n')
  cat(x, '/', y, '=',div, '\n')
  calc_result <- data.frame(add, sub, mul, div) 
  # 다중인자 반환이 안되므로 하나의 데이터 프레임으로 묶어서 출력
  return(calc_result)
}

df <- calc(100,20)

# 구구단의 단을 인수 받아서 구구단 출력하기
gugu <- function(dan){
  cat('***', dan,'단 ***', '\n')
  for(i in 1:9){
    cat(dan, '*', i, '=', dan*i, '\n')
  }
}
gugu(2)

state <- function(fname, data){
  switch(fname,
         SUM = sum(data),
         AVG = mean(data),
         VAR = var(data),
         SD  = sd(data))
}
data <- 1:10
state("SUM", data)
state("AVG", 1:99)
state("VAR", data)
 

# 결측치(NA) 처리 함수 (결측치 3가지 처리방법)
na <- function(x){
  # 1. NA 제거 
  x1 <- na.omit(x)
  cat('x1 =', x1, '\n')
  cat('x1 = ', mean(x1), '길이는?', length(x1), '\n\n')
  
  # 2. NA -> 평균으로 대체 
  x2 <- ifelse(is.na(x), mean(x, na.rm = T), x)
  cat('x2 =', x2, '\n')
  cat('x2 = ', mean(x2), '길이는?', length(x2), '\n\n')
  
  # 3. NA -> 0 으로 대체 
  x3 <- ifelse(is.na(x), 0, x)
  cat('x3 =', x3, '\n')
  cat('x3 =', mean(x3), '길이는?', length(x3), '\n\n')
}

x <- c(10, 5, NA,4, 6, 7, 8, NA, 4)
x
length(x)

mean(x) # NA
mean(x, na.rm = T) # 결측치 제거후 평균

# 함수 호출
na(x)



###################################
###    몬테카를로 시뮬레이션    ###
###################################
# 현실적으로 불가능한 문제의 해답을 얻기 위해서 난수의 확률분포를 이용하여 
# 모의시험으로 근사적 해를 구하는 기법

# 동전 앞/뒤 난수 확률분포 함수 
coin <- function(n){
  r <- runif(n, min=0, max=1)
  #print(r) # n번 시행 
  
  result <- numeric()
  for (i in 1:n){
    if (r[i] <= 0.5)
      result[i] <- 0 # 앞면 
    else 
      result[i] <- 1 # 뒷면
  }
  return(result)
}

# 몬테카를로 시뮬레이션 
montaCoin <- function(n){
  cnt <- 0
  for(i in 1:n){
    cnt <- cnt + coin(1) # 동전 함수 호출 
  }
  result <- cnt / n
  return(result)
}

montaCoin(5)
montaCoin(100000)

# 중심 극한의 정리 : 데이터가 커질수록 평균에 가까워진다 


# 2. R의 주요 내장함수

# 1) 기술통계함수 
vec <- 1:10
min(vec)                   # 최소값
max(vec)                   # 최대값
range(vec)                 # 범위
mean(vec)                  # 평균
median(vec)                # 중위수
sum(vec)                   # 합계
prod(vec)                  # 데이터의 곱
1*2*3*4*5*6*7*8*9*10
summary(vec)               # 요약통계량 

sd(rnorm(10))      # 표준편차 구하기
factorial(5) # 팩토리얼=120
sqrt(49) # 루트


# 2) 반올림 관련 함수 
x <- c(1.5, 2.5, -1.3, 2.5)
round(mean(x)) # 1.3 -> 1        : 반올림

ceiling(mean(x)) # x보다 큰 정수 : 올림
floor(mean(x)) # 1보다 작은 정수 : 내림

library(RSADBE)
#library(help="RSADBE")
data(Bug_Metrics_Software)
bug <- Bug_Metrics_Software
str(bug)
# 'xtabs' num [1:5, 1:5, 1:2] 5행 5열 2면
# - attr(*, "dimnames")=List of 3 리스트가 3개
# ..$ Software: chr [1:5] "JDT" "PDE" "Equinox" "Lucene" ...
# ..$ Bugs    : chr [1:5] "Bugs" "NT.Bugs" "Major" "Critical" ...
# ..$ BA_Ind  : chr [1:2] "Before" "After"
# - attr(*, "call")= language xtabs(formula = T.freq ~ Software + Bugs + BA_Ind, data = T.Table)

bug.new <- array(bug, dim = c(5,5,3)) # 기존 bug 리스트에 1면 이상을 더 추가하면 기존 리스트에 있던 면이 반복된다 
bb<-bug[,,1] # before
ba<-bug[,,2] # after
bug.new[,,3] <- bb-ba # 새롭게 생성한 3면에 새로운 데이터로 교체

str(bug)

# 행/열 단위 합계 : 소프트웨어 별 버그 수 합계
rowSums(bug[,,1])

colSums(bug[,,1])
# 행/열 단위 평균
rowMeans(bug[,,1])
colMeans(bug[,,1])

# 3) 난수 생성과 확률분포
# (1) 정규분포를 따르는 난수 - 연속 확률분포(실수형)
# 형식) rnorm(n, mean = 0, sd = 1 ) // default값
n <- 1000
r <- rnorm(n, m=100, sd=30 ) # 표준정규분포
r
mean(r)
sd(r)
hist(r) #대칭성

# (2) 균등분포를 따르는 난수 - 연속확률분포(실수형)
# runif
r2 <- runif(n , min = 20, max = 100)
hist(r2)

# (3) 이항분포를 따르는 난수 - 이산확률분포(정수형)
set.seed(1234) # seed 값을 사용하면 동일한 난수 생성 가능
n <- 10
r3 <- rbinom(n, size = 1, prob = 0.5 ) # size(시도횟수)에는 정수만 입력가능
# 50% 확률을 1번 시도하는 과정을  n번 
# r3에는 각 n번의 성공횟수를 알려준다

set.seed(1234)
r4 <- rbinom(n, 6, 0.25)
r4
# 25%의 확률을 6번 시도하는 과정을 n번 시행했을때 각 회차 성공횟수
# set.seed(1234)에 저장된 r4에서 r4[5]는 과정 5번째에 3번 성공을 의미함 

# (4) sample
sample(10:20, 5, replace = T) 
# 10~20의 숫자가 적힌 공을 주머니에 넣고 5번 숫자 확인 (한번 뽑은공 다시 넣고 뽑기)
sample(c(10:20, 50:100), 10)
# 구간을 여러번 설정할 수 있다

# 홀드아웃 방식
# train(70%) / test(30%) 데이터셋 
dim(iris)
idx <- sample(nrow(iris),nrow(iris)*0.7) # 기본값으로 1:nrow(iris) 임
# 150개에서 105개를 뽑는다
range(idx) # 최소값 , 최대값 (샘플링한거라 1과 150이 안나올 수 있음)
length(idx)

train <- iris[idx,]
test <- iris[-idx,]

dim(train)
dim(test)

# 4) 행렬연산 내장함수 (matrix생성하고 들어가는 객체의 순서는 열먼저임)
x <- matrix(1:9, nrow=3, byrow=T) # 3*3 행렬 (byrow=T는 객체를 행을우선으로 채운다는의미)
y <- matrix(1:3, nrow =3)         # 3*1 행렬

z <- x %*% y # 3*3 행렬 X 3*1 행렬 // 당연히 y%*%x는 계산 안됨
# 행렬곱의 전제 조건
# 1. x,y 모두 행렬 (1x1 도 행렬)
# 2. x의 열과 y의 행은 같아야함


