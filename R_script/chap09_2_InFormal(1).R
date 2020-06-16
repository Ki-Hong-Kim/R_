# chap09_2_InFormal(1)

# 분석 절차
# 1단계 : 토픽분석(단어의 빈도수)
# 2단계 : 연관어 분석(관련 단어 분석) 
# 3단계 : 감성 분석(단어의 긍정/부정 분석) 


##################################################
# 1. 토픽분석(텍스트 마이닝) 
# - 시각화 : 단어 빈도수에 따른 워드 클라우드
###################################################

## 1. 패키지 설치와 준비 

# 1) KoNLP 설치 
 #install.packages("KoNLP") 
#Warning in install.packages :
#  package ‘KoNLP’ is not available (for R version 3.6.2)

# [해결방법]
# 현재 R 버전에서 제공하지 않는 패키지(KoNLP) 설치하는 방법

# [단계1] 이전버전에서 설치가능한 패키지 확인
# https://cran.rstudio.com/bin/windows/contrib/3.5/ 경로에서 
# 단축키를 Ctrl+F 누르고 KoNLP 를 입력하면 찾을 수 없다.
# 
# https://cran.rstudio.com/bin/windows/contrib/3.4/ 경로에서 
# 단축키를 Ctrl+F 누르고 KoNLP 를 입력하면 'KoNLP_0.80.1.zip' 찾을 수 있다.


# [단계2] 이전 R version 설치하기 
# install.packages("https://cran.rstudio.com/bin/windows/contrib/3.4/KoNLP_0.80.1.zip",
               #  repos = NULL) # 설치하고자 하는 패키지의 저장위치를 패키지와 다른 버젼인 위치에 저장

# 2) Sejong 설치 : KoNLP와 의존성 있는 현재 버전의 Sejong 설치 
# install.packages("Sejong") # 세종 사전

# 3) wordcloud 설치    
# install.packages("wordcloud") 

# 4) tm 설치 
# install.packages("tm") # 전처리, DTM(document term matrix). TDM
library(rJava)
# 5) 패키지 로딩
library(KoNLP) 
#Checking user defined dictionary!
# 의존성 패키지 설치 
# install.packages("hash")
# install.packages("tau")
# install.packages("RSQLite")
# install.packages("devtools")

library(tm) # 전처리 용도 
# 필요한 패키지를 로딩중입니다: NLP

library(wordcloud) 

setwd("C:\\ITWILL\\2_Rwork\\Part-II")
## 2. facebook_bigdata.txt 가져오기
facebook <- file(file.choose(), encoding="UTF-8") # 파일을 객체형태로 통째로 가져옴
facebook_data <- readLines(facebook) # 줄 단위 TEXT FILE 읽기 1줄 -> 1개의 벡터

head(facebook_data) # 앞부분 6줄 보기 - 줄 단위 문장 확인 
str(facebook_data) # chr [1:76] 각 chr형태로 모두 벡터형태

## 3. 세종 사전에 신규 단어 추가
user_dic <- data.frame(term=c("R 프로그래밍","페이스북","김진성","소셜네트워크"), 
                       tag='ncn') # tag = 'ncn'은 명사라는 tag를 다는 역할

# Sejong 사전에 신규 단어 추가 : KoNLP 제공 
buildDictionary(ext_dic='sejong', user_dic = user_dic)

# extractNoun은 세종사전에서 단어 추출하는 
paste(extractNoun("나는 김진성이고, 대한민국 사람이다."), collapse= " ")

## 4. 단어추출 사용자 함수 정의
# (1) 사용자 정의 함수 실행 순서 
#     : 문장 -> 문자형으로 형변환 -> 명사 추출 -> 추출된 단어를 공백으로 합침 
exNouns <- function(x) { 
  paste(extractNoun(as.character(x)), collapse=" ")
}

# (2) exNouns 함수 이용 단어 추출 
# 형식) sapply(vector, 함수) : 벡터에 함수를 적용 -> 문장에서 단어 추출 
str(facebook_data)
head(facebook_data)

