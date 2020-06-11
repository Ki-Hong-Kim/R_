# chap07_EDA_Preprocessing
# insight를 도출하기 위한 준비 과정 EDA 수집한 데이터를 이해하고 전처리하고 

# 1. 탐색적 데이터 조회

# 실습 데이터 읽어오기
setwd("C:/ITWILL/2_Rwork/Part-II")
dataset <- read.csv("dataset.csv", header=TRUE) # 헤더가 있는 경우
head(dataset)
# dataset.csv - 칼럼과 척도 관계 


# 1) 데이터 조회
# - 탐색적 데이터 분석을 위한 데이터 조회 

# (1) 데이터 셋 구조
names(dataset) # 변수명(컬럼)
attributes(dataset) # names(), class, row.names
str(dataset) # 데이터 구조보기
dim(dataset) # 차원보기 : 300 7
nrow(dataset) # 관측치 수 : 300
length(dataset) # 칼럼수 : 7 
length(dataset$resident) # 300

# (2) 데이터 셋 조회
# 전체 데이터 보기
dataset # print(dataset) 
View(dataset) # 뷰어창 출력

# 칼럼명 포함 간단 보기 
head(dataset)
head(dataset, 10) 
tail(dataset) 

# (3) 칼럼 조회 
# 형식) dataframe$칼럼명   
dataset$resident
length(dataset$age) # data 수-300개 // 컬럼 아무거나 해도 상관없음

# 형식) dataframe["칼럼명"] 
dataset["gender"] 
dataset["price"]

# $ vs index
dataset$resident # vector
dataset[1]       # data.frame

# 형식) dataframe[색인] : 색인(index)으로 원소 위치 지정 
dataset[2] # 두번째 컬럼 : == dataset['gender']  
dataset[6] # 여섯번째 컬럼
dataset[3,] # 3번째 관찰치(행) 전체
dataset[,3] # 3번째 변수(열) 전체 vector
dataset[3]

#  dataset[3]  != dataset[,3] : 저장되는 방식이 다름
# (data.frame)     (vector)

# dataset에서 2개 이상 칼럼 조회
dataset[c("job", "price")]
dataset[c("job":"price")] # error 
dataset[c(2,6)] 

dataset[c(1,2,3)] 
dataset[c(1:3)] 
dataset[c(2,4:6,3,1)] 
dataset[-c(2)] # dataset[c(1,3:7)] 


# 2. 결측치(NA) 발견과 처리
# 999999 - NA 

# 결측치 확인
dim(dataset)
summary(dataset) # NA 개수가나옴
table(is.na(dataset$price)) # 특정 행의 NA 개수
table(is.na(dataset))       # 데이터의 NA 총 개수

# 1) 결측치 제거
price2 <- na.omit(dataset$price) # 특정 열에서 NA를 제거 한뒤 저장했으므로 vector로 저장
price3 <- na.omit(dataset)       # 데이터 프레임에서 NA값을 제거 하므로 NA가 포함된열이 사라지고 데이터 프레임 형태 유지

dataset2 <- na.omit(dataset)
dim(dataset2)

# 2) 특정 컬럼 기준 결측치 제거 -> subset 생성 
setwd("C:/ITWILL/2_Rwork/Part-I")
stock <- read.csv("stock.csv")
str(stock) # 6706 obs. of 69 variables
# Market.Cap : 시가 총액
library(dplyr)
stock_df <- stock %>% filter(!is.na(Market.Cap)) # 시가총액이 NA가 아닌 데이터만 선택 (==시가총액이 NA인 데이터 제거)
str(stock_df) # 5028 obs. of 69 variables 시가총액(NA가 1678)

# 서브셋 - 기존에 저장된 데이터 셋에서 특정 행 또는 열 선택 후 새로운 dataset 생성
stock_df2 <- subset(stock, !is.na(Market.Cap))
dim(stock_df2)

# 2) 결측치 처리 (0으로 대체)
x <- dataset$price # 객체로 저장

head(dataset)
dataset$price2 <- ifelse(is.na(x), 0, x) # 객체를 데이터 프레임에 적용시 순서대로 입력됨 (입력될 데이터 프레임의 행번호 ==  입력될 벡터의 순번)
# 기존 price 칼럼에서 na값을 0으로 바꾼 새로운 칼럼을 price2로 만듦

