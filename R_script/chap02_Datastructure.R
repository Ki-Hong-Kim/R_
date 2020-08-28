# chap02_datastructure.r

# 데이터 자료구조의 유형 (5개)

# 1.vector 자료구조
# - 동일한 자료형을 갖는 1차원 배열구조
# - vector 생성 함수 : c(), seq(), rep()

# (1) c()
x <- c(1, 3, 5, 7)
y <- c(3, 5)
length(x) # length는 x안에 몇개의 데이터가 있는지 확인하는 기본 함수이다.

# 2) seq()
x <- seq(1, 10, by=2)
print(x) # 1로 시작하고 10으로 끝나는 2씩 중가하는 등차수열

# 3) rep() 반복
x <- rep(1:3, 10, 29) # 1:3 을 반복, 반복횟수, 반복횟수 상관없이 출력개수 제한
# [해석] 1~3 을 10번 반복 ==> 30개 생성 번 29번까지만 저장
print(length(x))


# 집합관련 함수 (base 패키지)
x <- c(1,3,5,7)
y <- c(3,5)
union(x,y)    # 합집합 1 3 5 7
setdiff(x,y)  # 차집합 1 7
intersect(x,y)# 교집합 3 5 

# 벡터 변수 유형
num <- 1:5 # == c(1,2,3,4,5)
print(num)
num <- c(-10:5)
print(num)
num <- c(1,2,3,"4") 
print(num) # 모든 데이터가 문자형으로 저장됨

# 벡터 원소 이름 지정 
names <- c("홍길동", "이순신", "강감찬")
age <- c(35, 45, 55)
names(age) <- names
age # 열이름을 처럼 보이는 속성을 설정하는 방법
attributes(age)

mode(age) # age에 저장된 값들의 type
mean(age) # age의 평균 : 45
str(age)  # str은 자료 구조와 변수의 특징을 보여주는 함수이다.

# 2) seq() : 
# seq( from , to , by , length.out , ...)
num <- seq(1, 10, by = 2)
num2 <- seq(10, 1, by = -2)

# 3) rep()
help(rep)
rep(1:3, times=3) # [1] 1 2 3 1 2 3 1 2 3
rep(1:3, each =3) # [1] 1 1 1 2 2 2 3 3 3
rep(1:3, length.out=100) # rep 가 반복이라는 의미니 100개까지 반복 (times)
# 각 줄에 처음에 오는 [숫자]는 그 뒤에 오는 숫자가 몇번째로 오는건지 알려주는 것이다.
# [1] 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1
# [56] 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1

# 색인 (index) : 저장 위치
# 형식) object[n]
a  <- 1:50
a        # a에 저장된 전체 원소 출력
a[10]    # a에 저장된 원소 중 10번째 원소만 출력
a[10 : 20 ] # a에 저장된 원소 중 10~20번째 까지 원소 출력
a[c(10:20, 30:40)] # a에 저장된 원소 중 10~20번째 그리고 30~40번째 까지 원소를 출력
# a[10:15 , 10:30] error
# 행이 10~15 열이 10~30 을 가져오라는 의미

# 함수 이용
length(a) # 50
a[10:length(a)-5] # 앞뒤를 다 -5 해버림
a[10:(length(a)-5)]

# 특정 원소 제외 (-)
a[-c(15,25,30:35)]

# 조건식 (boolean)
a[a>=10 & a<=30] # & and
a[10<=a & 30>=a] 
a[!10>=a] # ! not

a[seq(2, length(a), by=2)] # 2부터 50 까지 2씩 늘어나는

########################################################
# 2. matrix 자료 구조 
# - 동일한 자료형을 갖는 2차원 배열 구조
# - 생성 함수 : matrix(), rbind(), cbind()
# - 처리 함수 : apply()

# (1) matrix
m1 <- matrix(data= c(1:5))
dim(m1)   # 구조 확인 
mode(m1)  # 입력된 데이터 타입 확인
class(m1) # 자료 구조 형식 확인

m2 <- matrix(data = c(1:9), nrow = 3, ncol = 3, byrow = T)
m2 <- matrix(data = c(1:24), nrow = 4, byrow = T) # nrow를 설정하면 자동으로 ncol이 설정됨
# nrow, ncol 은 row(행), col(열)의 개수를 정해주는 것
# byrow = T 행을 기준으로 데이터를 채운다는 의미 (첫번째 행을 순서대로 채우고 그다음 두번째 행을 채운다)
#         F 일경우 열을 기준으로 (기본값!!)

m2
dim(m2)
mode(m2)
class(m2)

