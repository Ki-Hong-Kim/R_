 # chap05_DataVisualization

# 차트 데이터 생성
chart_data <- c(305,450, 320, 460, 330, 480, 380, 520) 
names(chart_data) <- c("2016 1분기","2017 1분기","2016 2분기",
                       "2017 2분기","2016 3분기","2017 3분기","2016 4분기","2017 4분기") #당연하게 chart_data와 같은 수의 길이를 갖고있어야함 
str(chart_data)
mode(chart_data)
chart_data
max(chart_data) # 520

# 1. 이산변수 시각화
# - 정수단위로 나누어지는 수 (자녀수, )
# (1) 막대차트 barplot
# - 세로 막대차트 (세로막대는 barplot의 기본값)
barplot(chart_data, # 막대차트로 작성할 데이터
        ylim = c(0, 600), # y축은 각 x축의 값들(max(chart_data)로 확인한 최대값으로 y축 범위 지정)
        main = "2016년 vs 2017년 판매현황", # 막대차트 제목 
        col = rainbow(50)) # 막대차트 구분생상 설정 (rainbow(n) 에서 n은 구분할 수 있는 색상 개수)

# - 가로 막대차트 (barplot에 horiz = T를 통해 가로 막대차트 생성)
barplot(chart_data,
        xlim = c(0, 600),
        main = "2016년 vs 2017년 판매현황",
        col = rainbow(50),
        horiz = T) # horiz=T == 축변환 T

par(mfrow = c(1,2)) # plot창에 출력구조 설정 (1행에 2개 표를 입력할 수 있게 설정)
VADeaths
str(VADeaths) # 5행 4열

row_names <- row.names(VADeaths)
row_names
col_names <- colnames(VADeaths)
col_names

barplot(VADeaths,
        beside = F, # 1개의 x축에 누적해서 출력
        main = "버지니아 사망비율",
        col = rainbow(5),
        legend = rownames(VADeaths)
        )

barplot(VADeaths,
        beside = T, # 각 x축 구분하고 x축 내에서도 구분
        main = "버지니아 사망비율",
        col = rainbow(5),
        legend = rownames(VADeaths))

# 그래프 범례 추가 
legend(x=20, y=70, legend = row_names, fill = rainbow(50)) # 옵션 공부할것

# (2) 점 차트
dotchart(chart_data,
         color = c("green","red"),
         lcolor = "black",
         pch = 1:2, # 포인터 캐릭터 :
         labels = names(chart_data), # 각 포인터를 설명하는 label을 해당 포인터의 y축에 표기
         xlab = "매출액", # x축 이름
         main = "분기별 판매현황 점 차트 시각화",
         cex = 1.3) # 글자나 포인터 의 크기 설정

# (3) 파이차트 시각화
pie(chart_data,
    labels = names(chart_data),
    border = "blue",
    col = rainbow(50),
    cex = 1.2,
    main = "2016-2017년도 분기별 매출현황")

title("2016-2017년도 분기별 매출현황") #차트 작성후에 타이틀 설정 가능

table(iris$Species)
pie(table(iris$Species),
    col = rainbow(3),
    main = "iris 꽃의 종 빈도수")

# 2. 연속변수 시각화
# - 시간, 길이 등의 연속성을 갖는 변수

# 1) 상자 그래프 시각화
summary(VADeaths)
quantile(VADeaths[,1]) # 분위수

boxplot(VADeaths) # 지역(도심, 시골), 성별(남, 여)

# 2) 히스토그램 시각화 (hist: 연속형 데이터 사용 /// barplot: 이산형데이터 사용)
# -  대칭성 확인
par(mfrow=c(1,2)) # y축을 설명하는 값에 차이 확인!!

hist(iris$Sepal.Width,
     xlab = "iris$Sepal.Width",
     col = "mistyrose",
     main = "iris 꽃받침 넓이 histgram",
     xlim = c(2,4.5), breaks = 10) # range(iris$Sepal.Width) 확인 후 xlim 범위 설정

hist(iris$Sepal.Width,
     xlab="iris$Sepal.Width",
     col="mistyrose",
     freq = F, # y축을 밀도로 표시
     main="iris 꽃받침 넓이 histogram",
     xlim=c(2.0, 4.5)) 