# 3) 결측치 처리 (평균으로 대체)
dataset$price3 <- ifelse(is.na(x), mean(x,na.rm = T), x) # 기존 dataset에 새로운 칼럼추가
dim(dataset)

tail(dataset[c('price','price2','price3')],11) # tail(data, n) data 뒤에서 n번째까지만 출력

# 4) 통계적 방법의 결측치 처리 
# ex) 1 ~ 4 : age 결측치 -> 각 학년별 평균으로 대체 

# runif(n, min, max)

age <- round(runif(12, 1, 25)) # 1~25 사이 난수 12개 생성 후 올림
age
grade <- rep(1:4, 3) #1:4를 3번 반복
grade

age[5] <- NA
age[8] <- NA

DF <- data.frame(age, grade)
DF

# age 칼럼 대상 학년별 결측치 처리 -> age2 만들기

# [1]
DF
DF_A <- data.frame()

for(i in 1:4){ # i <- 1
 DF_t <- DF %>% filter(grade == i) 
 M_t <- mean(DF_t$age,na.rm=T)
 
  for(x in 1:nrow(DF_t)){ # x<-2
   DF_t$age[x]<- ifelse(is.na(DF_t$age[x]) == T, M_t, DF_t$age[x])
  }

 DF_A <- rbind(DF_A,DF_t)
}
DF_A 



for(i in 1:nrow(DF)){if(!is.na(DF$age[i])){
  
  DF$age2[i] <- DF$age[i]
  }else{
    
DF$age2[i] <- mean(filter(DF, grade == DF$grade[i])$age, na.rm=T) %>% round()    
  }
}
DF


###############################
for(i in 1:nrow(df)){
  if(is.na(df$Age[i])){
    
    temp_grade = df$Grade[i]
    
    temp = mean(filter(df, Grade == df$Grade[i])$Age, na.rm=T)
    
    df$Age[i] = round(temp)
  }
}



#################################################
################## 교수님 답 ####################
age <- round(runif(n=12, min=20, max =25))
age
grade <- rep(1:4, 3)
grade

age[5] <- NA
age[8] <- NA

DF <- data.frame(age, grade)
DF

# age 칼럼 대상 학년별 결측치 처리 -> age2 만들기 
n <- nrow(DF)
g1=0;g2=0;g3=0;g4=0 # 학년별 누적 나이 합
for(i in 1:n){ # i = index
  if(DF$grade[i]==1 & !is.na(DF$age[i])){
    g1 = g1 + DF$age[i]
  }else if(DF$grade[i]==2 & !is.na(DF$age[i])){
    g2 = g2 + DF$age[i]
  }else if(DF$grade[i]==3 & !is.na(DF$age[i])){
    g3 = g3 + DF$age[i]
  }else if(DF$grade[i]==4 & !is.na(DF$age[i])){
    g4 = g4 + DF$age[i]
  }
}

# 각 학년별 나이 합계 
g1;g2;g3;g4
tab <- table(DF$grade)
age2 <- age
for(i in 1:n){
  if(is.na(DF$age[i]) & DF$grade[i]==1)
    age2[i] <- g1/2
  if(is.na(DF$age[i]) & DF$grade[i]==2)
    age2[i] <- g2/2
  if(is.na(DF$age[i]) & DF$grade[i]==3)
    age2[i] <- g3/2
  if(is.na(DF$age[i]) & DF$grade[i]==4)
    age2[i] <- g4/2
}
age2
DF$age2 <- round(age2)
DF


###############
# 3. 이상치(outlier) 발견과 정제
# - 정상 범주에서 크게 벗어난 값

# 1) 범주형(집단) 변수

gender <- dataset$gender

# 이상치 발견 : table(), 차트
table(gender) # gender은 성별을 의미하므로 2개로 이루어져있어야함
pie(table(gender))

# 이상치 정제 
dataset2 <- subset(dataset, gender==1 |gender==2) #gender중 이상치 값는 row 제거 
table(dataset2$gender)
pie(table(dataset2$gender))

# 2) 연속형 변수
price <- dataset2$price
length(price)
plot(price)
summary(price)

# 대략적인 2~10 정상범주
dataset3 <- subset(dataset2, price >= 2 & price <= 10)
dim(dataset3)
summary(dataset3$price)
plot(dataset3$price)
boxplot(dataset3$price)