# (2) rbind
# 같은 길이의 데이터를 행을 기준으로 합함 
x <- 1:3
y <- 6:8
z <- c("ㅇ", "ㅊ", "ㄷ")
x
y
m3 <- rbind(x, y, z) # 행으로 합침
print(m3) # x, y 행에 값들에 ""가 씌어짐 (z를 합해 문자열이 들어와서)
dim(m3)
mode(m3)  # character
class(m3)

# (3) cbind()
# 같은 길이의 데이터를 열을 기준으로 합함
m4 <- cbind(x,y)
print(m4)
dim(m4)

# adsp 퀴즈
xy <- rbind(x,y)
xy
# 문제 틀린것 확인
# xy[1,]은 x와 같다
# xy[,1]은 y와 같다
# dim(xy)는 2*5 이다
# class(xy)는 matrix이다.
# mode(xy)는 matrix이다.


# 색인(index) : matrix
# 형식) object[row, column]
m5 <- matrix(data = 1:9, nrow = 3 ,ncol = 3, byrow = T) 
#[해석] 값은 1부터 9까지 있고 3행 3열로 행렬을 생성하는데 행을 우선으로 채운다
# 특정 행 색인
m5[1,]
m5[,1]
m5[c(2,3),c(1,2)]
# -(제외) 속성
m5[-2,]
m5[,-3]
m5[,-c(1,3)]

# 열 (column = 변수 = 변인) 이름 지정
colnames(m5) <- c("one","two","three")
m5[,'one']

# broadcast 연산
# 작은 차원 -> 큰 차원 늘어나서 연산
x <- matrix(1:12, nrow=4, ncol =3, byrow = T)
dim(x)

# 1) scala(0) vs matrix(2)
0.5*x

# 2) vector(1) vs matrix(2)
y <- 10:12
y + x # 열을 기준으로 10 20 30 순서대로 합해짐

# 3) 동일한 모양 (shape)
x+x
x-x

# 4) 전치 행렬 : 행 -> 열 , 열 -> 행
x
t(x)

# 처리 함수 : apply() 
help(apply) # apply ( x, margin( 1(row) | 2(column) ), fun, ...)
# apply(apply 적용할 데이터, 기준(행,열), 적용할 함수)  * 입력데이터는 array만 가능!! (다른 apply에는 다른 데이터도 입력 가능)
apply(x, 1, sum)  #행 단위 합계
apply(x, 2, mean) #열 단위 평균
apply(x, 1, var)  #행 단위 분산
apply(x, 1, sd)   #행 단위 표준편차
 
#################################
# 3. array 자료 구조 
# - 동일한 자료형을 갖는 3차원 배열 구조
# - 생성 함수 : array()

# 색인 (index)
arr = iris3 # iris3는 기본 저장되어있는 데이터셋입니다
dim(arr) # 50행 4열 3면
str(arr)
arr[,,] # (row행, column열, side측면) 빈칸으로 두면 전체를 의미한다
arr[,,1] #1면의 전체 행렬

ar <- array(data = c(1:12), dim = c(3,2,2))
dim(ar)
iris3
dim(iris3)

# 붓꽃 dataset
head(iris3)
iris3[,,1]
iris3[1]
iris3[,,2]
iris3[,,3]
iris[10:20,1:2,1]

#################################
# 4. data.frame
# - 열 기준 서로 다른 자료형을 갖는 2차원 배열 구조
# - 생성 함수 : data.frame()
# - 처리 함수 : apply() -- matrix, data.frame 둘다 사용 

# 1) vector 이용
no <- 1:3
name <- c("홍길동", "이순신", "유관순")
pay <- c(250, 350, 200)

# cbind와 같이 데이터를 합치는데 각 열에 이름을 설정해줄 수 있음 (따로 설정 안하면 입력되는 변수명을 열 이름으로 설정)
emp <- data.frame(no, name, pay) # 합칠 데이터를 입력(각 데이터의 길이는 같아야함)
emp <- data.frame(no=no, name=name, pay=pay) # 위와 같음
emp <- data.frame(No=no, Name=name, Pay=pay) # 수정한 내용
dim(emp)
class(emp)
mode(emp)

# 자료 참조 : column 참조 ( $ ) or index 참조 ( [] )
# 형식) object column
mean(emp$Pay)
emp_row <- emp[c(1:2),]

# 2) csv, text file, db table
getwd() # 현재 작업공간 위치를 알려준다
setwd("C:/ITWILL/2_Rwork/Part-I") # 작업공간을 변경
emp_txt <- read.table("emp.txt", header = T, sep = "")
emp_csv <- read.csv("emp.csv")

class(emp_csv)

# [실습]
sid <- 1:3 #이산형
score <- c(90,85,83) #연속형
gender <- c('M', 'F', 'M') # 범주형

student <- data.frame(SID = sid, score = score, gender = gender, stringsAsFactors=F)

