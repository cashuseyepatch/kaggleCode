##  This was a 'beat the bench mark' submission for the african soil contest.  
##  It placed in the top %25.  It's a simple support vector machine.  

library(e1071)



train <- read.csv("training.csv",header=TRUE,stringsAsFactors=FALSE)

test <- read.csv("sorted_test.csv",header=TRUE,stringsAsFactors=FALSE)



submission <- test[,1]



labels <- train[,c("Ca","P","pH","SOC","Sand")]



train <- train[,2:3579]

test <- test[,2:3579]



svms <- lapply(1:ncol(labels),
               
               function(i)
                   
               {
                   
                   svm(train,labels[,i],cost=10000,scale=FALSE)
                   
               })



predictions <- sapply(svms,predict,newdata=test)



colnames(predictions) <- c("Ca","P","pH","SOC","Sand")

submission <- cbind(PIDN=submission,predictions)



write.csv(submission,"beating_benchmark2.csv",row.names=FALSE,quote=FALSE)