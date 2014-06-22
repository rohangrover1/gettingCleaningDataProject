run_analysis = function(){
  
  ## load all the variables into R
  ##------------------------------
  features <- read.table("features.txt", colClasses=c("numeric","character"))
  actLabels <- read.table("activity_labels.txt", colClasses=c("numeric","character"))
  
  ## load the data set
  xTest <- read.table("test\\X_test.txt", colClasses="numeric")
  xTrain <- read.table("train\\X_train.txt", colClasses="numeric")
  
  ## load all the activity labels
  yTest <- read.table("test\\Y_test.txt", colClasses="numeric")
  yTrain <- read.table("train\\Y_train.txt", colClasses="numeric")
  
  ## load the subject numbers
  subjTest <- read.table("test\\subject_test.txt", colClasses="numeric")
  subjTrain <- read.table("train\\subject_train.txt", colClasses="numeric")
  
  # combine all data sets
  jointData = rbind(xTest, xTrain)
  jointAcc = rbind(yTest, yTrain)
  jointSubj = rbind(subjTest, subjTrain)
  
  ## assign the labels to the columns
  names(jointData) <- features[,2]
  
  ##assign the activity names to the activity numbers
  jointAcc[,1] <- factor(jointAcc[,1], labels=actLabels[,2])
  
  ## set the names for activity and subject number data frames
  names(jointAcc) <- "Activity"
  names(jointSubj) <- "SubjectNum"
  
  ## combine all data into one large set
  allData <- cbind(jointSubj, jointAcc, jointData)
  
  # extract rows with mean and standard deviation
  rNames <- names(allData)
  meanRows <- grep("-mean()", rNames, fixed=T)
  stdRows <- grep("-std()", rNames, fixed=T)
  meanStdData <- allData[,c(meanRows, stdRows)]
  
  ## create the tidy data set
  ## start by first splitting the data frame into lists with the activitiy
  ## then split each activity by user and find the mean of for each of the variables
  tidyData <- data.frame(matrix(nrow=180,ncol=561))   ## allocate the maximum data frame
  newNames <- character(length=180)
  rowPntr <- 1
  
  Zactv <- split(allData, allData$Activity)
  N <- length(Zactv)
  namesZactv <- names(Zactv)
  for(n in 1:N){
    Zsubj <- split(Zactv[[n]], Zactv[[n]]$SubjectNum)
    K <- length(Zsubj)
    namesZsubj <- names(Zsubj)
    for(k in 1:K){
      meanVec <- suppressWarnings(sapply(Zsubj[[k]], mean))
      tidyData[rowPntr,] <- meanVec[2+(1:561)]
      newNames[rowPntr] = paste(namesZsubj[k], namesZactv[n])
      rowPntr = rowPntr +1
    }
  }
  
  ## truncate the data to correct length and add the respective labels
  tidyData <- cbind(newNames, tidyData)
  names(tidyData) <- c("UserActivity", features[,2])
  tidyData <- tidyData[1:rowPntr-1,]
  tidyData[,1] <- as.character(tidyData[,1])
  
  filename <- paste(getwd(), "/tidyData.txt", sep="")
  write.table(tidyData, filename, sep=" ", col.names=TRUE)

}