# 자료 구조 보기
str(student)
# int 이산형 (소숫점 포함 X)
# num 연속형 (소숫점 포함 O)
# Factor 범주형(요인형)
# chr 문자형

# 특정 컬럼 -> vector
scores <- student$score

mean(scores)
sum(scores)
var(scores)
# 표준편차
sqrt(var(scores))
sd(scores)

# 산포도 : 분산, 표준편차

# 모집단에 대한 분산, 표준편차
# 분산 = sum((x-산술평균)^2) / n
# 표준편차 = sqrt(분산)

# 표본에 대한 분산, 표준편차 <- R 함수
# 분산 = sum((x-산술평균)^2) / n-1
# 표준편차 = sqrt(분산)

avg <- mean(scores)
diff <- (scores -avg)^2
var <- sum(diff)/(length(scores)-1)
sd <- sqrt(var)

#################################
# 5. List 자료구조
# - key와 value 한쌍으로 자료가 저장된다
# - key를 통해서 값(value)을 참조한다.
# - key는 중복 불가, values는 중복 가능
# - 다양한 자료형(숫자, 문자, 논리), 다양한 자료구조(1~3차원)를 갖는 자료구조이다.

# 1) key 생략 : [key1 = value, key2 = value]
lit <- list('lee', '이순신', 35, 'hong', '홍길동', 30)

# 첫번째 원소 : key + value
# [[1]] -> 기본키(default key)
#  [1] "lee" -> 값1(value)

# 두번째 원소 : key + value
# [[2]] -> 기본키(default key)
#  [1] "이순신" -> 값2(value)
print(lit)
lit[1]
lit[6]

# key -> value 참조
lit[[5]]

# 2) key = value
lit2 <- list(55,first=1:5, 77,second = 6:10)
lit2

# $first -> key
# [1] 1 2 3 4 5 -> value

# key -> value 참조 
lit2$first
lit2[[2]]

# 참조
# $를 참조에 사용하는 구조 : data.frame, list
# data.frame은 $로 column을 참조 
# list에서 $는 key를 참조

lit2$first[3]
lit2$second[2:4]


# 3) 다양한 자료형 (숫자형, 문자형, 논리형)
lit3 <- list(name = c("홍길동","유관순"),
             age = c(35,25),
             gender = c('m','f'))
lit3
mean(lit3$age)

# 4) 다양한 자료 구조 (vector, matrix, array)
lit4 <- list(one = c('one','two','three'),
             two = matrix(1:9, nrow = 3),
             three = array(1:12, c(2,3,2)))
# lit4
# $one : 1차원
# $two : 2차원
# $three : 3차원
lit4$three[2,2,2]

# 5) list 형변환 -> matrix
multi_list <- list(r1 = list(1,2,3),
                   r2 = list(10,20,30),
                   r3 = list(100,200,300))
multi_list$r1[[3]]

# do.call함수 : 리스의 복잡한 자료구조를 단순한 행렬로 변환시키는 함수
one_list <- do.call(rbind, multi_list)
one_list

# 6) list 처리 함수
x <- list(1:10) # key 생략 -> [[n]]
x

# list -> vector
v <- unlist(x) # key 제거

a <- list(1:5)
b <- list(6:10)

lapply(c(a,b), max) # vector or list를 입력 받고 list로 반환   (a와 b의 값들 중 최대치를 리스트에 저장)
                    # lapply의 결과에 unlist를 하면 vector로 반환됨!!
sapply(c(a,b), max) # unlist 없이 vector로 반환 (a와 b의 값들 중 최대치를 벡터로 저장)

vapply()
dim(iris[,1])
logical(length(iris[, 1]))

###########################################
# 6. 서브셋 (subset) // 주로 data.frame이용
# - 기존에 저장된 데이터 셋에서 특정 행 또는 열 선택 후 새로운 dataset 생성
a <- 1:5
b <- 6:10
c <- letters[1:5] # letters는 기본 저장되어있는 dataset

df <- data.frame(a, b, c) # 기본적으로 여러 데이터를 DF로 생성할떄 cbind와 같은 효과를 갖고있음
df[2,3] # 2행 3열은 b이고 (해당 열에 어떠한 값들이 있는지 표현)
df[3,]

help(subset)
# subset( 대상인 객체, 조건식, 특정 column, 나머지에대한 제거 여부, ....)

# 1) 조건식으로 subset 생성 : 행 기준 
df2 <- subset(df, df[1] >= 2 ) # 여기서 x는 행을 말함

# 2) select로 subset 생성 : column 기준
df3 <- subset(df, select = c(a,c))

# 3) 조건식 & select 이용 subset 생성
df4 <- subset(df, x >= 2 & x <= 4, select = c(a,c))

