# chap16_3_XGboost

# xgboost vs randomForest
# - xgboost : boosting 방식 
# - randomForest : bagging 방식 

# 1. package install
# install.packages("xgboost")
library(xgboost)
# library(help="xgboost")

# 2. dataset load/search
data(agaricus.train)
data(agaricus.test)

train <- agaricus.train
test <- agaricus.test

str(train)
train$data@Dim
# $data  : x변수 [6513, 126] (2차원 메트릭스)
# $label : y변수 num[1:6513] (1차원 독 유무에 대한 데이터)
train$data
train$label


str(test)


# 3. xgboost matrix 생성 : 객체 정보 확인  
dtrain <- xgb.DMatrix(data = train$data, label = train$label) # x:data, y:label
dtrain 

?xgboost
#We will train decision tree model using the following parameters:
# •objective = "binary:logistic": we will train a binary classification model ;
# "binary:logistic" : y변수 이항 
# •max_depth = 2: the trees won't be deep, because our case is very simple ;
# tree 구조가 간단한 경우 : 2
# •nthread = 2: the number of cpu threads we are going to use;
# cpu 사용 수 : 2
# •nrounds = 2: there will be two passes on the data, the second one will enhance the model by further reducing the difference between ground truth and prediction.
# 실제값과 예측값의 차이를 줄이기 위한 반복학습 횟수 
# •eta = 1 : eta control the learning rate 

# 학습률을 제어하는 변수(Default: 0.3) (1에 가까울수록 속도 빠름)
# 숫자가 낮을 수록 모델의 복잡도가 높아지고, 컴퓨팅 파워가 더많이 소요
# 부스팅 과정을보다 일반화하여 오버 피팅을 방지하는 데 사용
# •verbose = 0 : no message
# 0이면 no message, 1이면 성능에 대한 정보 인쇄, 2이면 몇 가지 추가 정보 인쇄

# 4. model 생성 : xgboost matrix 객체 이용  
xgb_model <- xgboost(data = dtrain, max_depth = 2, eta = 1,
                     nthread = 2, nrounds = 2, objective = "binary:logistic", verbose = 0)

# 5.  학습된 model의 변수(feature) 중요도/영향력 보기 
import <- xgb.importance(colnames(train$data), model = xgb_model)
import # gain지수를 보고 출력된 변수 4개가 중요하다

xgb.plot.importance(importance_matrix = import)


# 6. 예측치
pred <- predict(xgb_model, test$data)
range(pred)

y_pred <- ifelse(pred >= 0.5, 1, 0)
y_true <- test$label
tab <- table(test$label, y_pred)

# 7. 모델 평가
# 1) 분류정확도
acc <- (tab[1,1] + tab[2,2]) / length(test$label)
cat('분류정확도 = ', acc) # 1에 수렴할 수록 좋은 수치

# 2) 평균 오차
# 참고 T/F -> 숫자형변환(1,0)
mean_err <- mean(as.numeric(pred >= 0.5) != y_true)
cat('평균 오차 = ', mean_err) # 0에 수렴할수록 좋은 수치


# 8. model save & load
# 1) model file save
setwd("C:/ITWILL/2_Rwork/output")
xgb.save(xgb_model, 'xgboost.model') # xgb.save(저장할 오브젝트, 파일이름)

# 
rm(list = ls())

# 2) model load(memory loading)
xgb_model <- xgb.load('xgboost.model')
pred2 <- predict(xgb_model, test$data)

###############################
# iris dataset: y 이항분류 ####
data(iris)
iris_df <- iris

# 1. y변수 -> binary 형으로 
iris_df$Species <- ifelse(iris_df$Species == "setosa", 0, 1)
str(iris_df)
table(iris_df$Species)

# 2. dataset  생성
idx <- sample(nrow(iris_df), 0.7*nrow(iris_df))
train <- iris_df[idx,]
test <- iris_df[-idx,]

# x: matrix , y: vector
train_x <- as.matrix(train[-5])
train_y <- train$Species

dim(train_x)
dim(train_y)

# 3. Dmatrix 생성
dtrain <- xgb.DMatrix(data = train_x, label = train_y)
dtrain

xgb_iris <- xgboost(data = dtrain, max_depth = 2, eta = 1,
                     nthread = 2, nrounds = 2, objective = "binary:logistic", verbose = 0)

import <- xgb.importance(colnames(train_x), model = xgb_iris)

xgb.plot.importance(importance_matrix = import)

test_x <- as.matrix(test[-5])
test_y <- test$Species

pred <- predict(xgb_iris, test_x)
y_pred <- ifelse(pred >= 0.5 , 1, 0)

table(test_y, y_pred)
tab <- table(test_y, y_pred)
acc <- (tab[1,1] + tab[2,2]) / length(test_y)

################################
# iris dataset : y 다항분류 ####


# objective  속성
# objective = 'reg:squarederror' : 연속형(default)
# objective = 'binary:logistic' (=sigmoid 함수를 사용했다) : y 이항분류
# objective = 'multi:softmax' : y 다항분류

# -> 첫번째 class = 0(num)

iris$Species <- ifelse(iris$Species == 'setosa', 0, ifelse(iris$Species == 'versicolor', 1, 2))

str(iris)
table(iris$Species)

# 2. data set 생성
idx <- sample(nrow(iris), nrow(iris)*0.8)
train <- iris[idx,]
test <- iris[-idx,]

# 3. xgb.Dmatrix 생성
train_x <- as.matrix(train[-5])
train_y <- train$Species

dmtrix <- xgb.DMatrix(data = train_x, label = train_y)

# 4. xgboost model 생성
xgb_iris_model <- xgboost(data = dmtrix,
                          max_depth = 2,
                          eta = 0.5,
                          nthread = 2,
                          nrounds = 2,
                          objective = 'multi:softmax',
                          num_class = 3, # y변수의 종류( multi class를 분석할때만 사용 )
                          verbose = 0)

xgb_iris_model

# 5. prediction 
test_x <- as.matrix(test[-5])
test_y <- test$Species

pred_y <- predict(xgb_iris_model, test_x) 
#반환을 바로 class로 반환하므로 cut off 작업 필요 없음

tab <- table(test_y,pred_y)

acc <- (tab[1,1] + tab[2,2] + tab[3,3]) / sum(tab)

mean_err <- mean(pred != test_y)
mean_crr <- mean(pred == test_y)

import <- xgb.importance(colnames(test_x), model = xgb_iris_model)

xgb.plot.importance(import)

##############################
# iris dataset : y 연속형 ####
# objective = 'reg:squarederror' : 연속형(default)

# 1. train/test
idx <- sample(nrow(iris), nrow(iris)*0.7)
train <- iris[idx,]
test <- iris[-idx,]

# 2. xgboost model 생성
# y: 1번 컬럼
# x: 2~4번 컬럼
train_x <- as.matrix(train[c(-1,-5)])
train_y <- train$Sepal.Length

Dmatrix <- xgb.DMatrix(data = train_x, label = train_y)

iris_model <- xgboost(data = Dmatrix,
                          max_depth = 2,
                          eta = 1,
                          nthread = 2,
                          nrounds = 3,
                          objective = 'reg:squarederror',
                          verbose = 0)

iris_model

test_x <- as.matrix( test[c(-1,-5)])
test_y <- test$Sepal.Length

pred <- predict(iris_model, test_x)

# 모델평가
mse <- mean((test_y - pred) **2)
mse

imports <- xgb.importance(colnames(test_x), iris_model)
xgb.plot.importance(imports)


