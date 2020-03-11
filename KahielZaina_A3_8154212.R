
Zaina Kahiel
8154212
Assignment three


#ASSIGNMENT!!!!!!!!!!!!!!!!!!!!!!!!!!
install.packages("tidyverse")
library(tidyverse)
view(mpg)
nrow(mpg)
ncol(mpg)
dim(mpg) 

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

plot2<-ggplot(data = mpg)
#question 2
plot2 + geom_point(mapping = aes(x = displ, y = hwy,color = class))

#QUESTION 3
plot2 + geom_point(mapping = aes(x = displ, y = hwy,color = class, shape=drv))

#QUESTION 4
plot4<- plot2 + geom_point(mapping = aes(x = displ, y = hwy,color = class, shape=drv, size=cyl))

#QUESTION 5
plot4 + labs(title= 'highway fuel effieiency versus engine size', x='engine size', y = 'highway fuel efficiency')
