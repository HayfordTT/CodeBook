  # Getting and cleaning data - Peer Graded Assigment by Hayford Tetteh
 
  # Introduction
  # The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
  # The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers 
  # on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data 
  # set as described below, 2) a link to a Github repository with your script for performing the analysis, 
  # and 3) a code book that describes the variables, the data, and any transformations or work that you 
  # performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with
  # your scripts. This repo explains how all of the scripts work and how they are connected.
  # One of the most exciting areas in all of data science right now is wearable computing - see for example
  # this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced 
  # algorithms to attract new users. The data linked to from the course website represent data collected 
  # from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the 
  # site where the data was obtained:
  # http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
  # Here are the data for the project:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
  # You should create one R script called run_analysis.R that does the following.
  
  # 1. Merges the training and the test sets to create one data set.
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  # 3. Uses descriptive activity names to name the activities in the data set
  # 4. Appropriately labels the data set with descriptive variable names.
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for
  #    each activity and each subject.
  
  # MY SOLUTION
  
  # Load required libraries
  library(dplyr, warn.conflicts = FALSE)

  #File URL to download
  # Download the dataset and unzip if necessary
  filename <- "Coursera_DS3_Final.zip"
  
  # Checking if archieve already exists.
    if (!file.exists(filename)){
         fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
         download.file(fileURL, filename, method="curl")
       }  

   # Checking if folder exists
   if (!file.exists("UCI HAR Dataset")) { 
         unzip(filename) 
       }
   
   # 1.  Merges the training and the test sets to create one data set.
     
     features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
     activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
     subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
     x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
     y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
     subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
     x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
     y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
     
       
       X <- rbind(x_train, x_test)
       Y <- rbind(y_train, y_test)
       Subject <- rbind(subject_train, subject_test)
       Merged_Data <- cbind(Subject, Y, X)
      
       
       head(x_train, 2)
       dim(X)
       dim(Y)
       dim(Subject)
       dim(Merged_Data)
       
       #The old FIle and the new Fmerged files Have the same dimensions
                dim(X)
      # [1] 10299   561
               dim(Y)
      # [1] 10299     1
               dim(Subject)
      # [1] 10299     1
               dim(Merged_Data)
      # [1] 10299   563
       
      
       
        
       # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
       TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
         
       #head(TidyData, 2)
       #tail(TidyData, 2)
       
        
       # 3. Uses descriptive activity names to name the activities in the data set
        TidyData$code <- activities[TidyData$code, 2]
         
         
       # 4: Appropriately labels the data set with descriptive variable names
         names(TidyData)[2] = "activity"
         names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
         names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
         names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
         names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
         names(TidyData)<-gsub("^t", "Time", names(TidyData))
         names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
         names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
         names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
         names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
         names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
         names(TidyData)<-gsub("angle", "Angle", names(TidyData))
         names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
         
  
        # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for
        #each activity and each subject.
           
         FinalData <- TidyData %>%
         group_by(subject, activity) %>%
         summarise_all(funs(mean))
         write.table(FinalData, "FinalData.txt", row.name=FALSE)
        
        
         head(FinalData, 2)
         # A tibble: 2 x 88
         # Groups:   subject [1]
        # subject activity TimeBodyAcceler~ TimeBodyAcceler~ TimeBodyAcceler~ TimeGravityAcce~ TimeGravityAcce~
        #   <int> <fct>               <dbl>            <dbl>            <dbl>            <dbl>            <dbl>
        # 1       1 LAYING              0.222         -0.0405            -0.113           -0.249            0.706
        
        ##subject activity TimeBodyAcceler~ TimeBodyAcceler~ TimeBodyAcceler~ TimeGravityAcce~ TimeGravityAcce~
        #   <int> <fct>               <dbl>            <dbl>            <dbl>            <dbl>            <dbl>
        # 1      30 LAYING              0.281         -0.0194           -0.104            -0.345            0.733
        # 2      30 SITTING             0.268         -0.00805          -0.0995            0.825            0.115
        # 3      30 STANDING            0.277         -0.0170           -0.109             0.969           -0.100
        # 4      30 WALKING             0.276         -0.0176           -0.0986            0.965           -0.158
        # 5      30 WALKING~            0.283         -0.0174           -0.1000            0.958           -0.127
        # 6      30 WALKING~            0.271         -0.0253           -0.125             0.932           -0.227
       
         write.table(FinalData, file="FinalData.txt", row.name=FALSE, sep = "\t")
         