# chap16_2_RandomForest

##################################################
####  randomForest                           #####
##################################################
# 결정트리(Decision tree)에서 파생된 모델 
# 랜덤포레스트는 앙상블 학습기법을 사용한 모델
# 앙상블 학습 : 새로운 데이터에 대해서 여러 개의 Tree로 학습한 다음, 
# 학습 결과들을 종합해서 예측하는 모델(PPT 참고)
# DT보다 성능 향상, 과적합 문제를 해결


# 랜덤포레스트 구성방법(2가지)
# 1. 결정 트리를 만들 때 데이터의 일부만을 복원 추출하여 트리 생성 
#  -> 데이터 일부만을 사용해 포레스트 구성 
# 2. 트리의 자식 노드를 나눌때 일부 변수만 적용하여 노드 분류
#  -> 변수 일부만을 사용해 포레스트 구성 
# [해설] 위 2가지 방법을 혼용하여 랜덤하게 Tree(학습데이터)를 구성한다.

# 새로운 데이터 예측 방법
# - 여러 개의 결정트리가 내놓은 예측 결과를 투표방식(voting) 방식으로 선택 


# install.packages('randomForest')
library(randomForest) # randomForest()함수 제공 

data(iris)

# 1. 랜덤 포레스트 모델 생성 
# 형식) randomForest(y ~ x, data, ntree, mtry)
model = randomForest(Species~., data=iris)  
# Number of trees: 500 (기본값)
# No. of variables tried at each split: 2 (최소 변수 사용 개수)

# node 분할에 사용하는 x변수 개수 
sqrt(length(iris)-1) # mtry 범주형
p <- 14
mtrt <- 1/3 * p # mtry 연속형


# 2. 파라미터 조정 300개의 Tree와 4개의 변수 적용 모델 생성 
model = randomForest(Species~., data=iris, 
                     ntree=300, mtry=4, na.action=na.omit )
model


# 3. 최적의 파리미터(ntree, mtry) 찾기
# - 최적의 분류모델 생성을 위한 파라미터 찾기

ntree <- c(400, 500, 600)
mtry <- c(2:4)

# 2개 vector이용 data frame 생성 
param <- data.frame(n=ntree, m=mtry)
param

for(i in param$n){ # 400,500,600
  cat('ntree = ', i, '\n')
  for(j in param$m){ # 2,3,4
    cat('mtry = ', j, '\n')
    model = randomForest(Species~., data=iris, 
                         ntree=i, mtry=j, 
                         na.action=na.omit )    
    print(model)
  }
}


# 4. 중요 변수 생성  
model3 = randomForest(Species ~ ., data=iris, 
                      ntree=500, mtry=2, 
                      importance = T, # y를 분류하는데 사용된 x변수중 가장 중요한 x변수가 무엇인가?
                      na.action=na.omit )
model3 
importance(model3)
# importance(model3)
# MeanDecreaseAccuracy: 분류정확도 개선에 기여하는 변수 (클수록 정확도 기여도가 높다)
# MeanDecreaseGini : 노드 불순도(불확실성)을 개선하는 기여도 계수

varImpPlot(model3)


#########################################################
##          회귀 tree                            ########

library(MASS)

data("Boston")
str(Boston)
# crim : 도시 1인당 범죄율 
# zn : 25,000 평방피트를 초과하는 거주지역 비율
# indus : 비상업지역이 점유하고 있는 토지 비율  
# chas : 찰스강에 대한 더미변수(1:강의 경계 위치, 0:아닌 경우)
# nox : 10ppm 당 농축 일산화질소 
# rm : 주택 1가구당 평균 방의 개수 
# age : 1940년 이전에 건축된 소유주택 비율 
# dis : 5개 보스턴 직업센터까지의 접근성 지수  
# rad : 고속도로 접근성 지수 
# tax : 10,000 달러 당 재산세율 
# ptratio : 도시별 학생/교사 비율 
# black : 자치 도시별 흑인 비율 
# lstat : 하위계층 비율 
# medv(y) : 소유 주택가격 중앙값 (단위 : $1,000)      

ntree <- 500
p <- 13
mtry <- (1/3) * p # 4~5 개의 변수로 y를 분류

B_model <- randomForest(medv ~ ., data = Boston,
                        ntree = 500, mtry = mtry,
                        importance = T)

B_model # No. of variables tried at each split: 4

varImpPlot(B_model)
B_model$importance

y_pred <- B_model$predicted
y_true <- B_model$y

# 표준화(o)
err <- y_true - y_pred
mse <- mean(err**2)

# 표준화(x)
cor(y_true, y_pred)

# model (분류 = 범주형 변수 / 회귀 = 연속형 변수 )
# 분류 tree : confusion matrix
# 회귀 tree : MSE, cor

########################################################
## 분류트리                           ##################


titanic <- read.csv("titanic3.csv", header = T)
str(titanic$survived)
titanic_1 <-titanic[,-c(3,8,10,12,13,14)]

str(titanic_1$survived)
titanic_1$survived <- as.factor(titanic_1$survived)

ntree <- 500
mtry <- round(sqrt(7))

model <- randomForest(survived ~., data = titanic_1,
                      ntree=500,
                      mtry = mtry,
                      importance = T,
                      na.action = na.omit)

model$importance
varImpPlot(model)




#####################################################
##### entropy : 불확실성을 나타내는 하나의 척도 (엔트로피가 낮을 수록 y를 잘 분류한다) ####
# tree model 에서 중요변수 선정 기준
# x1: 앞면이 나올 확률, x2: 뒷면이 나올 확률
# 불확실성이 가장 높은 경우 : entropy가 1이 나올 떄
# 1.
x1 <- 0.5
x2 <- 0.5

e1 <- -x1 * log2(x1)  -x2 * log2(x2)
e <- exp(1)
e1 # 1

# 2.
x1 <- 0.8
x2 <- 0.2
e1 <- -x1*log2(x1)-x2*log2(x2)
e1 # 0.7219 전 경우보다 불확실성이 적다































