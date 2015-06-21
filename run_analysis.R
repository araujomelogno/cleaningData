run_analysis  <-  function(){
  ##we load the test  (561 variables)
  testSet <- read.table(file = "test/X_test.txt", sep = "")
  meanAndStdColumns <-c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271
                        ,294:296,345:350,373:375,424:429,452,453,454,503,504,513,516,517
                        ,526,529,530,539,542,543,552)
  ##we take the names of the variable to label the columns from features.txt 
  variableNames <- read.table(file = "features.txt", sep = "")
  for(r in 1:length(meanAndStdColumns)){
    names(testSet)[meanAndStdColumns[r]] = as.character(variableNames[meanAndStdColumns[r],2])
  }
  ## we keep only the mean and standard deviations (info provided in features.info) (79Variables)
  testSet <- testSet[,meanAndStdColumns]
  ## we load the actibity numbers   
  testActivityLabels <- read.table(file = "test/y_test.txt", sep = "")
  ##the individuals for that set 
  testSubjects <-read.table(file = "test/subject_test.txt", sep = "")
  ##we add the individual  numbers and the activity numbers to the set (81 variables)
  testSet <- cbind(testSubjects,testActivityLabels,testSet)
   
  
  
  ##we load the test  (561 variables)
  trainSet <- read.table(file = "train/X_train.txt", sep = "")
  ## we keep only the mean and standard deviations (info provided in features.info) (79Variables)
  
  for(r in 1:length(meanAndStdColumns)){
    names(trainSet)[meanAndStdColumns[r]] = as.character(variableNames[meanAndStdColumns[r],2])
  }
  
  trainSet <- trainSet[,meanAndStdColumns]
  ##the individuals for that set 
  trainSubjects <-read.table(file = "train/subject_train.txt", sep = "")
  ## we load the actibity numbers   
  trainActivityLabels <- read.table(file = "train/y_train.txt", sep = "")
  ##we add the individual  numbers and the activity numbers to the set (81 variables)
  trainSet <- cbind(trainSubjects,trainActivityLabels,trainSet)
  
  
  mergedSet <-rbind(testSet,trainSet) 
  names(mergedSet)[1] = "SubjectId"
  names(mergedSet)[2] = "activityId"
  
  activities <- read.table(file = "activity_labels.txt", sep = "")
  
  names(activities)[1] = "activityId"
  names(activities)[2] = "activityLabel"
  ## we assign the name of each activity joining that 
  mergedSet <- merge(x = activities ,y = mergedSet,by.x = "activityId", by.y ="activityId")
  ##we drop de activityId and the repetead label 
  mergedSet <- mergedSet[,-c(1)]
  names(mergedSet)[1] = "activityLabel"
  names(mergedSet)[2] = "SubjectId"
  ##mergedSet is the data requested through items 1 to 4 in the project , with the average of each 
  ##variable for each activity and each subject.
  library(plyr)
  library(dplyr)
  newDataSet <- mergedSet %>% group_by(activityLabel,SubjectId) %>% summarise_each(funs(mean))
  ##finally we write in an output file 
  write.table(newDataSet,file="newDataSet.csv",sep = ";", row.name=FALSE)
}