facebook_nouns <- sapply(facebook_data, exNouns) 
facebook_data[1]
facebook_nouns[1]

# facebook_nouns응 각 원문서를 벡터의 이름으로 하고 단어 추출된것들을 공백을 기준으로 한 객체로 저장 

# (3) 단어 추출 결과
str(facebook_nouns) 
facebook_nouns[1] 
facebook_nouns[2]

## 5. 데이터 전처리   
# (1) 말뭉치(코퍼스:Corpus) 생성 : 텍스트를 처리할 수 있는 자료의 집합 
myCorpus <- Corpus(VectorSource(facebook_nouns))  # 벡터 소스 생성 -> 코퍼스 생성 
myCorpus
str(myCorpus)

inspect(myCorpus[1]) # corpus 내용 보기 
inspect(myCorpus[2])

# (2) 데이터 전처리 : 말뭉치 대상 전처리 
myCorpusPrepro <- tm_map(myCorpus, removePunctuation) # 문장부호 제거
myCorpusPrepro <- tm_map(myCorpusPrepro, removeNumbers) # 수치 제거
myCorpusPrepro <- tm_map(myCorpusPrepro, tolower) # 소문자 변경
myCorpusPrepro <-tm_map(myCorpusPrepro, removeWords, c(stopwords('english'), '사용')) # 불용어제거

# (3) 전처리 결과 확인 
myCorpusPrepro # Content:  documents: 76
inspect(myCorpusPrepro[1:5]) # 데이터 전처리 결과 확인(숫자, 영문 확인)

## 6. 단어 선별(단어 길이 2개 이상)
# (1) 단어길이 2개 이상(한글 1개 2byte) 단어 선별 -> matrix 변경
myCorpusPrepro_term <- TermDocumentMatrix(myCorpusPrepro, 
                                          control=list(wordLengths=c(4,16))) # 한글단어가 2자 ~ 8자를 추출한다는 의미 byte로 구분하기 때문에 

TermDocumentMatrix
myCorpusPrepro_term
# Sparsity : 희소비율 (1의 비율(2%) 나머지는 0(98%))
# Maxiaml term length : 6음절 또는 12개 알파벳
# Weighting : 가중치를 무엇으로 계산했는가 = 단어의 출연빈도(tf)


# (2) Corpus -> 평서문 변환 : matrix -> data.frame 변경
myTerm_df <- as.data.frame(as.matrix(myCorpusPrepro_term)) 
str(myTerm_df)
myTerm_df[c(1:10),1]

## 7. 단어 빈도수 구하기
# (1) 단어 빈도수 내림차순 정렬
wordResult <- sort(rowSums(myTerm_df), decreasing=TRUE) 
wordResult
wordResult[1:10]
str(wordResult)

# (2) 불용어 제거 : 의미없는 단어 제거 


## 8. 단어구름에 디자인 적용(빈도수, 색상, 랜덤, 회전 등)
# (1) 단어 이름 생성 -> 빈도수의 이름
myName <- names(wordResult)  
myName[1:10] #가장 많이 출연된 단어순위위

# (2) 단어이름과 빈도수로 data.frame 생성
word.df <- data.frame(freq=wordResult, word=myName) 
head(word.df)
str(word.df) # word, freq 변수

# (3) 단어 색상과 글꼴 지정
pal <- brewer.pal(12,"Paired") # 12가지 색상 pal <- brewer.pal(9,"Set1") # Set1~ Set3
# 폰트 설정세팅 : "맑은 고딕", "서울남산체 B"
windowsFonts(malgun=windowsFont("맑은 고딕"))  #windows

# (4) 단어 구름 시각화 - 별도의 창에 색상, 빈도수, 글꼴, 회전 등의 속성을 적용하여 
wordcloud(word.df$word, word.df$freq,  # x축, y축
          scale=c(5,1), # 사이즈
          min.freq=2,   # 최소 출현빈도수 
          random.order=F, 
          rot.per=.1,   # 틀어지는 각도
          colors=pal,   # 
          family="malgun") # 폰트

