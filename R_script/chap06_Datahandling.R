##################################################################
#
##################################################################





# chap06_Datahandling

# 1. dplyr 패키지 

# install.packages("dplyr")
library(dplyr)

# 1) 파이프 연산자 : %>% 
# 형식) df %>% func1() %>% func2()

head(iris)
iris %>% head() %>% filter(Sepal.Length >= 5)
#데이터 관측지 변화과정  150 > 6 > 3

#install.packages("hflights")
library(hflights)
hf <- hflights
str(hf)
head(hf)

# 2) tbl_df : 
hf_df <- tbl_df(hf)
str(hf_df)

# 3) filter : 특정한 조건에 해당되는 행 출력
# 형식) df %>% filter(조건식)
iris %>% filter(Species == "setosa") %>% head()
iris %>% filter(Sepal.Width > 3) %>% head()
iris_df <- iris %>% filter(Sepal.Width > 3) %>% head()

# 파이프 연산자 없이 filter 사용
filter(iris, Sepal.Width >3)
filter(hf_df, Month == 1 & DayofMonth == 1)
filter(hf_df, Month == 1 | Month == 2)

# 4) arrange(특정 컬럼) : 컬럼 정렬 함수 (기본적으로 오름차순)
# 형식) df %>% arrange(컬럼명)
iris %>% arrange(Sepal.Width) %>% head()
iris %>% arrange(desc(Sepal.Width)) %>% head()

# 형식) arrange(df, 컬럼명) :월 > 도착시간 순으로 정렬
arrange(hf_df, Month, ArrTime) #오름차순
arrange(hf_df, desc(Month), ArrTime) # 월(내림차순) ->  도착시간(오름차순)  

# 5) select() : 열 추출
# 형식) df %>% select()
iris %>% select(Sepal.Length, Sepal.Width, Petal.Length, Species) %>% head()
iris %>% select(c(1:3,5)) %>% head()

# 형식) select(df, col1, col2, col3, ...)
select(hf_df, DepTime, ArrTime, TailNum, AirTime)
select(hf_df, Year:DayOfWeek)

# 문) Month 기준으로 내림차순 정렬하고 Year, Month, AirTime 칼럼 선택
hf_df %>% arrange(desc(Month)) %>% head() %>% select(DepTime, AirTime)

# 6) mutate() : 파생변수 생성
# 형식) df %>% mutate(파생변수이름 = 함수 or 수식)
iris %>% mutate(diff = Sepal.Length - Sepal.Width) %>% head()

# 형식) mutate(df, 파생변수 = 함수 or 수식)
select(mutate(hf_df, diff_delay = ArrDelay - DepDelay),
       ArrDelay, DepDelay, diff_delay)

# 7) summarise : 요약통계를 구하는 함수 (NA값을 처리해줘야함)
# 형식) df %>% summarise(변수 = 통계함수())
iris %>% group_by(Species) %>%
  summarise(col1_avg = mean(Sepal.Length),
            col2_sd  = sd(Sepal.Width))
summarise




# 형식) summarise(df, 변수 = 통계함수()) 
summarise(hf_df,
          delay_avg = mean(DepDelay, na.rm = T),
          delay_tot = sum(DepDelay, na.rm = T)) #출발지연시간 평균/합계


# 8) group_by(dataset, 집단변수)
# 형식) df %>% group_by(집단변수)
names(iris)
table(iris$Species)
# 꽃 종자 별로 그룹으로 묶음
grp <- iris %>% group_by(Species)
str(iris)
str(grp) # 눈에 띄는 차이는 없음


# 묶인 그룹별 평균을 구함
summarise(grp, mean(Sepal.Length))


# [실습] group_by() 
# install.packages("ggplot2")
library(ggplot2)

data("mtcars") # 제조사에 따른 자동차 연비
head(mtcars)
str(mtcars)

# 특정 변수별 개수확인
table(mtcars$cyl) # 4:11, 6:7, 8:14
table(mtcars$gear)

# grp는 iris데이터를 종별로 group_by한 함수
grp %>% summarise(k = mean(Sepal.Length))
grp %>% summarise(k <- mean(Sepal.Length)) 

# group : cyl 
grp2 <- mtcars %>% group_by(cyl)
summarise(grp2, mpg_avg = mean(mpg),
                mpg_sd = sd(mpg))

# 각 gear 집단별 무게(wt) 평균/표준편차
grp3 <- mtcars %>% group_by(gear)
summarise(grp3, mpg_avg = mean(wt),
                mpg_sd = sd(wt))

# 두 집단변수 -> 그룹화
grp4_1 <- mtcars %>% group_by(cyl, gear) # cyl 1차 / gear 2차

summarise(grp4_1, mpg_avg = mean(mpg),
                  mpg_sd = sd(mpg)) # mpg_sd에서 NaN값이 나오는 이유: 표준편차를 구하려면 객체가 2개 이상이어야하는데 1개뿐
# summarise결과를 보고 어떤 집단변수가 1차 그룹변수인지 확인 할 수 있따

# grp4_2 <- grp4_1 %>% select(c(cyl,gear, mpg)) %>%
# filter(cyl == 4 | cyl == 6) %>%
# filter(gear == 3 | gear == 5) %>%
# arrange(cyl, gear)

# sd(grp4_2$mpg)

# 형식) group_by(dataset, 집단변수)
# 예제) 각 항공기별 비행편수가 40편 이상이고
#       평균 비행거리가 2,000마일 이상인 경우의
#       평균 도착지연시간을 확인하시오


hf <- hflights #항공기들의 비행 기록
str(hf)
# 1) 항공기별 그룹화
planes <- hf %>% group_by(TailNum) 
# plan을 보면 Groups : TailNum [3,320] 인데
# hflights가 3,320대의 비행기들이 227,496번의 비행기록을 갖고있다는 의미

