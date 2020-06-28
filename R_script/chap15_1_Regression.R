# chap15_1_Regression_Analysis

###############################################
####### 회귀분석(Regression Analysis)  ########
###############################################
# - 특정 변수(독립변수:설명변수)가 다른 변수(종속변수:반응변수)에 어떠한 영향을 미치는가 분석

###################################
######## 1. 단순회귀분석  #########
###################################
# - 독립변수와 종속변수가 1개인 경우

# 단순선형회귀 모델 생성  
# 형식) lm(formula= y ~ x 변수, data) 
setwd("C:/ITWILL/2_Rwork/Part-IV")

product <- read.csv("product.csv", header=TRUE)
head(product) # 친밀도 적절성 만족도(등간척도 - 5점 척도)

str(product) # 'data.frame':  264 obs. of  3 variables:
y = product$"제품_만족도" # 종속변수
x = product$"제품_적절성" # 독립변수
df <- data.frame("제품_만족도" = x, "제품_적절성" = y)

# 회귀모델(linear model) 생성 
result.lm <- lm(formula= 제품_적절성 ~ 제품_만족도, data=df)
result.lm # 회귀계수 
# Coefficients:
#   (Intercept)             x  
#       0.7789         0.7393  
# y = 0.7393x + 0.7789 (회귀방정식)
head(df)
X <- 4 # 입력변수
Y <- 3 # 정답
a <- 0.7393 # 기울기
b <- 0.7789 # 절편
y <- a*X + b
cat('y의 예측치 = ',y)

err <- y - Y
cat('model error =', err)

names(result.lm)
# coefficients: 회귀계수, residuals: 잔차, fitted.values: 적합치(y에 대한 예측치)

result.lm$coefficients
result.lm$residuals[1:5]
df$y[1:5]
result.lm$fitted.values[1:5] # 예측한 y값들
# df$y[1:5] - result.lm$fitted.values[1:5]

# 회귀모델 예측 
# y <- predict(model, x)
predict(result.lm, data.frame(제품_만족도=1))  # 적절성이 1일때 제품만족도
predict(result.lm, data.frame(제품_만족도=5)) 

# (2) 선형회귀 분석 결과 보기
summary(result.lm)
# < 회귀모델 해석 순서 >
# 1. F-statistic : p-value < 0.05     ===> 해석 통계적으로 이 모델은 유의하다
# 2. 모델의 설명력 (R-squared) 
# (피어슨의 R)  Adjusted R-squared : 0.5865        ===> 설명력(예측력) 1에 가까울수록 좋다
# 3. x의 유의성 검정: t value(-1.96 ~ +1.96 범위에 없어야 x와 y과 관계가 있다), p-value < 0.05

cor(df)
r <- 0.7668527   # 상관관계
r_squared <- r^2 # 상관관계 != 인과관계

# F값과 자유도를 통해 p값이 나옴 (여기서 p값은 이 모델의 유의한 정도를 파악하는데 사용)

# (3) 단순선형회귀 시각화
# x,y 산점도 그리기 
plot(formula=제품_적절성 ~ 제품_만족도, data=df, xlim = c(0,5), ylim = c(0,5)) 
# 회귀분석
result.lm <- lm(formula=제품_적절성 ~ 제품_만족도, data=df)
# 회귀선 
abline(result.lm, col='red')

result.lm$coefficients
# 결과의 근거는?

y <- product$"제품_만족도"
x <- product$"제품_적절성"

# 기울기(x의 cofficients) = Cov(x,y) / Sxx
Covxy = mean((x-mean(x)) * (y-mean(y)))
Sxx = mean((x-mean(x))^2) # 편차 제곱의 평균
a <- Covxy / Sxx

# 절편
b <- mean(y) - a * mean(x)


###################################
######### 2. 다중회귀분석  ########
###################################
# - 여러 개의 독립변수 -> 종속변수에 미치는 영향 분석
# 가설 : 음료수 제품의 적절성(x1)과 친밀도(x2)는 제품 만족도(y)에 정의 영향을 미친다.

product <- read.csv("product.csv", header=TRUE)
head(product) # 친밀도 적절성 만족도(등간척도 - 5점 척도)
str(product)


