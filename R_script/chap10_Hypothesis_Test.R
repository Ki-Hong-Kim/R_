# chap10_Hypothesis_Test
#### 통계에 대한 설명 (머릿말) ####

# 가설(Hypothesis) : 어떤 사건을 설명하기 위한 가정 
# 검정(test) : 표본에 의해서 구해진 통계량으로 가설 채택/기각 과정 
# 추정(estimation) : 표본을 통해서 모집단을 확률적으로 추측   


# 모수 : 모집단에 의해서 나온 통계량(모평균, 모표준편차)  
# 검정통계량 : 표본에 의해서 계산된 통계량(표본평균, 표본표준편차)

# 오차 : 검정통계량과 모수 간의 차이 
# 오차범위 : 오차범위가 벗어나면 모수와 차이가 있다고 본다.
# 유의수준 : 오차 범위의 기준(통상 : 알파=0.05)


# 추정 방법 
# 1) 점 추정 : 제시된 한 개의 값과 검정통계량을 직접 비교하여
#    가설 기각유무를 결정 
# ex) 우리나라 중학교 2학년 남학생 평균키는 165.2cm로 추정

# 2) 구간 추정 : 신뢰구간과 검정통계량을 비교하여 가설 기각유무 결정 
# 신뢰구간 : 오차범위에 의해서 결정된 하한값과 상한값의 범위 
# ex) 우리나라 중학교 2학년 남학생 평균키는 164.5 ~ 165.5cm로 추정


#####################
#### 가설과 검정 ####
#####################

# 귀무가설(H0) : 중2 남학생 평균키는 165.1 ~ 165.3cm 추정 (구간추정)

# 모집단 -> 표본(1,000명) 추출
set.seed(1)
x <- rnorm(1000, 165.2, 0.5) #평균 165.2이고 표준편차가 0.5인 1000개 데이터 생성

hist(x)



# 샤피로 테스트는 정규성을 확인하기 위한 작업
# 샤피로 테스트의 귀무가설 - 정규성과 차이가 없다
# 샤피로 테스트의 대립가설 - 정규성과 차이가 있다.

# 임계치(a = 5%) 보다 p-value가 크다면 귀무가설 채택

# 정규성검정 : (H0 = 정규분포와 차이가 없다., 채택(p-value >= a))  ---> x가 정규성을 띈다
shapiro.test(x) 
# W : 검정통계량, p-value : 유의확률 (W를 통해 p-value를 도출함)
# 검정 : p-value >= 알파(a = 0.05) (귀무가설(H0) 채택)
# [해석] 데이터 x는 정규분포를 띄는 데이터 이다



##### 1. 평균차이 검정 ####
t.test(x, mu=165.2)
# t = -0.35592, df = 999, p-value = 0.722
# alternative hypothesis: true mean is not equal to 165.2
# 95 percent confidence interval:
#   165.1621 165.2263
# sample estimates:
#   mean of x 
# 165.1942 

# [해석] p-value: 0.722 > a:0.05 ====> 귀무가설 채택 ==> 모평균이 165.2이다
#                                 (H0: 165.2cm와 모평균이 차이가 없다)

#### 2. 기각역의 평균 검정 ####
t.test(x, mu = 165.1, conf.level = 0.95)
# t = 5.7553, df = 999, p-value = 1.15e-08
# alternative hypothesis(대립가설): true mean(모평균) is not equal to 165.1
# 95 percent confidence interval: 95퍼센트에 해당되는 신뢰구간
#   165.1621 165.2263
# sample estimates:
#   mean of x 
# 165.1942 

# [해석] 귀무가설(H0): 모평균이 165.1cm와 차이가 없다
#        대립가설(H1): 모평균이 165.1cm와 차이가 있다.
#
# p-value: 0.00000001 < a: 0.05
# 귀무가설 기각!
# 대립가설 채택!

#### 3. 신뢰수준 : 0.99 ####
t.test(x,mu=165.21, conf.level = 0.99)



















# 귀무가설(H0) :평균키가 165.2와 차이가 없다
# t = 0.2176, df = 999, p-value = 0.8278                  : 검정통계량(t, df(자유도)), p-value >= a(0.05)
# alternative hypothesis: true mean is not equal to 165.2   
# 95 percent confidence interval:                         : 95%의 신뢰수준
#   165.1723 165.2346                                     : 165.1723 ~ 165.2346 신뢰구간(귀무가설 채택역)
# sample estimates:
#   mean of x 
# 165.2035                                                : 표본의 실제 평균값



#####
# 귀무가설(H0) : 평균키가 165.1cm와 차이가 없다
# t = 6.5208, df = 999, p-value = 1.109e-10               : p-value가 a보다 작아짐 ... 귀무가설 기각 평균키 차이 있다
# alternative hypothesis: true mean is not equal to 165.1
# 95 percent confidence interval:
#   165.1723 165.2346



# t = -0.41272, df = 999, p-value = 0.6799
# alternative hypothesis: true mean is not equal to 165.21
# 99 percent confidence interval:                         # 95% -> 99% 신뢰수준 : 신뢰구간이 넓어짐
#   165.1625 165.2444
# [해설] 신뢰수준 향상 -> 채택역 확장