# 4) 특정 칼럼의 특정 조건 값으로 subset 생성
df5 <- subset(df, c %in% c('a','c','e'))

# [실습] iris dataset 이용 subset 생성
iris
str(iris)  # 특정 데이터 셋 구조 확인

# iris 데이터 구조
# 'data.frame':	150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

iris_df <- subset(iris, Sepal.Length >= mean(Sepal.Length),
                  select = c('Sepal.Length', 'Petal.Length', 'Species'))
mean(iris$Sepal.Length)
str(iris_df)

##############################
# 7. 문자열 처리와 정규 표현식 
# install.packages("stringr") # 문자열을 처리하는 함수
library(stringr)

string <- "h_ong35lee45kang55유관순25이사도시45BOOK5힇4힣"
str_extract_all(string, "\\w{20}") # \\w 는 문자인 것만 추출하는것 {20} 연속 20글자를 추출하라는 의미
                                   #        문자(특수문자가 아닌 것)   참고!! _는 특수문자 같지만 예외로 둔다

# 메타 문자 : 문자열을 추출하는 패턴지정(약속된) 특수 기호 // R에서도 사용하고 phython에서도 사용하고 공용임 

# 1) str_extract_all   _all이 있다면 조건 충족하는 부분 모든 것을 추출 
                            # 없다면 처음에 오는 것만 추출

# 1) 반복관련 메타문자 : [ x ] : x가 1개인 패턴 , { n } : n개 연속되는 패턴
str_extract_all(string, "[a-z]{3}") # string에서 영문소문자 3개가 연속되는 부분 추출
str_extract_all(string, "[A-z,가-힇]{3,}") # {3, } 영문대소문자 or 한글 3글자 이상 연속되는 부분 추출

name <- str_extract_all(string, "[가-힣]{3,}")
unlist(name)
name

name <- str_extract_all(string, "[가-힣]{3,6}")
name

# 숫자(나이) 추출
ages <- str_extract_all(string, "[0-9]{1,}") # 숫자형인 나이가 (리스트,문자형)으로 추출됨

# 데이터 구조성격을 갖고있는 ages를 숫자형으로 바꿀수 없으므로 벡터형식으로 바꾸기 위해 unlist를 함
# 이후 숫자형으로 변경
num_age <- as.numeric(unlist(ages))
cat('나이 평균 = ', mean(num_age))

# 2) 단어와 숫자 관련 정규 표현식(메타문자)
# 단어( 영문자, 한글, 숫자 but _ 이외 특수문자 제외 ) 
# : \\w  
# 숫자 
# : \\d

# ※ \n : 줄바꿈 
# ※  path : C:\\Rwork 

jumin <- "133456-4234567"
str_extract_all(jumin, "\\d{6}-[1-4]\\d{6}")

num <- 12355
str_extract_all(num, "\\d{2}")

email <- "kp1234@naver.com"
email2 <- "kp$1234@naver.com"
str_extract_all(email2, "^[a-z]\\w{3,}@[a-z]{3,}.[a-z]{2,}")


# 3. 접두어(^) / 접미어($)  처음과 끝을 사용하는 메타문자
email3 <- "kp1234@naver.com"
str_extract_all(email3, "^[a-z]\\w{3,}@[a-z]{3,}.[a-z]{2,}") 
 # ^[a-z] 시작이 영문소문자로 시작해야한다는 조건
str_extract_all(email3, "\\w{1,}@\\w{1,}.com$")
string3 <- "123456sss545433ddd"
str_extract_all(string3, "\\w{1,}3$")

# 4. 특정 문자 제외 메타문자 
string
result <- str_extract_all(string, "[^0-9]{1,}") # 숫자 제외 나머지만 반환(리스트 구조에 문자형으로)
result2 <- str_extract_all(result[[1]], "[가-힣]{1,}")
result3 <- unlist(result2)
str(result3)


string
# 2) str_length : 문자열의 길이를 반환
str_length(string)

# 3) str_locate / str_locate_all
str_locate(string, 'g')
str_locate_all(string, 'g') # 1개 문자의 위치를 찾을때 start 와 end는 같다

# 4) str_replace / str_replace_all
str_replace_all(string, "\\d{2}", " ") # 2글자 이상의 숫자를 제거 

# 5) str_sub : 부분 문자열 (start & end 문자열의 시작위치와 종료위치)
str_sub(string, start = 3, end = 5) 

# 6) str_split : 문자열 분리 (토큰)
string2 <- "홍길동, 이순신, 감감찬, 유관순"
result <- str_split(string2, ", ")

name <- unlist(result)
str(name)

# 7) 문자열 결합(join) : 기본함수
paste(name, collapse = ",") # collapse 결합시 구분되는 구분점


\