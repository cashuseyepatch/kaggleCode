##  Reads in the sample submission.  

sample_submission <- read.csv("sample_submission_2015.csv")

##  Reads in seeds.  

seeds <- read.csv("tourney_seeds_2015.csv")

mySubmission <- sample_submission

##  The following function reads in a game id, looks up the seeds for the two
##  teams and calculates the probability of team 1 winning by the equation:
##  .5 + .3(team2seed - team1seed)

compute.pred <- function(gameID){
    team1ID <- substr(gameID,6,9)
    team2ID <- substr(gameID,11,14)
    team1Seed <- as.numeric(substr(seeds[seeds$team==team1ID, "seed"], 2, 3))
    team2Seed <- as.numeric(substr(seeds[seeds$team==team2ID, "seed"], 2, 3))
    return(.5 + .03*(team2Seed - team1Seed))
}

mySubmission$pred <- sapply(sample_submission$id, compute.pred)

write.csv(mySubmission, file="mySubmission.csv", row.names=FALSE)

##  I'm going to pick teams best on the following order: 1) Gonzaga
##  2)Kentucky 3)Wisconsin 4)Villanova 5)Duke for my second submission.  
##  These teams will be assigned 
##  .98 probabilities of winning against all teams slotted below them.  

mySubmission_2 <- mySubmission

##  Duke.  

mySubmission_2$pred <- ifelse(substr(mySubmission_2$id, 6, 9) == 1181, 
                              .99, mySubmission_2$pred)

mySubmission_2$pred <- ifelse(substr(mySubmission_2$id, 11, 14) == 1181,
                              .01, mySubmission_2$pred)

##  Villanova.  


mySubmission_2$pred <- ifelse(substr(mySubmission_2$id, 6, 9) == 1437, 
                              .99, mySubmission_2$pred)

mySubmission_2$pred <- ifelse(substr(mySubmission_2$id, 11, 14) == 1437,
                              .01, mySubmission_2$pred)


##  Wisconsin.  

mySubmission_2$pred <- ifelse(substr(mySubmission_2$id, 6, 9) == 1458, 
                              .99, mySubmission_2$pred)

mySubmission_2$pred <- ifelse(substr(mySubmission_2$id, 11, 14) == 1458,
                              .01, mySubmission_2$pred)


##  Kentucky.

mySubmission_2$pred <- ifelse(substr(mySubmission_2$id, 6, 9) == 1246, 
                              .99, mySubmission_2$pred)

mySubmission_2$pred <- ifelse(substr(mySubmission_2$id, 11, 14) == 1246,
                              .01, mySubmission_2$pred)

##  Gonzaga. 

mySubmission_2$pred <- ifelse(substr(mySubmission_2$id, 6, 9) == 1211, 
                              .99, mySubmission_2$pred)

mySubmission_2$pred <- ifelse(substr(mySubmission_2$id, 11, 14) == 1211,
                              .01, mySubmission_2$pred)


write.csv(mySubmission_2, file="mySubmission_2.csv", row.names=FALSE)