# dataset3 : age(20~69)
table(dataset3$age)
summary(dataset3$age)

dataset4 <- subset(dataset3, age >= 20 & age <= 69)
boxplot(dataset4$age)

# 3) 이상치 발견이 어려운 경우
boxplot(dataset2$price)$stats # 정상으로 생각할 수 있는 범위
# 정상범주에서 상하위 0.3%

dataset3_1 <- subset(dataset2, price >= 2.1 & price <= 7.9)
boxplot(dataset3_1$price)

library(ggplot2)
str(mpg)
hwy <- mpg$hwy
length(hwy)

boxplot(hwy)$stats

# 정제 방법 1) 이상치 제거
library(dplyr)
subset(mpg, hwy >= 12 & hwy <=37)$hwy %>% boxplot()
dim(subset(mpg, hwy >= 12 & hwy <=37))

# 정제 방법 2) 이상치 NA 처리
mpg$hwy2  <- ifelse(mpg$hwy< 12 | mpg$hwy > 37, NA, mpg$hwy)

str(mpg)
class(mpg)

mpg_df <- as.data.frame(mpg)

mpg_df[,c('hwy','hwy2')]

# 4. 코딩 변경
# - 데이터 가독성, 척도 변경,  최초 코딩 내용 변경

# 1) 데이터 가독성(1,2)
dataset <- read.csv("dataset.csv", header=TRUE) 
dataset$gender2 <- ifelse(dataset$gender != 1 & dataset$gender != 2, "미입력", dataset$gender)
dataset$gender2[dataset$gender ==1] <- "남자"
dataset$gender2[dataset$gender ==2] <- "여자"

table(dataset$gender2)

dataset$resident2[dataset$resident==1] <- "1.서울특별시"
dataset$resident2[dataset$resident==2] <- "2.인천광역시"
dataset$resident2[dataset$resident==3] <- "3.대전광역시"
dataset$resident2[dataset$resident==4] <- "4.대구광역시"
dataset$resident2[dataset$resident==5] <- "5.시구군"
dataset$resident2[is.na(dataset$resident)] <- "미입력"

head(dataset)

# 2) 척도 변경 : 연속형 -> 볌주형
dataset <- subset(dataset, age >= 20 & age <= 69)
range(dataset$age) 
# 20~30 : 청년층, 31~55 : 중년층, 56~: 장년층
dataset$age2[dataset$age <= 30] <- "청년층"
dataset$age2[dataset$age <= 55 & dataset$age >= 31] <- "중년층"
dataset$age2[dataset$age >= 56] <- "장년층"
head(dataset[c("age","age2")], 20)

# 3) 역코딩 1->5 , 5->1
table(dataset$survey)
dataset$survey2 <- 6 - dataset$survey
head(dataset[c('survey','survey2')])
table(dataset$survey2)
             

# 5. 탐색적 분석을 위한 시각화
# - 변수 간의 관계분석 

setwd("C:/ITWILL/2_Rwork/Part-II")

new_data <- read.csv("new_data.csv")
dim(new_data) # 231 15
str(new_data)

# 1) 범주형(명목/서열) vs 범주형(명목/서열)
# - 방법 : 교차테이블, barplot

# 거주지역(5개의 집단) vs 성별(2개의 집단)
tab1 <- table(new_data$resident2, new_data$gender2)

tab2 <- table(new_data$gender2, new_data$resident2)

barplot(tab1, beside = T, horiz = T, col = rainbow(5), main = "성별에 따른 거주지역 분포현황",
        legend = row.names(tab1))

barplot(tab2, beside = T, horiz = T,
        col = rainbow(2),
        main = "성별에 따른 거주지역 분포현황",
        legend = row.names(tab1))

# 정사각형 기준
mosaicplot(tab1, col=rainbow(2), main = "성별에 따른 거주지역 분포현황")

# 고급시각화 : 직업유형(범주형) vs 나이(age2 : 범주형)
library(ggplot2)

# 미적 객체 생성
obj <- ggplot(data = new_data, aes(x = job2, fill = age2 ))
# 미적객체에 막대차트 옵션 사용
 obj + geom_bar()
 
# 미적객체에 막대차트로 가득채우는 옵션사용
# 밀도 1기준으로 채우기
obj + geom_bar(position = 'fill')

