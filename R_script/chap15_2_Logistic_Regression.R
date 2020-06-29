####시작#######################################
# 15_2. 로지스틱 회귀분석(Logistic Regression) 
###############################################

# 목적 : 일반 회귀분석과 동일하게 종속변수와 독립변수 간의 관계를 나타내어 
# 향후 예측 모델을 생성하는데 있다.

# 차이점 : 종속변수가 범주형 데이터를 대상으로 하며 입력 데이터가 주어졌을 때
# 해당 데이터의결과가 특정 분류로 나눠지기 때문에 분류분석 방법으로 분류된다.
# 유형 : 이항형(종속변수가 2개 범주-Yes/No), 다항형(종속변수가 3개 이상 범주-iris 꽃 종류)
# 다항형 로지스틱 회귀분석 : nnet, rpart 패키지 이용 
# a : 0.6,  b:0.3,  c:0.1 -> a 분류 

# 분야 : 의료, 통신, 기타 데이터마이닝

# 선형회귀분석 vs 로지스틱 회귀분석 
# 1. 로지스틱 회귀분석 결과는 0과 1로 나타난다.(이항형)
# 2. 정규분포 대신에 이항분포를 따른다.
# 3. 로직스틱 모형 적용 : 변수[-무한대, +무한대] -> 변수[0,1]사이에 있도록 하는 모형 
#    -> 로짓변환 : 출력범위를 [0,1]로 조정
# 4. 종속변수가 2개 이상인 경우 더미변수(dummy variable)로 변환하여 0과 1를 갖도록한다.
#    예) 혈액형 AB인 경우 -> [1,0,0,0] AB(1) -> A,B,O(0)


# 단계1. 데이터 가져오기
setwd("C:/ITWILL/2_Rwork/Part-IV")
weather = read.csv("weather.csv", stringsAsFactors = F) 
# stringAsFactors = F 순수한 문자형으로 가져오기
dim(weather)  # 366  15
head(weather)
str(weather)

# chr 칼럼, Date, RainToday 칼럼 제거 
weather_df <- weather[, c(-1, -6, -8, -14)]
str(weather_df)

# RainTomorrow 칼럼 -> 로지스틱 회귀분석 결과(0,1)에 맞게 더미변수 생성 ####   
weather_df$RainTomorrow[weather_df$RainTomorrow=='Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow=='No'] <- 0
str(weather_df)
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow)
head(weather_df)

# y 빈도수 
table(weather_df$RainTomorrow)
prop.table(table(weather_df$RainTomorrow)) 



#  단계2.  데이터 셈플링 ####
set.seed(1212)
idx <- sample(1:nrow(weather_df), nrow(weather_df)*0.7)
train <- weather_df[idx, ]
test <- weather_df[-idx, ]




#  단계3.  로지스틱  회귀모델 생성 : 학습데이터 ####
weater_model <- glm(RainTomorrow ~ ., data = train, family = 'binomial') # family = 'binomial'(이항) ===> y의 범주는 2개이다
weater_model 
summary(weater_model) 




# 단계4. 로지스틱  회귀모델 예측치 생성 : 검정데이터 ####
# newdata=test : 새로운 데이터 셋, type="response" : 0~1 확률값으로 예측 
pred <- predict(weater_model, newdata=test, type="response")  
predict
pred 
summary(pred)
str(pred)

# 이항 분류는 연속형데이터를 사용할 수 없다. 따라서 연속형데이터를 기준점을 통해 이항데이터로 만들어야함
# cut off(기준점) = 0.5
cpred <- ifelse(pred >= 0.5, 1, 0)
table(cpred)
y_true <- test$RainTomorrow
table(test$RainTomorrow)

tab <- table(y_true, cpred)
tab

# 단계5 : 모델 평가

# 1) 정분류: 분류정확도
acc <- (tab[1,1] + tab[2,2]) / nrow(test)
acc <- (78+13) / nrow(test) 
acc # 정분류율(정확도)

no <- 78 / (78+8)
no # 비가 안왔을때(0) 맞출확률

yes <- 13/(9+13)
yes # 비가 왔을때(1) 맞출확률

# 2) 오분류
no_acc <- (tab[1,2] + tab[2,1]) /nrow(test)
no_acc #오분류율

# 3) 특이도: 실제 정답이 no인경우 예측도 no로한 경우
tab[1,1] / (tab[1,1] + tab[1,2])

# 4) 재현율(=민감도) : 정답이 yes인 경우 yes로 예측한 경우
# 실제 긍정값에서 긍정으로 예측한
recall <- tab[2,2] / (tab[2,1] + tab[2,2])
recall

# 5) 정확률: 예측치를 기준으로 예측치가 yes인 경우 정답도 yes인 확률
# 긍정으로 예측했한 수 중 제대로 맞춘
precision <- tab[2,2] / (tab[1,2] + tab[2,2])
precision

# 6) F1_score: 불균형 비율을 갖고있을때 모델을 평가하는 지표
F1_score = 2*((recall * precision) / (recall + precision))
F1_score

# ROC Curve를 이용한 모형평가(분류정확도)  ####
# Receiver Operating Characteristic

# install.packages("ROCR")
library(ROCR)

# ROCR 패키지 제공 함수 : prediction() -> performance
pr <- prediction(pred, test$RainTomorrow)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf) # x축 특이도 y축 민감도


#################################################
########### 다항형 로지스틱 회귀분석 : nnet #####
# install.packages("nnet")
library(nnet) 

set.seed(1214)
idx <- sample(nrow(iris), nrow(iris)*0.7)
train <- iris[idx,]
test <- iris[-idx,]

# 활성함수
# 이항 : sigmoid function (0~1 사이 확률값을 갖고 이후 cut off로 0과1로 분류하는 방법)
# 다항 : softmax function (0~1 사이 확률값을 갖고 다 합하면 1)
# ex) y1 = 0.1, y2 = 0.1, y3 = 0.8 ---> y3로 분류
names(iris)
model <- multinom(Species ~ ., data = train) # weights는 신경망 연결의 경우의 수가 18개
names(model)
model$fitted.values
range(model$fitted.values)

str(model$fitted.values) # num [1:105, 1:3] 행은 데이터 수 열은 꽃의 종
model$fitted.values[1,]  # 3개를 더하면 1이 나옴 ------> [해석] 1번째 데이터는 setosa로 예측한다
train[1,]
table(train$Species)
colSums(model$fitted.values)

# 예측치: 확률로 예측
y_pred <- predict(model, test, type = 'probs')
y_pred

y_true <- test$Species
y_true
library(dplyr)
y_pred <- ifelse(y_pred[,1] >= 0.5, "setosa", ifelse(y_pred[,2] >= 0.5, "versicolor", "virginica")) 
str(y_pred)

P<-data.frame()

for(i in 1:nrow(y_pred)){
 P[i,] <-  y_pred[i,]
}



# 예측치: 범주로 예측
y_pred <- predict(model, test)
table(y_pred)
table(test$Species)

y_true <- test$Species
y_true

# 교차분할표(confusion matrix)
tab <- table(y_true, y_pred)
tab

acc <- (tab[1,1] + tab[2,2] + tab[3,3]) /nrow(test) 
cat('분류정확도 =', acc) #0.97777










