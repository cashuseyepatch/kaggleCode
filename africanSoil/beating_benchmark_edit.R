##  This code was given in the African Soil competition on Kaggle.  This gave you a top 25% finish.  

library(e1071)



train <- read.csv("training.csv",header=TRUE,stringsAsFactors=FALSE)

test <- read.csv("sorted_test.csv",header=TRUE,stringsAsFactors=FALSE)


submission <- test[,1]

labels <- train[,c("Ca","P","pH","SOC","Sand")]

train_features <- subset(train, select = names(train) 
                         != c("Ca","P","pH","SOC","Sand"))

names(train_features)

train_features <- train_features[,-c(2656:2670)]
