# chap09_3_newscrawling

# http://media.daum.net/
# <a href="url> 기사 내용 </a>

# 1. 패키지 설치
# install.packages("httr")  원격 url 요청
library(httr)
# install.packages('XML')   Tag -> html 파싱 (기사내용을을 가져오는 패키지)
library(XML)

# 2. url 요청
rq_url <- "https://media.daum.net/"
web <- GET(rq_url) #web에서 status가 200이면 정상적이라는 의미
GET

# 3. html 파싱(text -> html 변환)
html <- htmlTreeParse(web,
                      useInternalNodes = T,
                      trim = T,
                      encoding = "UTF-8")
# useInternalNodes 노드를 읽어올거냐, trim공백 제거할거냐
root_node <- xmlRoot(html)

# 4. tag 자료수집 : "//tag[@속성='값']"
news <- xpathSApply(root_node, "//a[@class='link_txt']", xmlValue) 
# a라는 태그를 갖고 class라는 속성을 갖고 

news2 <- news[1:59]

# 5. news 내용 정제 (전처리)
news_sent <- gsub('[\n\r\t]','',news2)        # 이스케이프 제거 (\n : 줄바꿈, \r : 커서를 앞으로, \t : tab 크게 띄어쓰기)
news_sent <- gsub('[[:punct:]]','',news_sent) # 문장보호 제거
news_sent <- gsub('[[:cntrl:]]','',news_senent) # 특수문자 제거
news_sent <- gsub('[a-z]', '', news_sent)     # 영소문자 제거
news_sent <- gsub('[A-Z]', '', news_sent)     # 영대문자 제거
news_sent <- gsub('\\s+', ' ', news_sent)      # 2번이상의 공백 제거

news_sent

# 6. file save
setwd("C:/ITWILL/2_Rwork/output")
# 행 번호과 텍스트 저장
write.csv(news_sent, 'news_data.csv', row.names = T, quote = T)

new_data <- read.csv("news_data.csv", header = T)
head(new_data)

colnames(new_data) <- c("no","news_text")

news_text <- new_data$news_text
str(news_text)

# 7. 토픽분석 -> 단어구름 시각화(1day)
library(KoNLP)
library(tm) # 형태소 분석
library(wordcloud)

# 신규단어
user_dic <- data.frame(term = c("펜데믹","코로나19","타다",'현재'),
                       tag='ncn')
buildDictionary(ext_dic = 'sejong', user_dic = user_dic)


exNouns <- function(x) { 
  paste(extractNoun(as.character(x)), collapse=" ")
}


news_nouns <- sapply(news_text, exNouns) 

myCorpus <- Corpus(VectorSource(news_nouns)) 

news_term <- TermDocumentMatrix(myCorpus,
                                control=list(wordLengths=c(2,20))) 

news_term

myTerm_df <- as.data.frame(as.matrix(news_term)) 
myTerm_df

newsResult <- sort(rowSums(myTerm_df), decreasing=TRUE) 

newsName <- names(newsResult)  

news.df <- data.frame(word=newsName, freq=newsResult) 

windowsFonts(malgun=windowsFont("맑은 고딕"))
pal <- brewer.pal(12,"Paired")


wordcloud(news.df$word, news.df$freq,  # x축, y축
          scale=c(5,1), # 사이즈
          min.freq=2,   # 최소 출현빈도수 
          random.order=F, 
          rot.per=.1,   # 틀어지는 각도
          colors=pal,   # 
          family="malgun")






