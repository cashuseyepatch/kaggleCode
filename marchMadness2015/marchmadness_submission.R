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

##  I'm going to pick teams to win by the following order: 1) Gonzaga
##  2)Kentucky 3)Wisconsin 4)Villanova 5)Duke for my second submission.  
##  These teams will be assigned 
##  .99 probabilities of winning against all teams seeded below or my picks
##  below them.  

second <- mySubmission

for (i in c(1181, 1437, 1458, 1246, 1211)) {

second$pred <- ifelse(substr(second$id, 6, 9) == i, 
                              .99, second$pred)

second$pred <- ifelse(substr(second$id, 11, 14) == i,
                              .01, second$pred)

}

write.csv(second, file="second.csv", row.names=FALSE)