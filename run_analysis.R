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
  
  #Finally Lets Compute the Summary Data as Requested.  First we build a matrix with the mean values
  Means<-matrix(nrow=180,ncol=numfeat)
  
  
  #Loop through all unique elements in SubjectID and Activity. Filter  
  #and take column sum.  Fill in matrix as you go
  Acts=unique(data$activity)
  ct<-1
  for(A in Acts){
    for(i in 1:30){
      Means[ct,]<-filter(data,activity==A,subjectid==i) %>% select(-c(activity,subjectid)) %>% colMeans()
      ct<-ct+1
    }
  }
  
  Means<-as.data.frame(Means)
  colnames(Means)<-cnames
  Means<-cbind(arrange(expand.grid(activity=unique(data$activity),id=1:30),activity),Means)
  write.table(Means,file="TidyData.txt",row.name=FALSE)
  Means
}