# R_
R 기초부터 머신러닝 까지 복습차원으로 작성 중입니다. 

### [chap04_2_Function](https://github.com/Ki-Hong-Kim/R_/blob/master/R_script/chap04_2_Function.R)
<details>
    <summary>1. 사용자 정의 함수 </summary>
    <blockquote> > 함수: 매개변수 </blockquote>
    <blockquote> > 함수: return </blockquote>
</details>

<details>
    <summary> 2. NA 처리 방법 </summary>
    <blockquote> > NA값 제거: na.omit(x) </blockquote>
    <blockquote> > 조건문을 활용한 다른 값으로 대체 </blockquote>
</details>

<details>
    <summary> 3. 내장 함수 </summary>
    <blockquote> > 기술 통계 함수 </blockquote>
    <blockquote> > 난수 생성 함수 </blockquote>
</details>

<details>
    <summary> 4. 홀드아웃 & 행렬 연산 </summary>
    <blockquote> > 홀드 아웃 </blockquote>
    <blockquote> > 행렬  </blockquote>
</details>

### [chap01_basic](https://github.com/Ki-Hong-Kim/R_/blob/master/R_script/chap01_basic.R)
<details>
    <summary>1. 패키지와 세션</summary>
    <blockquote> > 패키지와 세션의 정보를 확인 하는 방법 </blockquote>
</details>

<details>
    <summary>2. 패키지 사용법</summary>
    <blockquote> > 패키지 설치와 호출(활성화) </blockquote>
    <blockquote> > 패키지 문제 발생시 삭제하는 방법 </blockquote>
</details>

<details>
    <summary>3. 변수와 자료형</summary>
    <blockquote> > 변수란? </blockquote>
    <blockquote> > 변수 작성 규칙과 방식 </blockquote>
    <blockquote> > 데이터 타입 </blockquote>
</details>

<details>
    <summary>4. 기본 함수와 작업 공간</summary>
    <blockquote> > 기본 함수 확인 방법 </blockquote>
    <blockquote> > 작업공간 확인 및 설정 방법 </blockquote>
</details>

### [chap02_Datastructure](https://github.com/Ki-Hong-Kim/R_/blob/master/R_script/chap02_Datastructure.R)
<details>
    <summary>1. Vector</summary>
    <blockquote> > 벡터 생성 함수 : c(), seq(), rep() </blockquote>
    <blockquote> > vector index 사용방법 </blockquote>
</details>

<details>
    <summary>2. Matrix </summary>
    <blockquote> > Matrix 생성 함수 : matrix(), rbind(), cbind() </blockquote>
    <blockquote> > matrix index 사용방법 </blockquote>
    <blockquote> > broadcast 연산이란? </blockquote>
    <blockquote> > apply() </blockquote>
</details>

<details>
    <summary>3. Array </summary>
    <blockquote> > arry index 사용방법 </blockquote>
</details>

<details>
    <summary>4. Data.Frame </summary>
    <blockquote> > DataFrame 생성 방법: data.frame() </blockquote>
    <blockquote> > data.frame index 참조하는 방법: index or column </blockquote>
</details>

<details>
    <summary> 5. List </summary>
    <blockquote> > List index 참조하는 방법: key, value </blockquote>
    <blockquote> > List 형 변환 (List -> Matrix)</blockquote>
    <blockquote> > do.call() 함수 </blockquote>
</details>

<details>
    <summary> 6. Subset </summary>
    <blockquote> > subset 이란? </blockquote>
    <blockquote> > [실습] iris를 사용해 subset 생성 </blockquote>
</details>

<details>
    <summary> 7. 패키지 stringr  </summary>
    <blockquote> > 문자열 처리와 정규 표현식 </blockquote>
</details>

### [chap03_Data_IO](https://github.com/Ki-Hong-Kim/R_/blob/master/R_script/chap03_Data_IO.R)
<details>
    <summary>1. 데이터 불러오기 </summary>
    <blockquote> > 키보드 입력: scan() </blockquote>
    <blockquote> > 파일 읽기: read.table(), read.csv() <br> &emsp;&emsp;&emsp; 옵션: header, na.strings, file.choose() </blockquote>
    <blockquote> > xls/xlsx 읽기: 패키지 "xlsx" <br> &emsp;&emsp;&emsp;&emsp; 옵션: sheetindex, encoding</blockquote>
    <blockquote> > 인터넷 파일 읽기 <br>  &emsp;간단한 기초 통계 확인 </blockquote>
</details>
<details>
    <summary>2. 데이터 저장(출력)하기</summary>
    <blockquote> > 화면 출력: cat(), print() </blockquote>
    <blockquote> > 파일 저장: wrtie.table(), wrtie.csv(), write.xlse() </blockquote>
</details>

### [chap04_1_Control](https://github.com/Ki-Hong-Kim/R_/blob/master/R_script/chap04_1_Control.R)
<details>
<summary> 0-1 산술 연산자 </summary>
<div markdown="1"> 
    
|기호|예시|결과|
|--|--|--|
|+ (덧셈)|3 + 3| 6|
|- (뺄셈)|3 - 3| 0|
|* (곱셈)|3 * 3| 9|
|/ (나눗셈)| 6 / 3|2|
|%% (나머지)|5 %% 3|2|
|^ (제곱)|3 ^ 3| 27|

</div>
</details>

<details>
<summary> 0-2 관계 연산자 </summary>

<div markdown="1">

|관계 연산자|기호|예시(결과)|
|--|--|--|
|동등 연산자|== (같다), != (다르다)| 1 == 1 (True) <br> 1 !=  1 (False)|
|크기 비교 연산자|>, >=, <, <= | 5 > 1 (True) <br> 4 >= 4 (True) <br>  5 < 3 (False)|
|논리 연산자|& (and), \| (or), ! (negative)| 4 >= 4 & 3 == 3 (True) <br> 4 >= 4 \| 3 != 3 (True)|

<p> ** and 는 하나라도 거짓일 경우 False, or은 하나라도 참일 경우 True </p>

</div>
</details>

<details><summary> 0-3 xor </summary><blockquote> xor 서로 상반된 값을 갖고 있다면 True <br> &emsp;&nbsp;&nbsp; 서로 같은 값을 갖고 있다면 False </blockquote></details>

<details>
<summary> 1. 조건문 : if문 </summary>
<div markdown="1">
    
|조건문| 양식 |
|--|--|
|if else| if(조건문){조건 충족 함수} else {조건 미충족 함수}|
|if else if else| if(조건1){조건1 충족} else if(조건2){조건2 충족} else {조건2 충족x} <br> **여러 조건을 사용해야하면 계속 if else를 추가할 수 있다.|
|ifelse| ifelse(조건, 조건 충족, 조건 미충족)|
</div>
        
</details>

<details>
    <summary> 2. 반복문 </summary>
    <blockquote> > for 문 </blockquote>
    <blockquote> > while 문 </blockquote>
    <p> 두 반복의 차이점: for은 반복 횟수가 정해져있고 while은 조건 충족할때 까지 무한 반복한다. </p>
</details>
