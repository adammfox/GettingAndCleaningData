run_analysis <- function(){
  library(plyr)
  library(dplyr)
  
  #load variable names, convert to character
  fts<-read.table("features.txt")
  fts$V2<-as.character(fts$V2)
  
  #Merge test and train data.  Delete original data sets
  trainDat<-read.table("X_train.txt",nrows=-1,col.names=fts$V2)
  testDat<-read.table("X_test.txt",nrows=-1,col.names=fts$V2)
  fullDat<-rbind(trainDat,testDat)
  rm(trainDat,testDat)
  
  #Extract any column name that contains the string "mean" 
  mean_names<-select(fullDat,contains("mean"))
  std_names<-select(fullDat,contains("std"))
  
  #Get number of features, combine the two sets
  numfeat=length(mean_names)+length(std_names)
  data<-cbind(mean_names,std_names)
  
  #Convert column names to recommended format: all lower case, no dots or white space.
  cnames<-tolower(colnames(data))
  cnames<-gsub("[.]","",cnames)
  colnames(data)<-cnames
  
  #Add the other data
  trainActivities<-read.table("y_train.txt",nrows=-1,col.names="activity",colClasses="factor")
  testActivities<-read.table("y_test.txt",nrows=-1,col.names="activity",colClasses="factor")
  act<-rbind(trainActivities,testActivities)
  
  trainID<-read.table("subject_train.txt",nrows=-1,col.names="subjectid")
  testID<-read.table("subject_test.txt",nrows=-1,col.names="subjectid")
  ids<-rbind(trainID,testID)
  
  
  #Construct Full Data Frame with all necessary columns.  Delete unneeded data
  data<-cbind(data,act,ids)
  rm(trainID,testID,trainActivities,testActivities,act,ids,mean_names,std_names)
  
  
  

  #Now, lets describe the activities.  Since there are only six we will do this manually with plyr
  data$activity<-revalue(data$activity,c("1"="Walking","2"="Walking_Upstairs","3"="Walking_Downstairs","4"="Sitting",
                          "5"="Standing","6"="Laying"))
  
  #Finally Lets Compute the Summary Data as Requested and print the resulting data frame
  by_groups<-group_by(data,activity,subjectid)
  means<-summarise_each(by_groups,funs(mean))
  write.table(means,file="TidyData.txt",row.name=FALSE)
  means
}