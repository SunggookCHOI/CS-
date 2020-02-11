#plyr
# 난수 생성 고정
set.seed(1)
# year는 2012부터 2014까지 3개씩 생성하며, count 변수로 0부터 20까지 중 난수 생성 후 할당
d=data.frame(year = rep(2012:2014, each=3), count = round(runif(9,0,20)))

library(plyr)
ddply(d,"year", function(x){
  mean.count = mean(x$count)
})

# year에 대하여 그룹연산
ddply(d,"year",summarise, mean.count = mean(count))

# count 변수는 그대로 남아있고, total.count라는 새로운 변수들은 year별 그룹연산의 결과
ddply(d,"year",transform,total.count = sum(count))


#데이터 테이블 (데이터프레임보다 그룹화 연산이 코드도 짧고 빠르다. 대신 메모리소모가 크다)
library(data.table)
# rnorms(n)은 정규분포에서 난수 6개 생성
DT = data.table(x=c("a","a","a","b","b","b"), v = rnorm(6))
# x가 b인 행들
DT[DT$x=="b",]
# DT의 키를 x로
setkey(DT,x)

data(cars)
cars = data.table(cars)
# 생성된 데이터테이블들의 정보
tables()

### 데이터 탐색
data(iris)
head(iris)
summary(iris)
cov(iris[,1:4])
var(iris[,1])

### 결측치
y <- c(1,2,3,NA)
is.na(y)
mean(y)
mean(y,na.rm = T)

library(Amelia)
data("freetrade")
head(freetrade)
# raw 데이터의 결측치 표시
missmap(freetrade)
# m개의 imputation 데이터세트를 만든다.
a.out <- amelia(freetrade, m=5, ts="year", cs="country")
hist(a.out$imputations[[3]]$tariff,col="grey",border = "white")

missmap(a.out)
freetrade2 <- freetrade
freetrade2$tariff<-a.out$imputations[[5]]$tariff
# tariff의 결측치 보정 후의 결측치 표시
missmap(freetrade2)

### 이상치
x=rnorm(100)
boxplot(x)
summary(x)

x=c(x,100,90)
boxplot(x)

library(outliers)
#평균과 가장 차이가 많이 나는 값 표시
outlier(x)