# (1) 변수 선택 : 적절성 + 친밀도 -> 만족도  
y = product$'제품_만족도' # 종속변수
x1 = product$'제품_친밀도' # 독립변수1
x2 = product$'제품_적절성' # 독립변수2

df <- data.frame(x1, x2, y)

result.lm <- lm(formula=y ~ x1 + x2, data=df)
#result.lm <- lm(formula=y ~ ., data=df)

# 계수 확인 
result.lm
# 0.66731 0.09593 0.68522
b <- 0.66731
a1 <- 0.09593
a2 <- 0.68522
head(df)

# 친밀도 = 3 적절성 = 4 일때 만족도?
X1 <- 3
X2 <- 4

y <- (a1*X1 + a2*X2) + b # 행렬곱의 합
Y <- 3
err <- Y - y
err # 실제값과 예측값의 차이
abs(err) # 부호는 의미가 없으므로 절대값을 씌움

# 분석결과 확인
summary(result.lm)
# 1. F-statisitc : p-value : 2.2e-16
# 2. Adjusted R-squared : 0.5945
# 3. x의 유의성 검정
#   x1(제품_친밀도)     0.09593    0.03871   2.478   0.0138 *  
#   x2(제품_적절성)     0.68522    0.04369  15.684  < 2e-16 ***
# 두 변수 모두 유의미하다. 그 중 '제품_적절성'이 더 '제품_만족도'를 잘 설명한다.
library(car)

Prestige # 102개의 직업군에 대한 평판 dataset
str(Prestige)
# $ education: num  / 교육수준 (x1)
# $ income   : int  / 수입 (y)
# $ women    : num  / 여성비율 (x2)
# $ prestige : num  / 평판(x3)
# $ census   : int  / 직업 수
# $ type     : Factor w/ 3 levels "bc","prof","wc"
row.names(Prestige)

# 필요한 변수만 선택한 subset 생성
df <- Prestige[,c(1:4)]
str(df)

model <- lm(income ~ . , data = df)
summary(model)
# education    177.199    187.632   0.944    0.347     == income과 관련이 없음
# women        -50.896      8.556  -5.948 4.19e-08 *** == income과 음의 상관관계를 갖고있음
# prestige     141.435     29.910   4.729 7.58e-06 *** == income과 양의 상관관계를 갖고있음

res <- model$residuals # 잔차(오차) = 정답 - 예측치
res
length(res)

res <- scale(res)

# MSE (평균제곱오차)
mse <- mean(res^2) # 6369159

######### 3. 변수 선택 ##########

new_data <- Prestige[,c(1:5)]
dim(new_data)
library(MASS)

model2 <- lm(income ~ ., data = new_data)
summary(model2) # adj R2 = 0.6389

res2 <- model2$residuals

# 잔차의 표준화
res_scale <- scale(res2)
scale_df <- data.frame(nscale = res2, scaled = res_scale)
plot(scale_df$nscale)
plot(scale_df$scaled)

# 변수 선택에 참조할 만한 데이터를 주는 함수 
step <- stepAIC(model2, direction = 'both') # 점진선택, 후진선택, 둘다

# MSE :  표준화
mse <- mean(res_scale**2)
mse # 가 1
# 제곱: 부호 절대값, 패널티
# 평균: 전체 오차에 대한 평균 

# AIC 지수가 작을수록 좋은 모델

model3 <- lm(income ~ women + prestige, data = new_data)
summary(model3) # adj R2 = 0.6327
# stepAIC는 회귀모델을 정확하면서 단순하게 만들기 위함이지 정확성만을 생각한것이 아님

############################################
##### 4. 다중공선성(Multicolinearity)  #####
############################################
# - 독립변수 간의 강한 상관관계로 인해서 회귀분석의 결과를 신뢰할 수 없는 현상
# - 생년월일과 나이를 독립변수로 갖는 경우
# - 해결방안 : 강한 상관관계를 갖는 독립변수 제거

# (1) 다중공선성 문제 확인
# install.packages("car")
library(car)
str(iris)

