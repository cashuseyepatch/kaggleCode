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

