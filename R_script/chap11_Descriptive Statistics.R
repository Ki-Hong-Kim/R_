########################################
# chap11_Descriptive Statistics 수업내용
########################################

# 기술통계(Descriptive Statistics) - 3개의 범주주
# 대푯값 : 평균(Mean), 합계(Sum), 중위수(Median), 최빈수(mode), 사분위수(quartile) 등
# 산포도 : 분산(Variance), 표준편차(Standard deviation), 최소값(Minimum), 최대값(Maximum), 범위(Range) 등 
# 비대칭도 : 왜도(Skewness), 첨도(Kurtosis)


# 실습파일 가져오기
setwd("C:/ITWILL/2_Rwork/Part-III")
data <- read.csv("descriptive.csv", header=TRUE)
head(data) # 데이터셋 확인

# 1. 척도별 기술통계량
#  - 데이터 특성 보기(전체 데이터 대상)
dim(data) # 행(300)과 열(8) 정보 - 차원보기
length(data) # 열(8) 길이
length(data$survey) #survey 컬럼의 관찰치 - 행(300) 

str(data) # 데이터 구조보기 -> 데이터 종류,행/열,data
str(data$survey) 

# 데이터 특성(최소,최대,평균,분위수,노이즈-NA) 제공
summary(data) 

# 1) 명목/서열 척도 변수의 기술통계량
# - 명목상 의미없는 수치로 표현된 변수 - 성별(gender)     
length(data$gender)
summary(data$gender) # 최소,최대,중위수,평균-의미없음
table(data$gender) # 각 성별 빈도수 - outlier 확인-> 0, 5

data2 <- subset(data,data$gender == 1 | data$gender == 2) # 성별 outlier 제거
x <- table(data2$gender) # 성별에 대한 빈도수 저장
x # outlier 제거 확인
barplot(x) # 범주형(명목/서열척도) 시각화 -> 막대차트

prop.table(x) # 비율 계산 : 0< x <1 사이의 값
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)






# gender에서 outlier값인 0,5를 제거해서 3개 데이터 수가 줄어듦

# 2) 등간/비율 척도 변수의 기술통계량
# - 비율척도 : 수치로 직접 입력한 변수(cost)  
length(data2$cost)
summary(data2$cost) # 요약통계량 - 의미있음(mean) - 8.784
mean(data2$cost) # NA
data2$cost

# 데이터 정제 - 결측치 제거 및 outlier 제거
plot(data2$cost)
boxplot(data2$cost)
data3 <- subset(data2,data2$cost >= 2 & data2$cost <= 10) # 총점기준
data3
plot(data3$cost)
x2 <- data3$cost
x2

# 2. 대푯값 : cost 변수  이용
mean(x2) # 평균 : 5.354
# 평균이 극단치에 영향을 받는 경우 - 중위수(median) 대체
median(x2) # 5.4  
min(x2)
max(x2)
range(x2) # min ~ max

sort(x2) # 오름차순 
sort(x2, decreasing=T) # 내림차순  

dim(data3)
# data.frame 정렬 : 특정 칼럼(cost)
library(dplyr)
head(data3)
head(data3[order(data3$cost),]) # 내용정렬 기존 열번호 유지
head(arrange(data3, cost))     # 내용정렬 새롭게 열이 바뀐 위치를 열번호로 설정

# order vs arrange
# order : 기존 행 번호 유지
# arrange : 새로운 행 번호 적용

# 최빈수(mode) 가장 많이 보이는 숫자
mode(x2) # data type 제공 

#install.packages("prettyR")
library(prettyR)
Mode(x2) #최빈수가 5

# 최빈수 = 중위수 = 평균 : 좌우대칭을 의미 
# 최빈수 < 중위수 = 평균 : 오른쪽으로 기울어짐
# 중위수 = 평균 < 최빈수 : 왼쪽으로 기울어짐

# 3. 산포도 : cost 변수 이용 
var(x2) # 분산
sd(x2) # 표준편차는 분t산의 양의 제곱근

quantile(x2, 1/4) # 1 사분위수
quantile(x2, 3/4) # 3 사분위수 