fit <- lm(Sepal.Length ~ Sepal.Width+Petal.Length+Petal.Width, data=iris)
fit <- lm(Petal.Width ~ Sepal.Length + Sepal.Width + Petal.Length, data = iris)

vif(fit)
sqrt(vif(fit))>2 # root(VIF)가 2 이상인 것은 다중공선성 문제 의심 


# (2) iris 변수 간의 상관계수 구하기
cor(iris[,-5]) # 변수간의 상관계수 보기(Species 제외) 
#x변수들끼리 계수값이 높을 수도 있다. -> 해당 변수 제거(모형 수정) <- Petal.Width

# (3) 학습데이터와 검정데이터 분류
x <- sample(1:nrow(iris), 0.7*nrow(iris)) # 전체중 70%만 추출
train <- iris[x, ] # 학습데이터 추출
test <- iris[-x, ] # 검정데이터 추출
dim(train) # 학습용 데이터
dim(test)  # 모델 검정용 데이터

# (4) model 생성 Petal.Width 변수를 제거한 후 회귀분석 
result.lm <- lm(formula=Sepal.Length ~ Sepal.Width + Petal.Length, data=train)
result.lm
summary(result.lm)

# (5) model 예측치 : test set
y_pred <- predict(result.lm, test)
y_pred

y_true <- test$Sepal.Length


# (6) model 평가 :  MSE & cor
# MSE(표준화 o)
Error <- y_true - y_pred
mean(Error^2) # MSE : 0.1163933 // 0에 가까울수록 정확도 높다는 으미

# 상관계수 r : 표준화(x)
cor(y_true, y_pred) # 1에 가까울수록 예측력이 좋다 이말

y_true[1:3]
y_pred[1:3]

# 시각화 정답 vs 예측치치
plot(y_true, col = "blue", type = "l")
points(y_pred, col='red', type = 'l')

legend("topleft", legend = c('y true', 'y pred'), col = c('blue','red'), pch = '-')

###############################################
####  5. 선형회귀분석 잔차검정과 모형진단  ####
###############################################

# 1. 변수 모델링   : x,y 변수 선정
# 2. 회귀모델 생성 : lm()
# 3. 모형의 잔차검정 
#   1) 잔차의 등분산성 검정: graph
#   2) 잔차의 정규성 검정  : shapiro.test
#   3) 잔차의 독립성(자기상관) 검정 
# 4. 다중공선성 검사 
# 5. 회귀모델 생성/ 평가 


names(iris)

# 1. 변수 모델링 : y:Sepal.Length <- x:Sepal.Width,Petal.Length,Petal.Width
formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width


# 2. 회귀모델 생성 
model <- lm(formula = formula,  data=iris)
model
names(model)


# 3. 모형의 잔차검정
par(mfrow = c(2,2))
plot(model)
#Hit <Return> to see next plot: 잔차 vs 적합값 -> 패턴없이 무작위 분포(포물선 분포 좋지않은 적합)  <등분산성>
#Hit <Return> to see next plot: Normal Q-Q -> 정규분포 : 대각선이면 잔차의 정규성                  <정규분포>
#Hit <Return> to see next plot: 척도 vs 위치 -> 중심을 기준으로 고루 분포                          
#Hit <Return> to see next plot: 잔차 vs 지렛대값 -> 중심을 기준으로 고루 분포 

# (1) 등분산성 검정 
plot(model, which =  1) 
methods('plot') # plot()에서 제공되는 객체 보기 

# (2) 잔차 정규성 검정
attributes(model) # coefficients(계수), residuals(잔차), fitted.values(적합값)
res <- residuals(model) # 잔차 추출 
res <- model$residuals
shapiro.test(res) # 정규성 검정 - p-value = 0.9349 >= 0.05
# 귀무가설 : 정규성과 차이가 없다.

# 정규성 시각화  
hist(res, freq = F) 
qqnorm(res)

# (3) 잔차의 독립성(자기상관 검정 : Durbin-Watson) 
# install.packages('lmtest') 회귀검정 패키지
library(lmtest) # 자기상관 진단 패키지 설치 
dwtest(model) # 더빈 왓슨 값
# DW = 2.0604(2~4 채택역), p-value = 0.6013 >= 0.05
# H0: 검정과정의 문제가 없다 