# 밀도분포 곡선 (대칭성을 더 쉽게 확인가능,)
lines(density(iris$Sepal.Width), col="red")

n <- 10000
x <- rnorm(n, 0, 1) # n개의 난수가 평균은 0을 갖고 표준편차가 1인 분포
hist(x, freq = F)

lines(density(x), col = "red")

# 3) 산점도 시각화
Dx <- runif(15, min = 1, max = 100)
plot(Dx) # Dx에 저장된 객체값들이 y축에 들어가고 
         # x축에 객체값들의 위치인 index가 들어감

par(mfrow = c(1,2))
Dy <- runif(15,5,120)
plot(Dx, Dy)  # 1)
plot(Dx ~ Dy) # 1)과 같은 결과임임

# col 속성 = 범주형
head(iris, 10)
plot(iris$Sepal.Length, 
     iris$Petal.Length,
     col = iris$Species)
legend(x = 100, y = 2, legend = unique(iris$Species), fill = unique(iris$Species))
# 레전드(레전드의 x는 왼면 y는 윗면을 기준으로 차트의 범위를 보고 작성)

# 선의 옵션
par(mfrow = c(2,3))
price <- rnorm(50)
plot(price, type="l") # 유형 : 실선 
plot(price, type="o") # 유형 : 원형과 실선(원형 통과) 
plot(price, type="h") # 직선 
plot(price, type="s") # 꺾은선

plot(price, type="o", pch=5) # 빈 사각형 
plot(price, type="o", pch=15)# 채워진 마름모 
plot(price, type="o", pch=20, col="blue") #color 지정 
plot(price, type="o", pch=20, col="orange", cex=1.5) #character expension(포인터 확대) 
plot(price, type="o", pch=20, col="green", cex=2.0, lwd=3) #lwd : line width

# 만능차트
methods(plot)

# plot.ts : 시계열 자료
WWWusage
plot(WWWusage) # x축: 시간 / y축: 시간에 따른 변화

# plot.lm :회귀모델
#install.packages("UsingR")
library(UsingR)
library(help = "UsingR")
data(galton)
gal <- galton
str(gal)
# 유전학자 갈톤 : 회귀 용어 제안 
model <- lm(child ~ parent, data = gal)
summary(model)
plot(model) # 회귀모델에 사용가능한 표들을 보여줌
# plot 화면에 모두 출력가능하면 출력되지만 출력개수가 부족하면 메시지 나옴

# 4) 산점도 행렬 : 변수 간의 비교 
pairs(iris[-5]) # iris 종을 제외한 데이터 비교 

# iris 꽃의 종별 산점도 행렬 
table(iris$Species)
pairs(iris[iris$Species == 'setosa', 1:4])
pairs(iris[iris$Species == 'virginica', 1:4])

# 5) 차트 파일 저장 
setwd("C:/ITWILL/2_Rwork/output")
jpeg("iris.jpg", width = 720, height = 480)
plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species)
title(main = "iris 데이터 테이블 산포도 차트")
dev.off() # 장치 종료

#########################
### 3차원 산점도 
#########################
# install.packages('scatterplot3d')
library(scatterplot3d)

# 꽃의 종류별 분류 
iris_setosa = iris[iris$Species == 'setosa',]
iris_versicolor = iris[iris$Species == 'versicolor',]
iris_virginica = iris[iris$Species == 'virginica',]

# scatterplot3d(밑변(x축), 오른쪽변(y축), 왼쪽변(높이), type='n') # type='n' : 기본 산점도 제외 
d3 <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type='n')

d3$points3d(iris_setosa$Petal.Length, iris_setosa$Sepal.Length,
            iris_setosa$Sepal.Width, bg='orange', pch=21) # bg = 백그라운드 색상

d3$points3d(iris_versicolor$Petal.Length, iris_versicolor$Sepal.Length,
            iris_versicolor$Sepal.Width, bg='blue', pch=23)

d3$points3d(iris_virginica$Petal.Length, iris_virginica$Sepal.Length,
            iris_virginica$Sepal.Width, bg='green', pch=25)
