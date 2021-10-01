#카페 매출 데이터 분석

install.packages("readx1")
library(readxl)

sales=read_xlsx("Cafe_Sales.xlsx")
head(sales)
tail(sales)
dim(sales)
str(sales)
summary(sales)
View(sales)

#결측치 확인 ... NA확인 및 제거

is.na(sales)

#전체를 살펴볼때 몇만개짜리를 하나하나 확인할수 없기때문에
#테이블을 활용해 준다.

table(is.na(sales))

#결측치를 자동으로 보여주는 기능이 있지만 일단 기본부터 가보자.
table(is.na(sales$order_id))
table(is.na(sales$order_date))
#date에 있다는게 확인되었다. 키워드를 이용하여 날려보자

#결측치 제거
sales <- na.omit(sales)
table(is.na(sales))



head(sales)

#order_id를 보면 중복된값들이 있다. 손님이 4개의 order를 한것이다.
#이러한 중복값들을 정리하는걸 알아보자.

#일단 중복값을 정렬하여 확인하는 unique
unique(sales$order_date)
#날짜를 찍어보니 시간까지 order_date열에 함께 들어가있다.
# UTC <- 과학 표준 시간

unique(sales$price)
unique(sales$item)
unique(sales$category)


#매장에서 팔린 제품의 총 판매 금액이 얼마나 될까
#혹은 제품마다 판매한 갯수는 몇개나 될까

table(sales$item)
sort(table(sales$item)) #오름차순정렬
sort(table(sales$item),decreasing = TRUE) #내림차순정렬


#매출액 계산
sales_tr <- data.frame(table(sales$item))
sales_tr

#매출액을 정확하게 알려면, 아이템과 판매량 그리고 가격까지 알아야한다.
#일단 set으로 만들어서 조회해보자
#아이템별 판매량 set
sales_item <- subset.data.frame(sales, select = c("item","price"))
sales_item

sales_item <- unique(sales_item)
sales_item

#제품별 판매 개수와 제품별 가격을 계산하여보자
#merge합병
item_list <- merge(sales_tr, sales_item)
item_list
#중복값이 또 나온다. 합쳐보자.
item_list <- merge(sales_tr, sales_item, by.x="Var1", by.y="item")
item_list

item_list$amount <- item_list$Freq * item_list$price
item_list
#매출이 상품별로 잘 나온다. 합산해보자

sum(item_list$amount)

#요일별 판매 분석
#함수를 이용해 요일을 표시해보자
sales$weekday <- weekdays(sales$order_date)
#요일별 판매량
table(sales$weekday)

date_info <- data.frame(weekday = c("월요일","화요일","수요",
                                   "목요일","금요일","토요일","일요일"),
                       day=c("평일","평일","평일","평일","평일","주말","주말"))
sales <- merge(sales,date_info)
head(sales)
table(sales$day)



#계절별 판매 분석
#자 그럼 season이라는 열을 만들어서 12~2겨울.3~5봄.6-8여름,9~11가을
#season<-data.frame(month=c(1,2,3,4,5,6,7,8,9,10,11,12),
#                   season=c("겨울","겨울","봄","봄","봄","여름","여름","여름","가을"#,"가을","가을","겨울"))

sales$month <- months(sales$order_date)
sales$month <- as.integer(gsub('월','',sales$month))

sales$season <- ifelse(sales$month>=12,"겨울",
                       ifelse(sales$month>=9,"가을",
                       ifelse(sales$month>=6,"여름",
                       ifelse(sales$month>=3,"봄",
                       ifelse(sales$month>=1,"겨울")))))

head(sales)
table(sales$season)

#시각화

cate <- data.frame(table(sales$category))
cate

library(ggplot2)
ggplot(cate, aes(Var1,Freq))+
  geom_col()+
  geom_text(label=cate$Freq)


#요일별 판매 건수 시각화.

week<-data.frame(table(sales$weekday))
week


ggplot(week, aes(Var1,Freq))+
  geom_col()+
  geom_text(label=week$Freq)

#퍼센트로 값을 나눠보자
week$per <- week$Freq / sum(week$Freq) *100
week

#ggplot이용해서 그리기
ggplot(week, aes(x="",y=per,fill=Var1))+
  geom_col()