# 4. 다중공선성 검사 
library(car)
sqrt(vif(model)) > 2 # TRUE 
# 2 이상이면 다중공선성 의심대상이다.

# 5. 모델 생성/평가 
formula = Sepal.Length ~ Sepal.Width + Petal.Length 
model <- lm(formula = formula,  data=iris)
summary(model) # 모델 평가



#######################################################
###############  6. 범주형 변수 사용 ##################

# - 범주형 변수를 더미변수(남자: 0, 여자: 1)로 생성
# - 범주형 변수 기울기 영향 없음( but 절편에 영향을 미침 ) 

# - 범주형 범주가 n개이면 더미변수 수 = n-1
#   ex) 4개의 범주인 혈액형 (A, B, O, AB) // 더미변수는 3개가 필요
#         x1     x2     x3
#   A     1       0      0
#   B     0       1      0
#   O     0       0      1
#  AB     0       0      0 (base 기준)
#  Factor : 범주형 -> 더미변수


# 의료비 예측
insurance <- read.csv("insurance.csv", header = T)
str(insurance)
# 'data.frame':	1338 obs. of  7 variables:
# $ age      나이       : int 
# $ sex      성별       : Factor w/ 2 levels "female","male"
# $ bmi      비만도지수 : num  
# $ children 자녀수     : int  
# $ smoker   흡연여부   : Factor w/ 2 levels "no","yes"
# $ region   지역       : Factor w/ 4 levels "northeast","northwest",..:
# $ charges  의료비(y)  : num  

# 범주형 변수 : sex(2), smoker(2), region(4)
# 기준(base)  : level1(base = 0), level2 = 1

# 회귀모델 생성
insurance2 <- insurance[c(-5,-6)] # 흡연유무, 지역 제외
str(insurance2)

ins_model <- lm(charges ~., data = insurance2)
ins_model
#   (Intercept)          age      sexmale          bmi     children  
#       -7460.0        241.3       1321.7        326.8        533.2  

# female(base) = 0, male = 1 // base를 지정하지 않는다면 알파벳 가장 빠른게 base로 자동 지정
# sexmale 1321.7
# [해석] 여성에 비해서 남성의 의료비가 1321.7만큼 높다
# y = a*X + b 
y_male <- 1321.7 * 1 + (-7460.0)
y_female <- 1321.7 * 0 + (-7460.0)
y_male
y_female

# 더미변수 base 바꾸기 ####
x <- c('male','female')
insurance2$sex <- factor(insurance2$sex, levels = x)
insurance2$sex
# mele(base) = 0, female = 1
ins_model <- lm(charges ~., data = insurance2)
ins_model
#   (Intercept)          age    sexfemale          bmi     children  
#       -6138.2        241.3      -1321.7        326.8        533.2  



male <- subset(insurance2, sex == 'male')
female <- subset(insurance2, sex == 'female')
mean(male$charges)
mean(female$charges)

## dummy 변수 vs 절편
insurance3 <- insurance[-6]
head(insurance3)

ins_model2 <- lm(charges ~ smoker, data = insurance3)
ins_model2
# (Intercept)    smokeryes  
#        8434        23616  
# smoker no = 0(base), smoker yes = 1
# [해석] 흡연자가 비흡연자에 비해 의료비가 23616정도 높다

no <- subset(insurance3, smoker == 'no')
yes <- subset(insurance3, smoker == 'yes')
mean(no$charges) # base가 절편: 8434.268
mean(yes$charges) - mean(no$charges) # 두 범주형 변수의 평균차이가 기울기: 23615.96

# n(3개 이상)개의 범주 -> n-1개 더미변수 생성
insurance4 <- insurance
ins_model3 <- lm(charges ~ region, data = insurance4)
ins_model3
table(insurance4$region)
# northeast(base, x0), northwest(x1), southeast(x2), southwest(x3)
# (Intercept)  regionnorthwest  regionsoutheast  regionsouthwest  
#     13406.4           -988.8           1329.0          -1059.4  












































































