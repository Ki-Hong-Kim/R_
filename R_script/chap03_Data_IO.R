# chap03_Data_IO


# 1. 데이터 불러오기 (키보드 입력, 파일 가져오기)

# 1) 키보드 입력 
# 숫자 입력
x <- scan() # space bar 로 구분을하고 입력을 마무리 하려면 엔터를 한번 더 치면된다 벡터형으로 저장된다
# scan은 파일을 읽어 올 수도 있다
x[3]
sum(x)
mean(x)

# 문자 입력
string <- scan(what = character())
string

# 2) 파일 읽기
setwd("C:/ITWILL/2_Rwork/Part-I") # 작업할 위치 선택
getwd() # 현재 작업중인 위치 확인

# 1. read.table() : 컬럼 구분(공백, 특수문자)
# (1) text file 가져오기
student <- read.table("student.txt") # 데이터에 제목이 따로 없으므로 header = F 기본값 적용
student # V1 V2 ... 기본제목
student1 <- read.table("student.txt", header = T) # 데이터 값을 열 이름으로 인식.. 조심!!
student1

# 제목이 있는 경우 , 구분자 : 특수문자
student2 <- read.table("student2.txt", header =T, sep = ";")
student2
student2.1 <- read.table("student2.txt", header =T)
student2.1 # 원본 파일을 확인해서 구분자를 먼저 파악해야함!!

# 결측치 처리하기, 제목이 있는경우
student3 <- read.table("student3.txt", header = T)
student3
student3_1 <- read.table("student3.txt", header = T, na.strings = '-')
student3_1
mean(student3_1$'키', na.rm=T) # student3 에서 na.string = '-' 안하면 계산 아됨

student3.0 <- read.table("student3.txt", header = T)
str(student3.0) # 결측치인 '-' 때문에 키와 몸무게가 factor로 변함 => 확실히 결측치를 인식시켜야함
student3.1 <- read.table("student3.txt", header = T, na.strings = c('-', '&'))
str(student3.1)

# (2) read.csv() : 제목이 있고 구분자는 콤마(,)
student4 <- read.csv('student4.txt', na.strings = c('-','&'))
student4

# 탐색기 이용: 파일 선택
excel <- read.csv(file.choose()) # excel.csv

# (3) xls/xlsx : 패키지 필요
# install.packages("xlsx")
library(rJava) # xlsx를 사용하기위해 필요한 rJava
library(xlsx)


kospi <- read.xlsx("sam_kospi.xlsx", sheetIndex = 1)

# 한글이 포함된 xlsx 파일 읽기 (인코딩)
st_excel <- read.xlsx("studentexcel.xlsx", sheetIndex = 1, encoding = 'UTF-8')

# 3. 인터넷 파일 읽기 
# 데이터 셋 제공 사이트 
# http://www.public.iastate.edu/~hofmann/data_in_r_sortable.html - Datasets in R packages
# https://vincentarelbundock.github.io/Rdatasets/datasets.html
# https://r-dir.com/reference/datasets.html - Dataset site
# http://www.rdatamining.com/resources/data

titanic <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")
str(titanic)
dim(titanic)
head(titanic)

# 생존여부
table(titanic$survived)
# 성별 구분
table(titanic$sex)
# class 구분
table(titanic$class)

# 성별 vs 생존여부 : 교차 분할 표
tit_tab <- table(titanic$survived, titanic$sex)
# 막대차트 
barplot(tit_tab, col = rainbow(2))

# 출력 행 제한 풀기
getOption("max.print")
options(max.print = 999999999) # 디폴트 값으로 출력량은 1000개임
titanic #이제 끝까지 확인 가능

# 2. 데이터 저장(출력) 하기
# 1) 화면 출력 
x <- 20
y <- 30
z <- x+y
cat(x, '과 ',y, '를 더하면', z, '가 됩니다' )
print(z) # 함수 내에서 출력
print(z**2) # 수식 가능

# 2) 파일 저장(출력)
# read.table -> write.table : 구분자(공백, 특수문자)
# read.csv -> write.csv     : 구분자(콤마)
# read.xlsx -> write.xlsx   : 엑셀 (패키지 필요)

# (1) write.table() :공백
setwd("C:/ITWILL/2_Rwork/output")
write.table(titanic, "titanic.txt", row.names = F)
write.table(titanic, "titanic2.txt", quote = F, row.names = T)

# (2) write.csv() :콤마
head(titanic)
str(titanic_df)
titanic_df <- titanic[,-1] # 1번째 열인 x를 제외시킨 데이터 프레임
write.csv(titanic_df, "titanic_df.csv", row.names = F, quote = F)

# (3) write.xlsx() : 엑셀 파일
search()
write.xlsx(titanic, "titanic.xlsx", sheetName = "titanic", row.names = F)
