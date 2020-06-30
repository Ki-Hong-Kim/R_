# chap16_1_DecisionTree

# install.packages("rpart.plot")
# install.packages('rattle')

library(rpart) # rpart() : 분류모델 생성 
library(rpart.plot) # prp(), rpart.plot() : rpart 시각화
library('rattle') # fancyRpartPlot() : node 번호 시각화 


# 단계1. 실습데이터 생성 
data(iris)
set.seed(415)
idx = sample(1:nrow(iris), 0.7*nrow(iris))
train = iris[idx, ]
test = iris[-idx, ]
dim(train) # 105 5
dim(test) # 45  5

table(train$Species)

# 단계2. 분류모델 생성 
# rpart(y변수 ~ x변수, data)
model = rpart(Species~., data=train) # iris의 꽃의 종류(Species) 분류 
model
# 1) root 105 68 setosa (0.35 0.31 0.33)  
#     (root node : 전체크기, 가장 많은 비율 labeld을 구분지음)
#  
#   2) Petal.Length< 2.45 37  0 setosa (1.00000000 0.00000000 0.00000000) *
#         (left node:)




# 분류모델 시각화 - rpart.plot 패키지 제공 
prp(model) # 간단한 시각화   
rpart.plot(model) # rpart 모델 tree 출력
fancyRpartPlot(model) # node 번호 출력(rattle 패키지 제공)

# 가지치기 (cp: cut prune) ####
# 트리의 가지치기 : 과적합 문제 해결법
# cp : 0 ~ 1 값 (default = 0.05)
# 0으로 갈수록 트리 커짐, 오류율 감소, 과적합 증가
model$cptable
#    CP nsplit        rel error      xerror       xstd
# 1 0.5147059      0 1.00000000   1.11764706 0.06737554
# 2 0.4558824      1 0.48529412   0.57352941 0.07281162
# 3 0.0100000      2 0.02941176   0.02941176 0.02059824
# 과적합 발생 -> 0.45 조정


# 단계3. 분류모델 평가  
pred <- predict(model, test) # 비율 예측 
pred <- predict(model, test, type="class") # 분류 예측 

# 1) 분류모델로 분류된 y변수 보기 
table(pred)

# 2) 분류모델 성능 평가 
table(pred, test$Species) # (13+16+12)/nrow(test) : 0.9111111



##################################################
# Decision Tree 응용실습 : 암 진단 분류 분석 ####
##################################################
# "wdbc_data.csv" : 유방암 진단결과 데이터 셋 분류
setwd("C:/ITWILL/2_Rwork/Part-IV")
# 1. 데이터셋 가져오기 
wdbc <- read.csv('wdbc_data.csv', stringsAsFactors = FALSE)
str(wdbc)

# 2. 데이터 탐색 및 전처리 
wdbc <- wdbc[-1] # id 칼럼 제외(이상치) 
head(wdbc)
head(wdbc[, c('diagnosis')], 10) # 진단결과 : B -> '양성', M -> '악성'

# 목표변수(y변수)를 factor형으로 변환 
wdbc$diagnosis <- factor(wdbc$diagnosis, levels = c("B", "M")) # B를 base = 0으로 설정
wdbc$diagnosis[1:10] # B는 0으로 

# 3. 정규화  : 서로 다른 특징을 갖는 칼럼값 균등하게 적용 
normalize <- function(x){ # 정규화를 위한 함수 정의 
  return ((x - min(x)) / (max(x) - min(x)))
}

# wdbc[2:31] : x변수에 해당한 칼럼 대상 정규화 수행 
wdbc_x <- as.data.frame(lapply(wdbc[2:31], normalize))
wdbc_x
summary(wdbc_x) # 0 ~ 1 사이 정규화 
class(wdbc_x) # [1] "data.frame"
nrow(wdbc_x) # [1] 569

wdbc_df <- data.frame(wdbc$diagnosis, wdbc_x)
dim(wdbc_df) # 569  31
head(wdbc_df)

# 4. 훈련데이터와 검정데이터 생성 : 7 : 3 비율 
idx = sample(nrow(wdbc_df), 0.7*nrow(wdbc_df))
wdbc_train = wdbc_df[idx, ] # 훈련 데이터 
wdbc_test = wdbc_df[-idx, ] # 검정 데이터 
str(wdbc_train)

# 5. rpart 분류모델 생성 
model <- rpart(wdbc.diagnosis ~ ., data = wdbc_train)
model

rpart.plot(model)

# 6. 분류모델 평가  
y_pred <- predict(model, wdbc_test, type = 'class')
# y_pred <- predict(model, wdbc_test) class로 안했을때
# y_pred <- ifelse(y_pred[,1] >= 0.5, "0","1")

y_true <- wdbc_test$wdbc.diagnosis

tab <- table(y_true, y_pred)

# 정확도
acc <- (tab[1,1] + tab[2,2]) / nrow(wdbc_test)


M <- tab[2,2] / (tab[2,2] + tab[2,1])

# 특이도
B <- tab[1,1] / (tab[1,1] + tab[1,2])