min(x2) # 최소값
max(x2) # 최대값
range(x2) # 범위(min ~ max)


# 4. 비대칭도 :  패키지 이용
# install.packages("moments")  # 왜도/첨도 위한 패키지 설치   
library(moments)
cost <- data3$cost # 정제된 data
cost
# 왜도 - 평균을 중심으로 기울어진 정도
skewness(cost)   # 만약 0이면 대칭성을 의미 / 음수 : 오른쪽 / 양수 : 왼쪽

# 첨도 - 표준정규분포와 비교하여 얼마나 뽀족한가 측정 지표
kurtosis(cost) # 3에 가까워야 정규분포를 의미함

# 기본 히스토그램 
hist(cost) 
mean(cost)
Mode(cost)
median(cost)
# 최빈수 < 평균 < 중위수 왼쪽에 꼬리가 생김


# 히스토그램 확률밀도/표준정규분포 곡선 
hist(cost, freq = F)

# 확률밀도 분포 곡선 : 히스토그램의 밀도 추정 
lines(density(cost), col='blue')

# 표준정규분포 곡선 
x <- seq(0, 8, 0.1)
curve( dnorm(x, mean(cost), sd(cost)), col='red', add = T) # 그림으로 정규성 검정


# 정규성 검정
shapiro.test(cost)
# 귀무가설(H0: 정규분포와 차이가 없다) 기각 ==> 차이가 있다(= 정규성을 띄지 않는다)

# 정규성 검정을 하는 이유
# 정규성 검정 결과에 따라 
# 모수 검정 / 비모수 검정 방법이 달라짐 




#### 5. 기술통계량 보고서 작성법 ####

# 1) 거주지역 
data3$resident2[data3$resident == 1] <-"특별시"
data3$resident2[data3$resident >=2 & data3$resident <=4] <-"광역시"
data3$resident2[data3$resident == 5] <-"시구군"

x3<- table(data3$resident2)
x3
prop.table(x3) # 비율 계산 : 0< x <1 사이의 값
y <-  prop.table(x3)
round(y*100, 2) #백분율 적용(소수점 2자리)
#광역시 시구군 특별시 
#37.66  14.72  47.62

# 2) 성별
data3$gender2[data3$gender== 1] <-"남자"
data3$gender2[data3$gender== 2] <-"여자"
x4<- table(data3$gender2)
x4
prop.table(x4) # 비율 계산 : 0< x <1 사이의 값
y <-  prop.table(x4)
round(y*100, 2) #백분율 적용(소수점 2자리)
#남자  여자 
#58.87 41.13

# 3) 나이
summary(data3$age)# 40 ~ 69
data3$age2[data3$age <= 45] <-"중년층"
data3$age2[data3$age >=46 & data3$age <=59] <-"장년층"
data3$age2[data3$age >= 60] <-"노년층"
x5<- table(data3$age2)
x5
prop.table(x5) # 비율 계산 : 0< x <1 사이의 값
y <-  prop.table(x5)
round(y*100, 2) #백분율 적용(소수점 2자리)
#노년층 장년층 중년층 
#24.60  68.15   7.26

# 4) 학력수준
data3$level2[data3$level== 1] <-"고졸"
data3$level2[data3$level== 2] <-"대졸"
data3$level2[data3$level== 3] <-"대학원졸"

x6<- table(data3$level2)
x6
prop.table(x6) # 비율 계산 : 0< x <1 사이의 값
y <-  prop.table(x6)
round(y*100, 2) #백분율 적용(소수점 2자리)
#고졸     대졸 대학원졸 
#39.41    36.44    24.15

# 5) 합격여부
data3$pass2[data3$pass== 1] <-"합격"
data3$pass2[data3$pass== 2] <-"실패"
x7<- table(data3$pass2)
x7
prop.table(x7) # 비율 계산 : 0< x <1 사이의 값
y <-  prop.table(x7)
round(y*100, 2) #백분율 적용(소수점 2자리)
#실패  합격 
#40.85 59.15

head(data3) # data Mart


# <논문/보고서에서 표본의 인구통계적특성 결과 제시 방법>














