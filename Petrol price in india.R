library(ggplot2)
library(dplyr)
library(choroplethr)
library(choroplethrMaps)
library(openintro)
library(tidyverse)
library(scales)
print(getwd)
d<-read.csv('C:/Users/vismaya/Desktop/PetrolPrice in India.csv')
print(d)

# statistical operations

print(summary(d))
print(str(d))
print(glimpse(d))
print(head(d))
print(tail(d))
print(is.na(d))
print(dimn(d))
print(dim(d))
print(names(d))
print(is.data.frame(d))
print(is.name(d))
print(ncol(d))
print(nrow(d))
print(d$Highest)
print(sort(d$Highest))
print(rownames(d))
print(summary(d))
print(unique(d))
print(max(d$Highest))
print(min(d$Highest))
print(quantile(d$Highest))
print(quantile(d$Highest,c(0.25)))
print(mean(d$Highest))
print(mean(d$Highest,trim=0.10))
print(median(d$Highest))
print(var(d$Highest))
print(sd(d$Highest))
print(prod(d$Highest))
print(is.na(d$Highest))
print(is.data.frame(d$Highest))
print(which.max(d$Highest))
print(which.min(d$Highest))


## Data Visualization

# Highest petrol price in monthwise
monthwise=d %>% group_by(Month.Year) %>% summarise(Highest)
  View(monthwise)
  
#  Descending highest petrol price in monthwise  
monthwise=d %>% group_by(Month.Year) %>% summarise(Highest) %>% arrange((desc(Highest)))
  View(monthwise)
  
#Lowest petrol price in monthwise  
monthwise=d %>% group_by(Month.Year) %>% summarise(Lowest) %>% arrange((desc(Lowest)))
  View(monthwise)

  
#  Plotting the highest price in monthwise:
highestprice=ggplot(d,aes(x=Month.Year, y=Highest, fill=Month.Year))+geom_col()
print(highestprice)

#  highest price in monthwise using scatterplot:
highestprice=ggplot(d,aes(x=Month.Year, y=Highest, fill=Month.Year))+geom_point()
print(highestprice)

#  Highest Vs Closing using line plot:
highestprice=ggplot(d,aes(x=Highest, y=Closing))+geom_line()
print(highestprice)

#  Highest Vs Closing using boxplot:
highestprice=ggplot(d,aes(x=Highest, y=Closing, fill=Highest),size=3.0)+geom_boxplot()
print(highestprice)

#  Geographic plot of highest petrol price in monthwise:
gsplot=d %>% group_by(Month.Year) %>% summarise(Highest)
view(gsplot)
#   highest divides lowest :                                                                                                                                                                                                        
bar=d %>% group_by(Month.Year) %>% summarise(PR=sum(Highest)/sum(Lowest)) %>% arrange(desc(PR))
View(bar)

PS=ggplot(bar,aes(x=PR,y=Month.Year,fill=Month.Year))+ggtitle('Monthwise petrol price analysis')+theme(legend.position = 'None',axis.text.y = element_text(size=5))+geom_col()
print(PS)

## price per petrol in different monthwise:
price_petrol=ggplot(d,aes(x=Month.Year,y=sum(Highest)/sum(Lowest),fill=Month.Year))+ggtitle("Petrol prices")+theme(axis.text.x=element_text(angle = 60,size=5))+geom_col()
print(price_petrol)

##Shipping Model:
spro = d %>% ggplot(aes(x=Highest,y=Lowest,fill=Highest))+geom_col()+theme(axis.text.x=element_text(angle=60,size=5))
print(spro)

scat = d %>% ggplot(aes(x=Highest,y=Lowest,fill=Highest))+geom_col()+theme(axis.text.x=element_text(angle=60,size=5))+facet_wrap(~Highest)
print(scat)

##Highest and Lowest petrol price with and without monthwise:

d1=d
d1$monthwise=d$Highest-(d1$Highest*monthwise)
d1$Highest_price=d$Highest/d1$monthwise
d1$Lowest_price=d1$monthwise/d1$price
view(d1)

no_mon=d %>% filter(Month.Year==0.00) %>% summarise(Highest=sum(Highest))
print(no_mon)

