# 출력할 내용의 자리수 정의
print(pi, digits = 3) # 3.14
print(pi, digits = 8) # 3.14159727
nchar(3.14159727) # 10  // 정수 위치와 소숫점을 제외한 글자수는 8(digits의 의미)


# 현재 작업공간에서 호출 가능한 파일 확인
getwd() # 작업공간 확인
list.files() # 호출 가능한 파일 리스트
list.files(all.files = T) # 작업 공간에 있는 파일 전체 확인

# 자료 형태 확인(mode)
mode(3.14) # numeric
mode(c(1,2,3,4,5.5)) # numeric
mode('Tom') # character
mode(c('Tom', 'amine', 'arf')) # character
mode(factor(c('a', 'b', 'c'))) # numeric
mode(list('kim', 'park', 'yoon')) # list
mode(data.frame(x = 1:3, y = c('tom', 'roy', 'alex'))) # list
mode(print) # function

df = data.frame(x = 1:3, y = c('tom', 'roy', 'alex'))
#   x    y
# 1 1  tom
# 2 2  roy
# 3 3 alex


df[1] # 첫번째 열 선택
#   x
# 1 1
# 2 2
# 3 3


df['x'] # 이름이 x인 열 선택
df$x    # 이름이 x인 열 선택

str(df)
# data.frame:	3 obs. of  2 variables:
# $ x: int  1 2 3
# $ y: Factor w/ 3 levels "alex","roy","tom": 3 2 1

 
str(df[2]) # df 형식을 그대로 갖고있음
           #'data.frame':	3 obs. of  1 variable:
           #$ y: Factor w/ 3 levels "alex","roy","tom": 3 2 1

str(df[[2]]) # Factor w/ 3 levels "alex","roy","tom": 3 2 1


###########################
# 벡터, 리스트, 행렬 다루기
###########################
a <- seq(1, 6)  # [1] 1 2 3 4 5 6
b <- seq(7, 9)  # [1] 7 8 9

a + b
# [1]  8 10 12 11 13 15

cbind(a, b)
#      a b
# [1,] 1 7
# [2,] 2 8
# [3,] 3 9
# [4,] 4 7
# [5,] 5 8
# [6,] 6 9

# 벡터에 데이터 추가
v <- 1:5
newitems <- c('pants', 'coat')
v <- c(v, newitems)
v[length(v) + 1] <- newitems[1] # v의 저장공간을 1칸 늘리고 그곳에 새로운 값을 추가

# 벡터에 데이터 삽입
newvalues = 'shoes'
append(newitems, newvalues, after = 1) # 