# 2) 항공기별 요약 통계
planes_sumary <- summarise(planes, count = n(), 
  # 각 비행기의 비행횟수를 n()함수로 확인 // 위에 group_by(TailNum)으로 묶어둬서 n()을 사용 할수 있음  
                  avg_d = mean(Distance, na.rm = T),
                  avg_arrd = mean(ArrDelay, na.rm = T)) 

planes_sumary # TailNum이 없는 데이터가 795개 있음

# 3) 항공기별 요약 통계 필터링 (비행횟수 40회 이상 and 비행거리 2000마일 이상)
filter(planes_sumary, count >= 40 & avg_d >= 2000)


# 2. reshape2
# install.packages("reshape2")
library(reshape2)

# 1) dcast() : long format -> wide format
setwd("C:/ITWILL/2_Rwork/Part-II")
data <- read.csv("data.csv")
data # Date : 구매일자 (col)
     # Customer_ID : 고객 구분자 (row)
     # Buy  : 구매수량 (fuction)
names(data)
dim(data)

data %>% arrange(Customer_ID, Date) # 22 3

dcast(data, Date ~ Customer_ID)

# dcast(dataset, dataset[,1] ~ data[,2], function)
# 특정 데이터에서 첫번째 열데이터를 행데이터로 두번쨰 열데이터를 열데이터로
# 형식) dcast(dataset, row ~ col, function) # 행렬교차
Wdata <- dcast(data, Customer_ID ~ Date, sum) # 5 8
#어떤 고객의 구매일자별 구매수량
data  # long format
Wdata # wide format
head(data)

data(mpg)
str(mpg)

mpg_df <- as.data.frame(mpg)
str(mpg_df)

mpg_df0 <- select(mpg_df, c(cyl, drv, hwy))
head(mpg_df0)

# cyl : number of cylinders
# drv : the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd
# hwy : highway miles per gallon

mpg_df0 %>% arrange(cyl,drv)

# 교차셀에 입력된 데이터 : mean(hwy)
tab1 <- dcast(mpg_df0, cyl ~ drv, mean)
tab1
mpg_df0 %>% filter(cyl == c(4,5)) %>% arrange(cyl, drv) #tab1에 NaN이 있는 이유 확인 cyl=4일때 drv에 r이 없음

# 교차셀에 hwy 출현 건수 length가 count와 같은 느낌
tab2 <- dcast(mpg_df0, cyl ~ drv, length) #tab1에 NaN이 있는 이유 쉽게 확인하는 방법
tab2

# 교차분할표
# table( 행딥단변수, 열집단변수 )
table(mpg_df0$cyl, mpg_df0$drv)

unique(mpg_df0$cyl)
unique(mpg_df0$drv)

# 2) melt() : wide -> long
Wdata
Ldata <- melt(Wdata, id = "Customer_ID")
head(Ldata %>% arrange(Customer_ID,variable),20)
# Customer_ID : 기준 칼럼 
# variable    : 열 이름 
# value       : 교차 셀의 값


names(Ldata)<- c("User_ID","Date","Buy")
head(Ldata)

# example
data(smiths)
smiths

# wide - > long
long <- melt(smiths, id = "subject")
long %>% arrange(subject)

long2 <- melt(smiths, id = 1:2) # id를 2개로 놓고
long2 %>% arrange(subject)

wide2 <- dcast(long2, subject ~...)

# long -> wide
wide <- dcast(long, subject ~...) # ... 은 나머지 변수를 의미함 
wide













# 3. acast(data, 행 ~ 열 ~ 면)
data("airquality")
airQ <- airquality
str(airQ)

table(airquality$Month)
table(airquality$Day)

head(airQ)
dim(airQ) # 153 6
# wide -> long
air_melt <- melt(airQ, id = c("Month", "Day"), na.rm = T)
dim(air_melt)

table(air_melt$variable)   # 어느 부분에 NA값이 많은지 알 수 있다
summary(air_melt$variable) # 위에서 NA값을 갖고있다면 제거했기 때문에 데이터량이 줄었으면 NA가 있었다는 의미 
head(air_melt)

# [일, 월, variable] -> [행, 열, 면]
# acast(dataset, Day ~ Month ~ variable)
air_arr3d <- acast(air_melt, Day ~ Month ~ variable)
              # air_melt에서 행:day 열:Month 면:(오존,솔라,온도,바람)
air_arr3d2 <- acast(air_melt, variable ~ Day ~ Month)

dim(air_arr3d)

air_arr3d[,,1] #오존 data
air_arr3d[,,2] #태양열 data

########## 추가 내용 ##########
# 4. URL 만들기  : http://www.naver.com?name='홍길동'

# 1) base url 만들기
baseUrl <- "http://www.sbus.or.kr/2018/lost/lost_02.htm"

# 2) page query 추가
# "http://www.sbus.or.kr/2018/lost/lost_02.htm?Page=1"
no <- 1:5
library(stringr)
page <- str_c('?Page=',no)
str(page)
page <- paste0('?Page=',no)

# outer(x(1개), y(n개), func )
page_url <- outer(baseUrl, page, str_c)
str(page_url)
class(page_url)
page_url <- outer(baseUrl, page, paste0) # 똑같음          str_c가 더 빠름 

# reshape : 2d -> 1d
page_url <- as.vector(page_url)
str(page_url)
class(page_url) #매트릭스가 아닌 각 벡터로 저장됨

# 3) sear query 추가
# http://www.sbus.or.kr/2018/lost/lost_02.htm?Page=1&sear=2
no <- 1:3 # 지갑 신분증 면허증
sear <- str_c("&sear=",no)
final_url <- outer(page_url, sear, str_c)
class(final_url)