table(new_data$job2, new_data$age2) # 결측치 포함 안됨!!
table(new_data$job2, new_data$age2, useNA = "ifany")
table(new_data$job2, useNA = "ifany")
table(new_data$age2, useNA = "ifany")

# 2) 숫자형(비율/등간) vs 범주형(명목/서열)
# - 방법 : boxplot, 카테고리별 통계 

# install.packages("lattice") #chap08
library(lattice) # lattice 격자

# 나이(비율) vs 직업유형(명목)
densityplot( ~ age, data = new_data)

densityplot( ~ age,
             groups = job2, #구분
             data = new_data,
             auto.key = T) #auto.key 현재 차트의 범례 표현

# groups = 집단변수 : 각 격자 내에 그룹 효과
# auto.key = T : 범례추가(그룹)

###########################################3개 
# 3) 숫자형(비율) vs 범주형(명목) vs 범주형(명목)
# (1) 구매금액을 성별과 직급으로 분류 (1급 고위직 : 5급 하위직)
densityplot( ~ price | factor(gender2), # | factor(집단변수) : 범주의 수 만큼 격자 생성
             groups = position2,        # groups = 집단변수  : 각 격자 내의 그룹 효과 
             data = new_data,
             auto.key = T)

densityplot( ~ price | factor(position2),
             groups = position2,        
             data = new_data)

# (2) 구매금액을 성별과 직급으로 분류
densityplot( ~ price | factor(position2),
             groups = gender2,        
             data = new_data,
             auto.key = T)


# 4) 숫자형 vs 숫자형 or 숫자형 vs 숫자형 vs 범주형
# - 방법 : 상관계수, 산점도, 산점도 행렬

# (1) 숫자형(age) vs 숫자형(price)
cor(new_data$age, new_data$price) #NA

new_data2 <- na.omit(new_data)
cor(new_data2$age, new_data2$price) #0.0881
# 상관계수는 0.3 ~ 0.4 정도 되야함
# 따라서 age와 price의 상관계수 0.0881은 상관성이 없다고 할 수 있음

plot(new_data2$age, new_data2$price) # 상관성이 안보임 (상관성이 있다면 방향상관 없이 대각선 모형을 띔)

# (2) 숫자형 vs 숫자형 vs 범주형(성별)
xyplot(price ~ age | factor(gender2),
       data = new_data)

head(new_data)

# 6) 파생변수 생성
# - 기존 변수를 이용해 만들어진 변수 
# 6_1. 사칙연산
# 6_2. 1:1 기존칼럼 -> 새로운 칼럼(1개)
# 6_3. 1:n 기준변수 -> 새로운 칼럼(n개)

user_data <- read.csv("user_data.csv")
str(user_data)

# _1] 1:1 : 기존칼럼 -> 새로운 칼럼(1)
# 더미변수: 숫자형이지만 숫자의 의미는 없는..
# 1,2 -> 1  /  3,4 -> 2
user_data$house_type2 <- ifelse(user_data$house_type == 1 | user_data$house_type == 2,1,
                                ifelse(user_data$house_type == 3 | user_data$house_type == 4 ,2 , NA))

table(user_data$house_type2)

# 2) 1:n 기준변수 -> 새로운 칼럼(n)
# 지불정보 테이블
pay_data <- read.csv("pay_data.csv")
dim(pay_data)
names(pay_data) # "user_id"      "product_type" "pay_method"   "price"(비율)     

library(reshape2)
# dcast(dataset, 행집단변수 ~ 열집단변수, fuc)    : long -> wide

# 고객별 상품유형에 따른 구매금액 합계
product_price <- dcast(pay_data, user_id ~ product_type, sum) # 
dim(product_price) # 303 6
product_price
names(product_price) <- c("user_id", "식료품(1)", "생필품(2)", "의류(3)", "잡화(4)", "기타(5)")

# 3) 파생변수 추가(join)
# 형식) left_join(df1, df2, by='column)
user_pay_data <- left_join(user_data, product_price, by = "user_id")

dim(product_price)
dim(user_data)  
dim(user_pay_data) #열은 user_id가 중복되므로 1개 줄어듬 

head(user_pay_data) # 400 11

# 4) 사칙연산 : 총구매금액 
head(user_pay_data)
apply(x, 1, sum)
user_pay_data$total_price <- apply(user_pay_data[,7:11],1,sum)
head(user_pay_data)

















