#1.Download and unzip files 
setwd("C:/Analytics/Coursera Training/3- Getting and Cleaning Data/Week 4/Project")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="UCI HAR Dataset.zip")
unzip(zipfile="UCI HAR Dataset.zip")

#2.Read Files into variables
#2.1 Read Activity labels and values
ActivityValue_Train<-read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
ActivityValue_Test<-read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
ActivityLabel<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
#2.2 Read Subject values
SubjectValue_Train<-read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
SubjectValue_Test<-read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
#2.3 Read Feature labels and values
FeatureValue_Train<-read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
FeatureValue_Test<-read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
FeatureLabel<-read.table("./UCI HAR Dataset/features.txt",header=FALSE)

#3. Merge the training data set with the test data set
Activity<-rbind(ActivityValue_Test,ActivityValue_Train)
Feature<-rbind(FeatureValue_Test,FeatureValue_Train)
Subject<-rbind(SubjectValue_Test,SubjectValue_Train)

#4. Set column names to data frames
names(Activity)<-c("Activity")
names(Subject)<-c("Subject")
names(Feature)<-FeatureLabel$V2

#5. Merge Activity, Subject and Feature into one data set
Complete_Data<-cbind(Activity, Subject, Feature)

#6. Extract only meansurements on the mean and standard deviation for each measurement
SubFeatureLabel<-FeatureLabel$V2[grep("(.*)mean\\(\\)|(.*)std\\(\\)",FeatureLabel$V2)]
SubFeatureLabel<-c(as.character(SubFeatureLabel),"Subject","Activity")
Data<-subset(Complete_Data,select=SubFeatureLabel)

#7. Join descriptive activity names to the data set
names(ActivityLabel)<-c("Activity","ActivityName")
Data<-merge(Data,ActivityLabel,by='Activity')

#8. Rename all variables with descriptive names
names(Data)<-gsub("^t","time",names(Data))
names(Data)<-gsub("^f","frequency",names(Data))
names(Data)<-gsub("Acc","Acceleration",names(Data))
names(Data)<-gsub("Gyro","Gyroscope",names(Data))
names(Data)<-gsub("Mag","Magnitude",names(Data))
                  
#9. Create another data set with the average of each variable for each activity and each subject
Data2<-Data
Data2$Subject<-as.factor(Data2$Subject)
Data2<-aggregate(. ~Subject+ActivityName,Data2,mean)
Data2<-Data2[order(Data2$Subject,Data2$ActivityName),]
write.table(Data2,file="tidydata.txt",row.name=FALSE)




