# Getting and cleaning data - Peer Graded Assigment by Hayford Tetteh
> 
  > # Introduction
  > # The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
  > # The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers 
  > # on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data 
  > # set as described below, 2) a link to a Github repository with your script for performing the analysis, 
  > # and 3) a code book that describes the variables, the data, and any transformations or work that you 
  > # performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with
  > # your scripts. This repo explains how all of the scripts work and how they are connected.
  > # One of the most exciting areas in all of data science right now is wearable computing - see for example
  > # this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced 
  > # algorithms to attract new users. The data linked to from the course website represent data collected 
  > # from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the 
  > # site where the data was obtained:
  > # http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  > 
  > # Here are the data for the project:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  > 
  > # You should create one R script called run_analysis.R that does the following.
  > 
  > # 1. Merges the training and the test sets to create one data set.
  > # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  > # 3. Uses descriptive activity names to name the activities in the data set
  > # 4. Appropriately labels the data set with descriptive variable names.
  > # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for
  > #    each activity and each subject.
  > 
  > # MY SOLUTION
  > 
  > # Load required libraries
  > library(dplyr, warn.conflicts = FALSE)
> 
  > #File URL to download
  > # Download the dataset and unzip if necessary
  > filename <- "Coursera_DS3_Final.zip"
  > 
    > # Checking if archieve already exists.
    > if (!file.exists(filename)){
      +   fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      +   download.file(fileURL, filename, method="curl")
      + }  
  > 
    > # Checking if folder exists
    > if (!file.exists("UCI HAR Dataset")) { 
      +   unzip(filename) 
      + }
  > 
    > # 1.  Merges the training and the test sets to create one data set.
    > 
    > features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
    > activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
    > subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
    > x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
    > y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
    > subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
    > x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
    > y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
    > 
      > 
      > X <- rbind(x_train, x_test)
      > Y <- rbind(y_train, y_test)
      > Subject <- rbind(subject_train, subject_test)
      > Merged_Data <- cbind(Subject, Y, X)
      > 
        > dim(X)
      [1] 10299   561
      > dim(Y)
      [1] 10299     1
      > dim(Subject)
      [1] 10299     1
      > dim(Merged_Data)
      [1] 10299   563
      > 
        > 
        > # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
        > TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
        > 
          > head(TidyData)
        subject code tBodyAcc.mean...X tBodyAcc.mean...Y tBodyAcc.mean...Z tGravityAcc.mean...X tGravityAcc.mean...Y
        1       1    5         0.2885845       -0.02029417        -0.1329051            0.9633961           -0.1408397
        2       1    5         0.2784188       -0.01641057        -0.1235202            0.9665611           -0.1415513
        3       1    5         0.2796531       -0.01946716        -0.1134617            0.9668781           -0.1420098
        4       1    5         0.2791739       -0.02620065        -0.1232826            0.9676152           -0.1439765
        5       1    5         0.2766288       -0.01656965        -0.1153619            0.9682244           -0.1487502
        6       1    5         0.2771988       -0.01009785        -0.1051373            0.9679482           -0.1482100
        tGravityAcc.mean...Z tBodyAccJerk.mean...X tBodyAccJerk.mean...Y tBodyAccJerk.mean...Z tBodyGyro.mean...X
        1           0.11537494            0.07799634           0.005000803          -0.067830808       -0.006100849
        2           0.10937881            0.07400671           0.005771104           0.029376633       -0.016111620
        3           0.10188392            0.07363596           0.003104037          -0.009045631       -0.031698294
        4           0.09985014            0.07732061           0.020057642          -0.009864772       -0.043409983
        5           0.09448590            0.07344436           0.019121574           0.016779979       -0.033960416
        6           0.09190972            0.07793244           0.018684046           0.009344434       -0.028775508
        tBodyGyro.mean...Y tBodyGyro.mean...Z tBodyGyroJerk.mean...X tBodyGyroJerk.mean...Y tBodyGyroJerk.mean...Z
        1        -0.03136479         0.10772540            -0.09916740            -0.05551737            -0.06198580
        2        -0.08389378         0.10058429            -0.11050283            -0.04481873            -0.05924282
        3        -0.10233542         0.09612688            -0.10848567            -0.04241031            -0.05582883
        4        -0.09138618         0.08553770            -0.09116989            -0.03633262            -0.06046466
        5        -0.07470803         0.07739203            -0.09077010            -0.03763253            -0.05828932
        6        -0.07039311         0.07901214            -0.09424758            -0.04335526            -0.04193600
        tBodyAccMag.mean.. tGravityAccMag.mean.. tBodyAccJerkMag.mean.. tBodyGyroMag.mean.. tBodyGyroJerkMag.mean..
        1         -0.9594339            -0.9594339             -0.9933059          -0.9689591              -0.9942478
        2         -0.9792892            -0.9792892             -0.9912535          -0.9806831              -0.9951232
        3         -0.9837031            -0.9837031             -0.9885313          -0.9763171              -0.9934032
        4         -0.9865418            -0.9865418             -0.9930780          -0.9820599              -0.9955022
        5         -0.9928271            -0.9928271             -0.9934800          -0.9852037              -0.9958076
        6         -0.9942950            -0.9942950             -0.9930177          -0.9858944              -0.9952748
        fBodyAcc.mean...X fBodyAcc.mean...Y fBodyAcc.mean...Z fBodyAcc.meanFreq...X fBodyAcc.meanFreq...Y
        1        -0.9947832        -0.9829841        -0.9392687            0.25248290            0.13183575
        2        -0.9974507        -0.9768517        -0.9735227            0.27130855            0.04286364
        3        -0.9935941        -0.9725115        -0.9833040            0.12453124           -0.06461056
        4        -0.9954906        -0.9835697        -0.9910798            0.02904438            0.08030227
        5        -0.9972859        -0.9823010        -0.9883694            0.18108977            0.05798789
        6        -0.9966567        -0.9869395        -0.9927386            0.15738377            0.31883523
        fBodyAcc.meanFreq...Z fBodyAccJerk.mean...X fBodyAccJerk.mean...Y fBodyAccJerk.mean...Z fBodyAccJerk.meanFreq...X
        1           -0.05205025            -0.9923325            -0.9871699            -0.9896961                0.87038451
        2           -0.01430976            -0.9950322            -0.9813115            -0.9897398                0.60851352
        3            0.08267692            -0.9909937            -0.9816423            -0.9875663                0.11543400
        4            0.18569468            -0.9944466            -0.9887272            -0.9913542                0.03579805
        5            0.55978632            -0.9962920            -0.9887900            -0.9906244                0.27335020
        6            0.60559943            -0.9948507            -0.9882443            -0.9901575                0.32883589
        fBodyAccJerk.meanFreq...Y fBodyAccJerk.meanFreq...Z fBodyGyro.mean...X fBodyGyro.mean...Y fBodyGyro.mean...Z
        1                0.21069700                0.26370789         -0.9865744         -0.9817615         -0.9895148
        2               -0.05367561                0.06314827         -0.9773867         -0.9925300         -0.9896058
        3               -0.19343634                0.03825433         -0.9754332         -0.9937147         -0.9867557
        4               -0.09303585                0.16809523         -0.9871096         -0.9936015         -0.9871913
        5                0.07913538                0.29238418         -0.9824465         -0.9929838         -0.9886664
        6                0.05477140                0.32094497         -0.9848902         -0.9927862         -0.9807784
        fBodyGyro.meanFreq...X fBodyGyro.meanFreq...Y fBodyGyro.meanFreq...Z fBodyAccMag.mean.. fBodyAccMag.meanFreq..
        1            -0.25754888             0.09794711             0.54715105         -0.9521547            -0.08843612
        2            -0.04816744            -0.40160791            -0.06817833         -0.9808566            -0.04414989
        3            -0.21668507            -0.01726417            -0.11072029         -0.9877948             0.25789914
        4             0.21686246            -0.13524536            -0.04972798         -0.9875187             0.07358150
        5            -0.15334258            -0.08840273            -0.16223039         -0.9935909             0.39431033
        6            -0.36303968            -0.13323831             0.19483324         -0.9948360             0.43796212
        fBodyBodyAccJerkMag.mean.. fBodyBodyAccJerkMag.meanFreq.. fBodyBodyGyroMag.mean.. fBodyBodyGyroMag.meanFreq..
        1                 -0.9937257                      0.3469885              -0.9801349                  -0.1289889
        2                 -0.9903355                      0.5320605              -0.9882956                  -0.2719585
        3                 -0.9892801                      0.6607950              -0.9892548                  -0.2127279
        4                 -0.9927689                      0.6789213              -0.9894128                  -0.0356842
        5                 -0.9955228                      0.5590577              -0.9914330                  -0.2735820
        6                 -0.9947329                      0.2469096              -0.9905000                  -0.2973291
        fBodyBodyGyroJerkMag.mean.. fBodyBodyGyroJerkMag.meanFreq.. angle.tBodyAccMean.gravity.
        1                  -0.9919904                     -0.07432303                 -0.11275434
        2                  -0.9958539                      0.15807454                  0.05347695
        3                  -0.9950305                      0.41450281                 -0.11855926
        4                  -0.9952207                      0.40457253                 -0.03678797
        5                  -0.9950928                      0.08775301                  0.12332005
        6                  -0.9951433                      0.01995331                  0.08263215
        angle.tBodyAccJerkMean..gravityMean. angle.tBodyGyroMean.gravityMean. angle.tBodyGyroJerkMean.gravityMean.
        1                          0.030400372                       -0.4647614                          -0.01844588
        2                         -0.007434566                       -0.7326262                           0.70351059
        3                          0.177899480                        0.1006992                           0.80852908
        4                         -0.012892494                        0.6400110                          -0.48536645
        5                          0.122541960                        0.6935783                          -0.61597061
        6                         -0.143439010                        0.2750408                          -0.36822404
        angle.X.gravityMean. angle.Y.gravityMean. angle.Z.gravityMean. tBodyAcc.std...X tBodyAcc.std...Y tBodyAcc.std...Z
        1           -0.8412468            0.1799406          -0.05862692       -0.9952786       -0.9831106       -0.9135264
        2           -0.8447876            0.1802889          -0.05431672       -0.9982453       -0.9753002       -0.9603220
        3           -0.8489335            0.1806373          -0.04911782       -0.9953796       -0.9671870       -0.9789440
        4           -0.8486494            0.1819348          -0.04766318       -0.9960915       -0.9834027       -0.9906751
        5           -0.8478653            0.1851512          -0.04389225       -0.9981386       -0.9808173       -0.9904816
        6           -0.8496316            0.1848225          -0.04212638       -0.9973350       -0.9904868       -0.9954200
        tGravityAcc.std...X tGravityAcc.std...Y tGravityAcc.std...Z tBodyAccJerk.std...X tBodyAccJerk.std...Y
        1          -0.9852497          -0.9817084          -0.8776250           -0.9935191           -0.9883600
        2          -0.9974113          -0.9894474          -0.9316387           -0.9955481           -0.9810636
        3          -0.9995740          -0.9928658          -0.9929172           -0.9907428           -0.9809556
        4          -0.9966456          -0.9813928          -0.9784764           -0.9926974           -0.9875527
        5          -0.9984293          -0.9880982          -0.9787449           -0.9964202           -0.9883587
        6          -0.9989793          -0.9867539          -0.9973064           -0.9948136           -0.9887145
        tBodyAccJerk.std...Z tBodyGyro.std...X tBodyGyro.std...Y tBodyGyro.std...Z tBodyGyroJerk.std...X
        1           -0.9935750        -0.9853103        -0.9766234        -0.9922053            -0.9921107
        2           -0.9918457        -0.9831200        -0.9890458        -0.9891212            -0.9898726
        3           -0.9896866        -0.9762921        -0.9935518        -0.9863787            -0.9884618
        4           -0.9934976        -0.9913848        -0.9924073        -0.9875542            -0.9911194
        5           -0.9924549        -0.9851836        -0.9923781        -0.9874019            -0.9913545
        6           -0.9922663        -0.9851808        -0.9921175        -0.9830768            -0.9916216
        tBodyGyroJerk.std...Y tBodyGyroJerk.std...Z tBodyAccMag.std.. tGravityAccMag.std.. tBodyAccJerkMag.std..
        1            -0.9925193            -0.9920553        -0.9505515           -0.9505515            -0.9943364
        2            -0.9972926            -0.9938510        -0.9760571           -0.9760571            -0.9916944
        3            -0.9956321            -0.9915318        -0.9880196           -0.9880196            -0.9903969
        4            -0.9966410            -0.9933289        -0.9864213           -0.9864213            -0.9933808
        5            -0.9964730            -0.9945110        -0.9912754           -0.9912754            -0.9958537
        6            -0.9960147            -0.9930906        -0.9952490           -0.9952490            -0.9954243
        tBodyGyroMag.std.. tBodyGyroJerkMag.std.. fBodyAcc.std...X fBodyAcc.std...Y fBodyAcc.std...Z fBodyAccJerk.std...X
        1         -0.9643352             -0.9913676       -0.9954217       -0.9831330       -0.9061650           -0.9958207
        2         -0.9837542             -0.9961016       -0.9986803       -0.9749298       -0.9554381           -0.9966523
        3         -0.9860515             -0.9950910       -0.9963128       -0.9655059       -0.9770493           -0.9912488
        4         -0.9873511             -0.9952666       -0.9963121       -0.9832444       -0.9902291           -0.9913783
        5         -0.9890626             -0.9952580       -0.9986065       -0.9801295       -0.9919150           -0.9969025
        6         -0.9864403             -0.9952050       -0.9976438       -0.9922637       -0.9970459           -0.9952180
        fBodyAccJerk.std...Y fBodyAccJerk.std...Z fBodyGyro.std...X fBodyGyro.std...Y fBodyGyro.std...Z fBodyAccMag.std..
        1           -0.9909363           -0.9970517        -0.9850326        -0.9738861        -0.9940349        -0.9561340
        2           -0.9820839           -0.9926268        -0.9849043        -0.9871681        -0.9897847        -0.9758658
        3           -0.9814148           -0.9904159        -0.9766422        -0.9933990        -0.9873282        -0.9890155
        4           -0.9869269           -0.9943908        -0.9928104        -0.9916460        -0.9886776        -0.9867420
        5           -0.9886067           -0.9929065        -0.9859818        -0.9919558        -0.9879443        -0.9900635
        6           -0.9901788           -0.9930667        -0.9852871        -0.9916595        -0.9853661        -0.9952833
        fBodyBodyAccJerkMag.std.. fBodyBodyGyroMag.std.. fBodyBodyGyroJerkMag.std..
        1                -0.9937550             -0.9613094                 -0.9906975
        2                -0.9919603             -0.9833219                 -0.9963995
        3                -0.9908667             -0.9860277                 -0.9951274
        4                -0.9916998             -0.9878358                 -0.9952369
        5                -0.9943890             -0.9890594                 -0.9954648
        6                -0.9951562             -0.9858609                 -0.9952387
        > summary(TidyData)
        subject           code       tBodyAcc.mean...X tBodyAcc.mean...Y  tBodyAcc.mean...Z  tGravityAcc.mean...X
        Min.   : 1.00   Min.   :1.000   Min.   :-1.0000   Min.   :-1.00000   Min.   :-1.00000   Min.   :-1.0000     
        1st Qu.: 9.00   1st Qu.:2.000   1st Qu.: 0.2626   1st Qu.:-0.02490   1st Qu.:-0.12102   1st Qu.: 0.8117     
        Median :17.00   Median :4.000   Median : 0.2772   Median :-0.01716   Median :-0.10860   Median : 0.9218     
        Mean   :16.15   Mean   :3.625   Mean   : 0.2743   Mean   :-0.01774   Mean   :-0.10892   Mean   : 0.6692     
        3rd Qu.:24.00   3rd Qu.:5.000   3rd Qu.: 0.2884   3rd Qu.:-0.01062   3rd Qu.:-0.09759   3rd Qu.: 0.9547     
        Max.   :30.00   Max.   :6.000   Max.   : 1.0000   Max.   : 1.00000   Max.   : 1.00000   Max.   : 1.0000     
        tGravityAcc.mean...Y tGravityAcc.mean...Z tBodyAccJerk.mean...X tBodyAccJerk.mean...Y tBodyAccJerk.mean...Z
        Min.   :-1.000000    Min.   :-1.00000     Min.   :-1.00000      Min.   :-1.000000     Min.   :-1.000000    
        1st Qu.:-0.242943    1st Qu.:-0.11671     1st Qu.: 0.06298      1st Qu.:-0.018555     1st Qu.:-0.031552    
        Median :-0.143551    Median : 0.03680     Median : 0.07597      Median : 0.010753     Median :-0.001159    
        Mean   : 0.004039    Mean   : 0.09215     Mean   : 0.07894      Mean   : 0.007948     Mean   :-0.004675    
        3rd Qu.: 0.118905    3rd Qu.: 0.21621     3rd Qu.: 0.09131      3rd Qu.: 0.033538     3rd Qu.: 0.024578    
        Max.   : 1.000000    Max.   : 1.00000     Max.   : 1.00000      Max.   : 1.000000     Max.   : 1.000000    
        tBodyGyro.mean...X tBodyGyro.mean...Y tBodyGyro.mean...Z tBodyGyroJerk.mean...X tBodyGyroJerk.mean...Y
        Min.   :-1.00000   Min.   :-1.00000   Min.   :-1.00000   Min.   :-1.00000       Min.   :-1.00000      
        1st Qu.:-0.04579   1st Qu.:-0.10399   1st Qu.: 0.06485   1st Qu.:-0.11723       1st Qu.:-0.05868      
        Median :-0.02776   Median :-0.07477   Median : 0.08626   Median :-0.09824       Median :-0.04056      
        Mean   :-0.03098   Mean   :-0.07472   Mean   : 0.08836   Mean   :-0.09671       Mean   :-0.04232      
        3rd Qu.:-0.01058   3rd Qu.:-0.05110   3rd Qu.: 0.11044   3rd Qu.:-0.07930       3rd Qu.:-0.02521      
        Max.   : 1.00000   Max.   : 1.00000   Max.   : 1.00000   Max.   : 1.00000       Max.   : 1.00000      
        tBodyGyroJerk.mean...Z tBodyAccMag.mean.. tGravityAccMag.mean.. tBodyAccJerkMag.mean.. tBodyGyroMag.mean..
        Min.   :-1.00000       Min.   :-1.0000    Min.   :-1.0000       Min.   :-1.0000        Min.   :-1.0000    
        1st Qu.:-0.07936       1st Qu.:-0.9819    1st Qu.:-0.9819       1st Qu.:-0.9896        1st Qu.:-0.9781    
        Median :-0.05455       Median :-0.8746    Median :-0.8746       Median :-0.9481        Median :-0.8223    
        Mean   :-0.05483       Mean   :-0.5482    Mean   :-0.5482       Mean   :-0.6494        Mean   :-0.6052    
        3rd Qu.:-0.03168       3rd Qu.:-0.1201    3rd Qu.:-0.1201       3rd Qu.:-0.2956        3rd Qu.:-0.2454    
        Max.   : 1.00000       Max.   : 1.0000    Max.   : 1.0000       Max.   : 1.0000        Max.   : 1.0000    
        tBodyGyroJerkMag.mean.. fBodyAcc.mean...X fBodyAcc.mean...Y fBodyAcc.mean...Z fBodyAcc.meanFreq...X
        Min.   :-1.0000         Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.00000     
        1st Qu.:-0.9923         1st Qu.:-0.9913   1st Qu.:-0.9792   1st Qu.:-0.9832   1st Qu.:-0.41878     
        Median :-0.9559         Median :-0.9456   Median :-0.8643   Median :-0.8954   Median :-0.23825     
        Mean   :-0.7621         Mean   :-0.6228   Mean   :-0.5375   Mean   :-0.6650   Mean   :-0.22147     
        3rd Qu.:-0.5499         3rd Qu.:-0.2646   3rd Qu.:-0.1032   3rd Qu.:-0.3662   3rd Qu.:-0.02043     
        Max.   : 1.0000         Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.00000     
        fBodyAcc.meanFreq...Y fBodyAcc.meanFreq...Z fBodyAccJerk.mean...X fBodyAccJerk.mean...Y fBodyAccJerk.mean...Z
        Min.   :-1.000000     Min.   :-1.00000      Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000      
        1st Qu.:-0.144772     1st Qu.:-0.13845      1st Qu.:-0.9912       1st Qu.:-0.9848       1st Qu.:-0.9873      
        Median : 0.004666     Median : 0.06084      Median :-0.9516       Median :-0.9257       Median :-0.9475      
        Mean   : 0.015401     Mean   : 0.04731      Mean   :-0.6567       Mean   :-0.6290       Mean   :-0.7436      
        3rd Qu.: 0.176603     3rd Qu.: 0.24922      3rd Qu.:-0.3270       3rd Qu.:-0.2638       3rd Qu.:-0.5133      
        Max.   : 1.000000     Max.   : 1.00000      Max.   : 1.0000       Max.   : 1.0000       Max.   : 1.0000      
        fBodyAccJerk.meanFreq...X fBodyAccJerk.meanFreq...Y fBodyAccJerk.meanFreq...Z fBodyGyro.mean...X
        Min.   :-1.00000          Min.   :-1.000000         Min.   :-1.00000          Min.   :-1.0000   
        1st Qu.:-0.29770          1st Qu.:-0.427951         1st Qu.:-0.33139          1st Qu.:-0.9853   
        Median :-0.04544          Median :-0.236530         Median :-0.10246          Median :-0.8917   
        Mean   :-0.04771          Mean   :-0.213393         Mean   :-0.12383          Mean   :-0.6721   
        3rd Qu.: 0.20447          3rd Qu.: 0.008651         3rd Qu.: 0.09124          3rd Qu.:-0.3837   
        Max.   : 1.00000          Max.   : 1.000000         Max.   : 1.00000          Max.   : 1.0000   
        fBodyGyro.mean...Y fBodyGyro.mean...Z fBodyGyro.meanFreq...X fBodyGyro.meanFreq...Y fBodyGyro.meanFreq...Z
        Min.   :-1.0000    Min.   :-1.0000    Min.   :-1.00000       Min.   :-1.00000       Min.   :-1.00000      
        1st Qu.:-0.9847    1st Qu.:-0.9851    1st Qu.:-0.27189       1st Qu.:-0.36257       1st Qu.:-0.23240      
        Median :-0.9197    Median :-0.8877    Median :-0.09868       Median :-0.17298       Median :-0.05369      
        Mean   :-0.7062    Mean   :-0.6442    Mean   :-0.10104       Mean   :-0.17428       Mean   :-0.05139      
        3rd Qu.:-0.4735    3rd Qu.:-0.3225    3rd Qu.: 0.06810       3rd Qu.: 0.01366       3rd Qu.: 0.12251      
        Max.   : 1.0000    Max.   : 1.0000    Max.   : 1.00000       Max.   : 1.00000       Max.   : 1.00000      
        fBodyAccMag.mean.. fBodyAccMag.meanFreq.. fBodyBodyAccJerkMag.mean.. fBodyBodyAccJerkMag.meanFreq..
        Min.   :-1.0000    Min.   :-1.00000       Min.   :-1.0000            Min.   :-1.000000             
        1st Qu.:-0.9847    1st Qu.:-0.09663       1st Qu.:-0.9898            1st Qu.:-0.002959             
        Median :-0.8755    Median : 0.07026       Median :-0.9290            Median : 0.164180             
        Mean   :-0.5860    Mean   : 0.07688       Mean   :-0.6208            Mean   : 0.173220             
        3rd Qu.:-0.2173    3rd Qu.: 0.24495       3rd Qu.:-0.2600            3rd Qu.: 0.357307             
        Max.   : 1.0000    Max.   : 1.00000       Max.   : 1.0000            Max.   : 1.000000             
        fBodyBodyGyroMag.mean.. fBodyBodyGyroMag.meanFreq.. fBodyBodyGyroJerkMag.mean.. fBodyBodyGyroJerkMag.meanFreq..
        Min.   :-1.0000         Min.   :-1.00000            Min.   :-1.0000             Min.   :-1.00000               
        1st Qu.:-0.9825         1st Qu.:-0.23436            1st Qu.:-0.9921             1st Qu.:-0.01948               
        Median :-0.8756         Median :-0.05210            Median :-0.9453             Median : 0.13625               
        Mean   :-0.6974         Mean   :-0.04156            Mean   :-0.7798             Mean   : 0.12671               
        3rd Qu.:-0.4514         3rd Qu.: 0.15158            3rd Qu.:-0.6122             3rd Qu.: 0.28896               
        Max.   : 1.0000         Max.   : 1.00000            Max.   : 1.0000             Max.   : 1.00000               
        angle.tBodyAccMean.gravity. angle.tBodyAccJerkMean..gravityMean. angle.tBodyGyroMean.gravityMean.
        Min.   :-1.000000           Min.   :-1.000000                    Min.   :-1.00000                
        1st Qu.:-0.124694           1st Qu.:-0.287031                    1st Qu.:-0.49311                
        Median : 0.008146           Median : 0.007668                    Median : 0.01719                
        Mean   : 0.007705           Mean   : 0.002648                    Mean   : 0.01768                
        3rd Qu.: 0.149005           3rd Qu.: 0.291490                    3rd Qu.: 0.53614                
        Max.   : 1.000000           Max.   : 1.000000                    Max.   : 1.00000                
        angle.tBodyGyroJerkMean.gravityMean. angle.X.gravityMean. angle.Y.gravityMean. angle.Z.gravityMean.
        Min.   :-1.000000                    Min.   :-1.0000      Min.   :-1.000000    Min.   :-1.000000   
        1st Qu.:-0.389041                    1st Qu.:-0.8173      1st Qu.: 0.002151    1st Qu.:-0.131880   
        Median :-0.007186                    Median :-0.7156      Median : 0.182029    Median :-0.003882   
        Mean   :-0.009219                    Mean   :-0.4965      Mean   : 0.063255    Mean   :-0.054284   
        3rd Qu.: 0.365996                    3rd Qu.:-0.5215      3rd Qu.: 0.250790    3rd Qu.: 0.102970   
        Max.   : 1.000000                    Max.   : 1.0000      Max.   : 1.000000    Max.   : 1.000000   
        tBodyAcc.std...X  tBodyAcc.std...Y   tBodyAcc.std...Z  tGravityAcc.std...X tGravityAcc.std...Y tGravityAcc.std...Z
        Min.   :-1.0000   Min.   :-1.00000   Min.   :-1.0000   Min.   :-1.0000     Min.   :-1.0000     Min.   :-1.0000    
        1st Qu.:-0.9924   1st Qu.:-0.97699   1st Qu.:-0.9791   1st Qu.:-0.9949     1st Qu.:-0.9913     1st Qu.:-0.9866    
        Median :-0.9430   Median :-0.83503   Median :-0.8508   Median :-0.9819     Median :-0.9759     Median :-0.9665    
        Mean   :-0.6078   Mean   :-0.51019   Mean   :-0.6131   Mean   :-0.9652     Mean   :-0.9544     Mean   :-0.9389    
        3rd Qu.:-0.2503   3rd Qu.:-0.05734   3rd Qu.:-0.2787   3rd Qu.:-0.9615     3rd Qu.:-0.9464     3rd Qu.:-0.9296    
        Max.   : 1.0000   Max.   : 1.00000   Max.   : 1.0000   Max.   : 1.0000     Max.   : 1.0000     Max.   : 1.0000    
        tBodyAccJerk.std...X tBodyAccJerk.std...Y tBodyAccJerk.std...Z tBodyGyro.std...X tBodyGyro.std...Y
        Min.   :-1.0000      Min.   :-1.0000      Min.   :-1.0000      Min.   :-1.0000   Min.   :-1.0000  
        1st Qu.:-0.9913      1st Qu.:-0.9850      1st Qu.:-0.9892      1st Qu.:-0.9872   1st Qu.:-0.9819  
        Median :-0.9513      Median :-0.9250      Median :-0.9543      Median :-0.9016   Median :-0.9106  
        Mean   :-0.6398      Mean   :-0.6080      Mean   :-0.7628      Mean   :-0.7212   Mean   :-0.6827  
        3rd Qu.:-0.2912      3rd Qu.:-0.2218      3rd Qu.:-0.5485      3rd Qu.:-0.4822   3rd Qu.:-0.4461  
        Max.   : 1.0000      Max.   : 1.0000      Max.   : 1.0000      Max.   : 1.0000   Max.   : 1.0000  
        tBodyGyro.std...Z tBodyGyroJerk.std...X tBodyGyroJerk.std...Y tBodyGyroJerk.std...Z tBodyAccMag.std..
        Min.   :-1.0000   Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000  
        1st Qu.:-0.9850   1st Qu.:-0.9907       1st Qu.:-0.9922       1st Qu.:-0.9926       1st Qu.:-0.9822  
        Median :-0.8819   Median :-0.9348       Median :-0.9548       Median :-0.9503       Median :-0.8437  
        Mean   :-0.6537   Mean   :-0.7313       Mean   :-0.7861       Mean   :-0.7399       Mean   :-0.5912  
        3rd Qu.:-0.3379   3rd Qu.:-0.4865       3rd Qu.:-0.6268       3rd Qu.:-0.5097       3rd Qu.:-0.2423  
        Max.   : 1.0000   Max.   : 1.0000       Max.   : 1.0000       Max.   : 1.0000       Max.   : 1.0000  
        tGravityAccMag.std.. tBodyAccJerkMag.std.. tBodyGyroMag.std.. tBodyGyroJerkMag.std.. fBodyAcc.std...X 
        Min.   :-1.0000      Min.   :-1.0000       Min.   :-1.0000    Min.   :-1.0000        Min.   :-1.0000  
        1st Qu.:-0.9822      1st Qu.:-0.9907       1st Qu.:-0.9775    1st Qu.:-0.9922        1st Qu.:-0.9929  
        Median :-0.8437      Median :-0.9288       Median :-0.8259    Median :-0.9403        Median :-0.9416  
        Mean   :-0.5912      Mean   :-0.6278       Mean   :-0.6625    Mean   :-0.7780        Mean   :-0.6034  
        3rd Qu.:-0.2423      3rd Qu.:-0.2733       3rd Qu.:-0.3940    3rd Qu.:-0.6093        3rd Qu.:-0.2493  
        Max.   : 1.0000      Max.   : 1.0000       Max.   : 1.0000    Max.   : 1.0000        Max.   : 1.0000  
        fBodyAcc.std...Y   fBodyAcc.std...Z  fBodyAccJerk.std...X fBodyAccJerk.std...Y fBodyAccJerk.std...Z
        Min.   :-1.00000   Min.   :-1.0000   Min.   :-1.0000      Min.   :-1.0000      Min.   :-1.0000     
        1st Qu.:-0.97689   1st Qu.:-0.9780   1st Qu.:-0.9920      1st Qu.:-0.9865      1st Qu.:-0.9895     
        Median :-0.83261   Median :-0.8398   Median :-0.9562      Median :-0.9280      Median :-0.9590     
        Mean   :-0.52842   Mean   :-0.6179   Mean   :-0.6550      Mean   :-0.6122      Mean   :-0.7809     
        3rd Qu.:-0.09216   3rd Qu.:-0.3023   3rd Qu.:-0.3203      3rd Qu.:-0.2361      3rd Qu.:-0.5903     
        Max.   : 1.00000   Max.   : 1.0000   Max.   : 1.0000      Max.   : 1.0000      Max.   : 1.0000     
        fBodyGyro.std...X fBodyGyro.std...Y fBodyGyro.std...Z fBodyAccMag.std.. fBodyBodyAccJerkMag.std..
        Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000          
        1st Qu.:-0.9881   1st Qu.:-0.9808   1st Qu.:-0.9862   1st Qu.:-0.9829   1st Qu.:-0.9907          
        Median :-0.9053   Median :-0.9061   Median :-0.8915   Median :-0.8547   Median :-0.9255          
        Mean   :-0.7386   Mean   :-0.6742   Mean   :-0.6904   Mean   :-0.6595   Mean   :-0.6401          
        3rd Qu.:-0.5225   3rd Qu.:-0.4385   3rd Qu.:-0.4168   3rd Qu.:-0.3823   3rd Qu.:-0.3082          
        Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000          
        fBodyBodyGyroMag.std.. fBodyBodyGyroJerkMag.std..
        Min.   :-1.0000        Min.   :-1.0000           
        1st Qu.:-0.9781        1st Qu.:-0.9926           
        Median :-0.8275        Median :-0.9382           
        Mean   :-0.7000        Mean   :-0.7922           
        3rd Qu.:-0.4713        3rd Qu.:-0.6437           
        Max.   : 1.0000        Max.   : 1.0000           
        > 
          > # 3. Uses descriptive activity names to name the activities in the data set
          > TidyData$code <- activities[TidyData$code, 2]
        > 
          > 
          > # 4: Appropriately labels the data set with descriptive variable names
          > names(TidyData)[2] = "activity"
        > names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
        > names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
        > names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
        > names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
        > names(TidyData)<-gsub("^t", "Time", names(TidyData))
        > names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
        > names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
        > names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
        > names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
        > names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
        > names(TidyData)<-gsub("angle", "Angle", names(TidyData))
        > names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
        > 
          > # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for
          > #each activity and each subject.
          > 
          > FinalData <- TidyData %>%
          +   group_by(subject, activity) %>%
          +   summarise_all(funs(mean))
        > write.table(FinalData, "FinalData.txt", row.name=FALSE)
        > 
          > 
          > head(FinalData)
        # A tibble: 6 x 88
        # Groups:   subject [1]
        subject activity TimeBodyAcceler~ TimeBodyAcceler~ TimeBodyAcceler~ TimeGravityAcce~ TimeGravityAcce~
          <int> <fct>               <dbl>            <dbl>            <dbl>            <dbl>            <dbl>
          1       1 LAYING              0.222         -0.0405           -0.113            -0.249            0.706
        2       1 SITTING             0.261         -0.00131          -0.105             0.832            0.204
        3       1 STANDING            0.279         -0.0161           -0.111             0.943           -0.273
        4       1 WALKING             0.277         -0.0174           -0.111             0.935           -0.282
        5       1 WALKING~            0.289         -0.00992          -0.108             0.932           -0.267
        6       1 WALKING~            0.255         -0.0240           -0.0973            0.893           -0.362
        # ... with 81 more variables: TimeGravityAccelerometer.mean...Z <dbl>, TimeBodyAccelerometerJerk.mean...X <dbl>,
        #   TimeBodyAccelerometerJerk.mean...Y <dbl>, TimeBodyAccelerometerJerk.mean...Z <dbl>,
        #   TimeBodyGyroscope.mean...X <dbl>, TimeBodyGyroscope.mean...Y <dbl>, TimeBodyGyroscope.mean...Z <dbl>,
        #   TimeBodyGyroscopeJerk.mean...X <dbl>, TimeBodyGyroscopeJerk.mean...Y <dbl>,
        #   TimeBodyGyroscopeJerk.mean...Z <dbl>, TimeBodyAccelerometerMagnitude.mean.. <dbl>,
        #   TimeGravityAccelerometerMagnitude.mean.. <dbl>, TimeBodyAccelerometerJerkMagnitude.mean.. <dbl>,
        #   TimeBodyGyroscopeMagnitude.mean.. <dbl>, TimeBodyGyroscopeJerkMagnitude.mean.. <dbl>,
        #   FrequencyBodyAccelerometer.mean...X <dbl>, FrequencyBodyAccelerometer.mean...Y <dbl>,
        #   FrequencyBodyAccelerometer.mean...Z <dbl>, FrequencyBodyAccelerometer.meanFreq...X <dbl>,
        #   FrequencyBodyAccelerometer.meanFreq...Y <dbl>, FrequencyBodyAccelerometer.meanFreq...Z <dbl>,
        #   FrequencyBodyAccelerometerJerk.mean...X <dbl>, FrequencyBodyAccelerometerJerk.mean...Y <dbl>,
        #   FrequencyBodyAccelerometerJerk.mean...Z <dbl>, FrequencyBodyAccelerometerJerk.meanFreq...X <dbl>,
        #   FrequencyBodyAccelerometerJerk.meanFreq...Y <dbl>, FrequencyBodyAccelerometerJerk.meanFreq...Z <dbl>,
        #   FrequencyBodyGyroscope.mean...X <dbl>, FrequencyBodyGyroscope.mean...Y <dbl>,
        #   FrequencyBodyGyroscope.mean...Z <dbl>, FrequencyBodyGyroscope.meanFreq...X <dbl>,
        #   FrequencyBodyGyroscope.meanFreq...Y <dbl>, FrequencyBodyGyroscope.meanFreq...Z <dbl>,
        #   FrequencyBodyAccelerometerMagnitude.mean.. <dbl>, FrequencyBodyAccelerometerMagnitude.meanFreq.. <dbl>,
        #   FrequencyBodyAccelerometerJerkMagnitude.mean.. <dbl>, FrequencyBodyAccelerometerJerkMagnitude.meanFreq.. <dbl>,
        #   FrequencyBodyGyroscopeMagnitude.mean.. <dbl>, FrequencyBodyGyroscopeMagnitude.meanFreq.. <dbl>,
        #   FrequencyBodyGyroscopeJerkMagnitude.mean.. <dbl>, FrequencyBodyGyroscopeJerkMagnitude.meanFreq.. <dbl>,
        #   Angle.TimeBodyAccelerometerMean.Gravity. <dbl>, Angle.TimeBodyAccelerometerJerkMean..GravityMean. <dbl>,
        #   Angle.TimeBodyGyroscopeMean.GravityMean. <dbl>, Angle.TimeBodyGyroscopeJerkMean.GravityMean. <dbl>,
        #   Angle.X.GravityMean. <dbl>, Angle.Y.GravityMean. <dbl>, Angle.Z.GravityMean. <dbl>,
        #   TimeBodyAccelerometer.std...X <dbl>, TimeBodyAccelerometer.std...Y <dbl>, TimeBodyAccelerometer.std...Z <dbl>,
        #   TimeGravityAccelerometer.std...X <dbl>, TimeGravityAccelerometer.std...Y <dbl>,
        #   TimeGravityAccelerometer.std...Z <dbl>, TimeBodyAccelerometerJerk.std...X <dbl>,
        #   TimeBodyAccelerometerJerk.std...Y <dbl>, TimeBodyAccelerometerJerk.std...Z <dbl>,
        #   TimeBodyGyroscope.std...X <dbl>, TimeBodyGyroscope.std...Y <dbl>, TimeBodyGyroscope.std...Z <dbl>,
        #   TimeBodyGyroscopeJerk.std...X <dbl>, TimeBodyGyroscopeJerk.std...Y <dbl>, TimeBodyGyroscopeJerk.std...Z <dbl>,
        #   TimeBodyAccelerometerMagnitude.std.. <dbl>, TimeGravityAccelerometerMagnitude.std.. <dbl>,
        #   TimeBodyAccelerometerJerkMagnitude.std.. <dbl>, TimeBodyGyroscopeMagnitude.std.. <dbl>,
        #   TimeBodyGyroscopeJerkMagnitude.std.. <dbl>, FrequencyBodyAccelerometer.std...X <dbl>,
        #   FrequencyBodyAccelerometer.std...Y <dbl>, FrequencyBodyAccelerometer.std...Z <dbl>,
        #   FrequencyBodyAccelerometerJerk.std...X <dbl>, FrequencyBodyAccelerometerJerk.std...Y <dbl>,
        #   FrequencyBodyAccelerometerJerk.std...Z <dbl>, FrequencyBodyGyroscope.std...X <dbl>,
        #   FrequencyBodyGyroscope.std...Y <dbl>, FrequencyBodyGyroscope.std...Z <dbl>,
        #   FrequencyBodyAccelerometerMagnitude.std.. <dbl>, FrequencyBodyAccelerometerJerkMagnitude.std.. <dbl>,
        #   FrequencyBodyGyroscopeMagnitude.std.. <dbl>, FrequencyBodyGyroscopeJerkMagnitude.std.. <dbl>
        > tail(FinalData)
        # A tibble: 6 x 88
        # Groups:   subject [1]
        subject activity TimeBodyAcceler~ TimeBodyAcceler~ TimeBodyAcceler~ TimeGravityAcce~ TimeGravityAcce~
          <int> <fct>               <dbl>            <dbl>            <dbl>            <dbl>            <dbl>
          1      30 LAYING              0.281         -0.0194           -0.104            -0.345            0.733
        2      30 SITTING             0.268         -0.00805          -0.0995            0.825            0.115
        3      30 STANDING            0.277         -0.0170           -0.109             0.969           -0.100
        4      30 WALKING             0.276         -0.0176           -0.0986            0.965           -0.158
        5      30 WALKING~            0.283         -0.0174           -0.1000            0.958           -0.127
        6      30 WALKING~            0.271         -0.0253           -0.125             0.932           -0.227
        # ... with 81 more variables: TimeGravityAccelerometer.mean...Z <dbl>, TimeBodyAccelerometerJerk.mean...X <dbl>,
        #   TimeBodyAccelerometerJerk.mean...Y <dbl>, TimeBodyAccelerometerJerk.mean...Z <dbl>,
        #   TimeBodyGyroscope.mean...X <dbl>, TimeBodyGyroscope.mean...Y <dbl>, TimeBodyGyroscope.mean...Z <dbl>,
        #   TimeBodyGyroscopeJerk.mean...X <dbl>, TimeBodyGyroscopeJerk.mean...Y <dbl>,
        #   TimeBodyGyroscopeJerk.mean...Z <dbl>, TimeBodyAccelerometerMagnitude.mean.. <dbl>,
        #   TimeGravityAccelerometerMagnitude.mean.. <dbl>, TimeBodyAccelerometerJerkMagnitude.mean.. <dbl>,
        #   TimeBodyGyroscopeMagnitude.mean.. <dbl>, TimeBodyGyroscopeJerkMagnitude.mean.. <dbl>,
        #   FrequencyBodyAccelerometer.mean...X <dbl>, FrequencyBodyAccelerometer.mean...Y <dbl>,
        #   FrequencyBodyAccelerometer.mean...Z <dbl>, FrequencyBodyAccelerometer.meanFreq...X <dbl>,
        #   FrequencyBodyAccelerometer.meanFreq...Y <dbl>, FrequencyBodyAccelerometer.meanFreq...Z <dbl>,
        #   FrequencyBodyAccelerometerJerk.mean...X <dbl>, FrequencyBodyAccelerometerJerk.mean...Y <dbl>,
        #   FrequencyBodyAccelerometerJerk.mean...Z <dbl>, FrequencyBodyAccelerometerJerk.meanFreq...X <dbl>,
        #   FrequencyBodyAccelerometerJerk.meanFreq...Y <dbl>, FrequencyBodyAccelerometerJerk.meanFreq...Z <dbl>,
        #   FrequencyBodyGyroscope.mean...X <dbl>, FrequencyBodyGyroscope.mean...Y <dbl>,
        #   FrequencyBodyGyroscope.mean...Z <dbl>, FrequencyBodyGyroscope.meanFreq...X <dbl>,
        #   FrequencyBodyGyroscope.meanFreq...Y <dbl>, FrequencyBodyGyroscope.meanFreq...Z <dbl>,
        #   FrequencyBodyAccelerometerMagnitude.mean.. <dbl>, FrequencyBodyAccelerometerMagnitude.meanFreq.. <dbl>,
        #   FrequencyBodyAccelerometerJerkMagnitude.mean.. <dbl>, FrequencyBodyAccelerometerJerkMagnitude.meanFreq.. <dbl>,
        #   FrequencyBodyGyroscopeMagnitude.mean.. <dbl>, FrequencyBodyGyroscopeMagnitude.meanFreq.. <dbl>,
        #   FrequencyBodyGyroscopeJerkMagnitude.mean.. <dbl>, FrequencyBodyGyroscopeJerkMagnitude.meanFreq.. <dbl>,
        #   Angle.TimeBodyAccelerometerMean.Gravity. <dbl>, Angle.TimeBodyAccelerometerJerkMean..GravityMean. <dbl>,
        #   Angle.TimeBodyGyroscopeMean.GravityMean. <dbl>, Angle.TimeBodyGyroscopeJerkMean.GravityMean. <dbl>,
        #   Angle.X.GravityMean. <dbl>, Angle.Y.GravityMean. <dbl>, Angle.Z.GravityMean. <dbl>,
        #   TimeBodyAccelerometer.std...X <dbl>, TimeBodyAccelerometer.std...Y <dbl>, TimeBodyAccelerometer.std...Z <dbl>,
        #   TimeGravityAccelerometer.std...X <dbl>, TimeGravityAccelerometer.std...Y <dbl>,
        #   TimeGravityAccelerometer.std...Z <dbl>, TimeBodyAccelerometerJerk.std...X <dbl>,
        #   TimeBodyAccelerometerJerk.std...Y <dbl>, TimeBodyAccelerometerJerk.std...Z <dbl>,
        #   TimeBodyGyroscope.std...X <dbl>, TimeBodyGyroscope.std...Y <dbl>, TimeBodyGyroscope.std...Z <dbl>,
        #   TimeBodyGyroscopeJerk.std...X <dbl>, TimeBodyGyroscopeJerk.std...Y <dbl>, TimeBodyGyroscopeJerk.std...Z <dbl>,
        #   TimeBodyAccelerometerMagnitude.std.. <dbl>, TimeGravityAccelerometerMagnitude.std.. <dbl>,
        #   TimeBodyAccelerometerJerkMagnitude.std.. <dbl>, TimeBodyGyroscopeMagnitude.std.. <dbl>,
        #   TimeBodyGyroscopeJerkMagnitude.std.. <dbl>, FrequencyBodyAccelerometer.std...X <dbl>,
        #   FrequencyBodyAccelerometer.std...Y <dbl>, FrequencyBodyAccelerometer.std...Z <dbl>,
        #   FrequencyBodyAccelerometerJerk.std...X <dbl>, FrequencyBodyAccelerometerJerk.std...Y <dbl>,
        #   FrequencyBodyAccelerometerJerk.std...Z <dbl>, FrequencyBodyGyroscope.std...X <dbl>,
        #   FrequencyBodyGyroscope.std...Y <dbl>, FrequencyBodyGyroscope.std...Z <dbl>,
        #   FrequencyBodyAccelerometerMagnitude.std.. <dbl>, FrequencyBodyAccelerometerJerkMagnitude.std.. <dbl>,
        #   FrequencyBodyGyroscopeMagnitude.std.. <dbl>, FrequencyBodyGyroscopeJerkMagnitude.std.. <dbl>
        > summary.data.frame(FinalData)
        subject                   activity  TimeBodyAccelerometer.mean...X TimeBodyAccelerometer.mean...Y
        Min.   : 1.0   LAYING            :30   Min.   :0.2216                 Min.   :-0.040514             
        1st Qu.: 8.0   SITTING           :30   1st Qu.:0.2712                 1st Qu.:-0.020022             
        Median :15.5   STANDING          :30   Median :0.2770                 Median :-0.017262             
        Mean   :15.5   WALKING           :30   Mean   :0.2743                 Mean   :-0.017876             
        3rd Qu.:23.0   WALKING_DOWNSTAIRS:30   3rd Qu.:0.2800                 3rd Qu.:-0.014936             
        Max.   :30.0   WALKING_UPSTAIRS  :30   Max.   :0.3015                 Max.   :-0.001308             
        TimeBodyAccelerometer.mean...Z TimeGravityAccelerometer.mean...X TimeGravityAccelerometer.mean...Y
        Min.   :-0.15251               Min.   :-0.6800                   Min.   :-0.47989                 
        1st Qu.:-0.11207               1st Qu.: 0.8376                   1st Qu.:-0.23319                 
        Median :-0.10819               Median : 0.9208                   Median :-0.12782                 
        Mean   :-0.10916               Mean   : 0.6975                   Mean   :-0.01621                 
        3rd Qu.:-0.10443               3rd Qu.: 0.9425                   3rd Qu.: 0.08773                 
        Max.   :-0.07538               Max.   : 0.9745                   Max.   : 0.95659                 
        TimeGravityAccelerometer.mean...Z TimeBodyAccelerometerJerk.mean...X TimeBodyAccelerometerJerk.mean...Y
        Min.   :-0.49509                  Min.   :0.04269                    Min.   :-0.0386872                
        1st Qu.:-0.11726                  1st Qu.:0.07396                    1st Qu.: 0.0004664                
        Median : 0.02384                  Median :0.07640                    Median : 0.0094698                
        Mean   : 0.07413                  Mean   :0.07947                    Mean   : 0.0075652                
        3rd Qu.: 0.14946                  3rd Qu.:0.08330                    3rd Qu.: 0.0134008                
        Max.   : 0.95787                  Max.   :0.13019                    Max.   : 0.0568186                
        TimeBodyAccelerometerJerk.mean...Z TimeBodyGyroscope.mean...X TimeBodyGyroscope.mean...Y
        Min.   :-0.067458                  Min.   :-0.20578           Min.   :-0.20421          
        1st Qu.:-0.010601                  1st Qu.:-0.04712           1st Qu.:-0.08955          
        Median :-0.003861                  Median :-0.02871           Median :-0.07318          
        Mean   :-0.004953                  Mean   :-0.03244           Mean   :-0.07426          
        3rd Qu.: 0.001958                  3rd Qu.:-0.01676           3rd Qu.:-0.06113          
        Max.   : 0.038053                  Max.   : 0.19270           Max.   : 0.02747          
        TimeBodyGyroscope.mean...Z TimeBodyGyroscopeJerk.mean...X TimeBodyGyroscopeJerk.mean...Y
        Min.   :-0.07245           Min.   :-0.15721               Min.   :-0.07681              
        1st Qu.: 0.07475           1st Qu.:-0.10322               1st Qu.:-0.04552              
        Median : 0.08512           Median :-0.09868               Median :-0.04112              
        Mean   : 0.08744           Mean   :-0.09606               Mean   :-0.04269              
        3rd Qu.: 0.10177           3rd Qu.:-0.09110               3rd Qu.:-0.03842              
        Max.   : 0.17910           Max.   :-0.02209               Max.   :-0.01320              
        TimeBodyGyroscopeJerk.mean...Z TimeBodyAccelerometerMagnitude.mean.. TimeGravityAccelerometerMagnitude.mean..
        Min.   :-0.092500              Min.   :-0.9865                       Min.   :-0.9865                         
        1st Qu.:-0.061725              1st Qu.:-0.9573                       1st Qu.:-0.9573                         
        Median :-0.053430              Median :-0.4829                       Median :-0.4829                         
        Mean   :-0.054802              Mean   :-0.4973                       Mean   :-0.4973                         
        3rd Qu.:-0.048985              3rd Qu.:-0.0919                       3rd Qu.:-0.0919                         
        Max.   :-0.006941              Max.   : 0.6446                       Max.   : 0.6446                         
        TimeBodyAccelerometerJerkMagnitude.mean.. TimeBodyGyroscopeMagnitude.mean.. TimeBodyGyroscopeJerkMagnitude.mean..
        Min.   :-0.9928                           Min.   :-0.9807                   Min.   :-0.99732                     
        1st Qu.:-0.9807                           1st Qu.:-0.9461                   1st Qu.:-0.98515                     
        Median :-0.8168                           Median :-0.6551                   Median :-0.86479                     
        Mean   :-0.6079                           Mean   :-0.5652                   Mean   :-0.73637                     
        3rd Qu.:-0.2456                           3rd Qu.:-0.2159                   3rd Qu.:-0.51186                     
        Max.   : 0.4345                           Max.   : 0.4180                   Max.   : 0.08758                     
        FrequencyBodyAccelerometer.mean...X FrequencyBodyAccelerometer.mean...Y FrequencyBodyAccelerometer.mean...Z
        Min.   :-0.9952                     Min.   :-0.98903                    Min.   :-0.9895                    
        1st Qu.:-0.9787                     1st Qu.:-0.95361                    1st Qu.:-0.9619                    
        Median :-0.7691                     Median :-0.59498                    Median :-0.7236                    
        Mean   :-0.5758                     Mean   :-0.48873                    Mean   :-0.6297                    
        3rd Qu.:-0.2174                     3rd Qu.:-0.06341                    3rd Qu.:-0.3183                    
        Max.   : 0.5370                     Max.   : 0.52419                    Max.   : 0.2807                    
        FrequencyBodyAccelerometer.meanFreq...X FrequencyBodyAccelerometer.meanFreq...Y
        Min.   :-0.63591                        Min.   :-0.379518                      
        1st Qu.:-0.39165                        1st Qu.:-0.081314                      
        Median :-0.25731                        Median : 0.007855                      
        Mean   :-0.23227                        Mean   : 0.011529                      
        3rd Qu.:-0.06105                        3rd Qu.: 0.086281                      
        Max.   : 0.15912                        Max.   : 0.466528                      
        FrequencyBodyAccelerometer.meanFreq...Z FrequencyBodyAccelerometerJerk.mean...X
        Min.   :-0.52011                        Min.   :-0.9946                        
        1st Qu.:-0.03629                        1st Qu.:-0.9828                        
        Median : 0.06582                        Median :-0.8126                        
        Mean   : 0.04372                        Mean   :-0.6139                        
        3rd Qu.: 0.17542                        3rd Qu.:-0.2820                        
        Max.   : 0.40253                        Max.   : 0.4743                        
        FrequencyBodyAccelerometerJerk.mean...Y FrequencyBodyAccelerometerJerk.mean...Z
        Min.   :-0.9894                         Min.   :-0.9920                        
        1st Qu.:-0.9725                         1st Qu.:-0.9796                        
        Median :-0.7817                         Median :-0.8707                        
        Mean   :-0.5882                         Mean   :-0.7144                        
        3rd Qu.:-0.1963                         3rd Qu.:-0.4697                        
        Max.   : 0.2767                         Max.   : 0.1578                        
        FrequencyBodyAccelerometerJerk.meanFreq...X FrequencyBodyAccelerometerJerk.meanFreq...Y
        Min.   :-0.57604                            Min.   :-0.60197                           
        1st Qu.:-0.28966                            1st Qu.:-0.39751                           
        Median :-0.06091                            Median :-0.23209                           
        Mean   :-0.06910                            Mean   :-0.22810                           
        3rd Qu.: 0.17660                            3rd Qu.:-0.04721                           
        Max.   : 0.33145                            Max.   : 0.19568                           
        FrequencyBodyAccelerometerJerk.meanFreq...Z FrequencyBodyGyroscope.mean...X FrequencyBodyGyroscope.mean...Y
        Min.   :-0.62756                            Min.   :-0.9931                 Min.   :-0.9940                
        1st Qu.:-0.30867                            1st Qu.:-0.9697                 1st Qu.:-0.9700                
        Median :-0.09187                            Median :-0.7300                 Median :-0.8141                
        Mean   :-0.13760                            Mean   :-0.6367                 Mean   :-0.6767                
        3rd Qu.: 0.03858                            3rd Qu.:-0.3387                 3rd Qu.:-0.4458                
        Max.   : 0.23011                            Max.   : 0.4750                 Max.   : 0.3288                
        FrequencyBodyGyroscope.mean...Z FrequencyBodyGyroscope.meanFreq...X FrequencyBodyGyroscope.meanFreq...Y
        Min.   :-0.9860                 Min.   :-0.395770                   Min.   :-0.66681                   
        1st Qu.:-0.9624                 1st Qu.:-0.213363                   1st Qu.:-0.29433                   
        Median :-0.7909                 Median :-0.115527                   Median :-0.15794                   
        Mean   :-0.6044                 Mean   :-0.104551                   Mean   :-0.16741                   
        3rd Qu.:-0.2635                 3rd Qu.: 0.002655                   3rd Qu.:-0.04269                   
        Max.   : 0.4924                 Max.   : 0.249209                   Max.   : 0.27314                   
        FrequencyBodyGyroscope.meanFreq...Z FrequencyBodyAccelerometerMagnitude.mean..
        Min.   :-0.50749                    Min.   :-0.9868                           
        1st Qu.:-0.15481                    1st Qu.:-0.9560                           
        Median :-0.05081                    Median :-0.6703                           
        Mean   :-0.05718                    Mean   :-0.5365                           
        3rd Qu.: 0.04152                    3rd Qu.:-0.1622                           
        Max.   : 0.37707                    Max.   : 0.5866                           
        FrequencyBodyAccelerometerMagnitude.meanFreq.. FrequencyBodyAccelerometerJerkMagnitude.mean..
        Min.   :-0.31234                               Min.   :-0.9940                               
        1st Qu.:-0.01475                               1st Qu.:-0.9770                               
        Median : 0.08132                               Median :-0.7940                               
        Mean   : 0.07613                               Mean   :-0.5756                               
        3rd Qu.: 0.17436                               3rd Qu.:-0.1872                               
        Max.   : 0.43585                               Max.   : 0.5384                               
        FrequencyBodyAccelerometerJerkMagnitude.meanFreq.. FrequencyBodyGyroscopeMagnitude.mean..
        Min.   :-0.12521                                   Min.   :-0.9865                       
        1st Qu.: 0.04527                                   1st Qu.:-0.9616                       
        Median : 0.17198                                   Median :-0.7657                       
        Mean   : 0.16255                                   Mean   :-0.6671                       
        3rd Qu.: 0.27593                                   3rd Qu.:-0.4087                       
        Max.   : 0.48809                                   Max.   : 0.2040                       
        FrequencyBodyGyroscopeMagnitude.meanFreq.. FrequencyBodyGyroscopeJerkMagnitude.mean..
        Min.   :-0.45664                           Min.   :-0.9976                           
        1st Qu.:-0.16951                           1st Qu.:-0.9813                           
        Median :-0.05352                           Median :-0.8779                           
        Mean   :-0.03603                           Mean   :-0.7564                           
        3rd Qu.: 0.08228                           3rd Qu.:-0.5831                           
        Max.   : 0.40952                           Max.   : 0.1466                           
        FrequencyBodyGyroscopeJerkMagnitude.meanFreq.. Angle.TimeBodyAccelerometerMean.Gravity.
        Min.   :-0.18292                               Min.   :-0.163043                       
        1st Qu.: 0.05423                               1st Qu.:-0.011012                       
        Median : 0.11156                               Median : 0.007878                       
        Mean   : 0.12592                               Mean   : 0.006556                       
        3rd Qu.: 0.20805                               3rd Qu.: 0.024393                       
        Max.   : 0.42630                               Max.   : 0.129154                       
        Angle.TimeBodyAccelerometerJerkMean..GravityMean. Angle.TimeBodyGyroscopeMean.GravityMean.
        Min.   :-0.1205540                                Min.   :-0.38931                        
        1st Qu.:-0.0211694                                1st Qu.:-0.01977                        
        Median : 0.0031358                                Median : 0.02087                        
        Mean   : 0.0006439                                Mean   : 0.02193                        
        3rd Qu.: 0.0220881                                3rd Qu.: 0.06460                        
        Max.   : 0.2032600                                Max.   : 0.44410                        
        Angle.TimeBodyGyroscopeJerkMean.GravityMean. Angle.X.GravityMean. Angle.Y.GravityMean. Angle.Z.GravityMean.
        Min.   :-0.22367                             Min.   :-0.9471      Min.   :-0.87457     Min.   :-0.873649   
        1st Qu.:-0.05613                             1st Qu.:-0.7907      1st Qu.: 0.02191     1st Qu.:-0.083912   
        Median :-0.01602                             Median :-0.7377      Median : 0.17136     Median : 0.005079   
        Mean   :-0.01137                             Mean   :-0.5243      Mean   : 0.07865     Mean   :-0.040436   
        3rd Qu.: 0.03200                             3rd Qu.:-0.5823      3rd Qu.: 0.24343     3rd Qu.: 0.106190   
        Max.   : 0.18238                             Max.   : 0.7378      Max.   : 0.42476     Max.   : 0.390444   
        TimeBodyAccelerometer.std...X TimeBodyAccelerometer.std...Y TimeBodyAccelerometer.std...Z
        Min.   :-0.9961               Min.   :-0.99024              Min.   :-0.9877              
        1st Qu.:-0.9799               1st Qu.:-0.94205              1st Qu.:-0.9498              
        Median :-0.7526               Median :-0.50897              Median :-0.6518              
        Mean   :-0.5577               Mean   :-0.46046              Mean   :-0.5756              
        3rd Qu.:-0.1984               3rd Qu.:-0.03077              3rd Qu.:-0.2306              
        Max.   : 0.6269               Max.   : 0.61694              Max.   : 0.6090              
        TimeGravityAccelerometer.std...X TimeGravityAccelerometer.std...Y TimeGravityAccelerometer.std...Z
        Min.   :-0.9968                  Min.   :-0.9942                  Min.   :-0.9910                 
        1st Qu.:-0.9825                  1st Qu.:-0.9711                  1st Qu.:-0.9605                 
        Median :-0.9695                  Median :-0.9590                  Median :-0.9450                 
        Mean   :-0.9638                  Mean   :-0.9524                  Mean   :-0.9364                 
        3rd Qu.:-0.9509                  3rd Qu.:-0.9370                  3rd Qu.:-0.9180                 
        Max.   :-0.8296                  Max.   :-0.6436                  Max.   :-0.6102                 
        TimeBodyAccelerometerJerk.std...X TimeBodyAccelerometerJerk.std...Y TimeBodyAccelerometerJerk.std...Z
        Min.   :-0.9946                   Min.   :-0.9895                   Min.   :-0.99329                 
        1st Qu.:-0.9832                   1st Qu.:-0.9724                   1st Qu.:-0.98266                 
        Median :-0.8104                   Median :-0.7756                   Median :-0.88366                 
        Mean   :-0.5949                   Mean   :-0.5654                   Mean   :-0.73596                 
        3rd Qu.:-0.2233                   3rd Qu.:-0.1483                   3rd Qu.:-0.51212                 
        Max.   : 0.5443                   Max.   : 0.3553                   Max.   : 0.03102                 
        TimeBodyGyroscope.std...X TimeBodyGyroscope.std...Y TimeBodyGyroscope.std...Z TimeBodyGyroscopeJerk.std...X
        Min.   :-0.9943           Min.   :-0.9942           Min.   :-0.9855           Min.   :-0.9965              
        1st Qu.:-0.9735           1st Qu.:-0.9629           1st Qu.:-0.9609           1st Qu.:-0.9800              
        Median :-0.7890           Median :-0.8017           Median :-0.8010           Median :-0.8396              
        Mean   :-0.6916           Mean   :-0.6533           Mean   :-0.6164           Mean   :-0.7036              
        3rd Qu.:-0.4414           3rd Qu.:-0.4196           3rd Qu.:-0.3106           3rd Qu.:-0.4629              
        Max.   : 0.2677           Max.   : 0.4765           Max.   : 0.5649           Max.   : 0.1791              
        TimeBodyGyroscopeJerk.std...Y TimeBodyGyroscopeJerk.std...Z TimeBodyAccelerometerMagnitude.std..
        Min.   :-0.9971               Min.   :-0.9954               Min.   :-0.9865                     
        1st Qu.:-0.9832               1st Qu.:-0.9848               1st Qu.:-0.9430                     
        Median :-0.8942               Median :-0.8610               Median :-0.6074                     
        Mean   :-0.7636               Mean   :-0.7096               Mean   :-0.5439                     
        3rd Qu.:-0.5861               3rd Qu.:-0.4741               3rd Qu.:-0.2090                     
        Max.   : 0.2959               Max.   : 0.1932               Max.   : 0.4284                     
        TimeGravityAccelerometerMagnitude.std.. TimeBodyAccelerometerJerkMagnitude.std.. TimeBodyGyroscopeMagnitude.std..
        Min.   :-0.9865                         Min.   :-0.9946                          Min.   :-0.9814                 
        1st Qu.:-0.9430                         1st Qu.:-0.9765                          1st Qu.:-0.9476                 
        Median :-0.6074                         Median :-0.8014                          Median :-0.7420                 
        Mean   :-0.5439                         Mean   :-0.5842                          Mean   :-0.6304                 
        3rd Qu.:-0.2090                         3rd Qu.:-0.2173                          3rd Qu.:-0.3602                 
        Max.   : 0.4284                         Max.   : 0.4506                          Max.   : 0.3000                 
        TimeBodyGyroscopeJerkMagnitude.std.. FrequencyBodyAccelerometer.std...X FrequencyBodyAccelerometer.std...Y
        Min.   :-0.9977                      Min.   :-0.9966                    Min.   :-0.99068                  
        1st Qu.:-0.9805                      1st Qu.:-0.9820                    1st Qu.:-0.94042                  
        Median :-0.8809                      Median :-0.7470                    Median :-0.51338                  
        Mean   :-0.7550                      Mean   :-0.5522                    Mean   :-0.48148                  
        3rd Qu.:-0.5767                      3rd Qu.:-0.1966                    3rd Qu.:-0.07913                  
        Max.   : 0.2502                      Max.   : 0.6585                    Max.   : 0.56019                  
        FrequencyBodyAccelerometer.std...Z FrequencyBodyAccelerometerJerk.std...X FrequencyBodyAccelerometerJerk.std...Y
        Min.   :-0.9872                    Min.   :-0.9951                        Min.   :-0.9905                       
        1st Qu.:-0.9459                    1st Qu.:-0.9847                        1st Qu.:-0.9737                       
        Median :-0.6441                    Median :-0.8254                        Median :-0.7852                       
        Mean   :-0.5824                    Mean   :-0.6121                        Mean   :-0.5707                       
        3rd Qu.:-0.2655                    3rd Qu.:-0.2475                        3rd Qu.:-0.1685                       
        Max.   : 0.6871                    Max.   : 0.4768                        Max.   : 0.3498                       
        FrequencyBodyAccelerometerJerk.std...Z FrequencyBodyGyroscope.std...X FrequencyBodyGyroscope.std...Y
        Min.   :-0.993108                      Min.   :-0.9947                Min.   :-0.9944               
        1st Qu.:-0.983747                      1st Qu.:-0.9750                1st Qu.:-0.9602               
        Median :-0.895121                      Median :-0.8086                Median :-0.7964               
        Mean   :-0.756489                      Mean   :-0.7110                Mean   :-0.6454               
        3rd Qu.:-0.543787                      3rd Qu.:-0.4813                3rd Qu.:-0.4154               
        Max.   :-0.006236                      Max.   : 0.1966                Max.   : 0.6462               
        FrequencyBodyGyroscope.std...Z FrequencyBodyAccelerometerMagnitude.std..
        Min.   :-0.9867                Min.   :-0.9876                          
        1st Qu.:-0.9643                1st Qu.:-0.9452                          
        Median :-0.8224                Median :-0.6513                          
        Mean   :-0.6577                Mean   :-0.6210                          
        3rd Qu.:-0.3916                3rd Qu.:-0.3654                          
        Max.   : 0.5225                Max.   : 0.1787                          
        FrequencyBodyAccelerometerJerkMagnitude.std.. FrequencyBodyGyroscopeMagnitude.std..
        Min.   :-0.9944                               Min.   :-0.9815                      
        1st Qu.:-0.9752                               1st Qu.:-0.9488                      
        Median :-0.8126                               Median :-0.7727                      
        Mean   :-0.5992                               Mean   :-0.6723                      
        3rd Qu.:-0.2668                               3rd Qu.:-0.4277                      
        Max.   : 0.3163                               Max.   : 0.2367                      
        FrequencyBodyGyroscopeJerkMagnitude.std..
        Min.   :-0.9976                          
        1st Qu.:-0.9802                          
        Median :-0.8941                          
        Mean   :-0.7715                          
        3rd Qu.:-0.6081                          
        Max.   : 0.2878                          
        > 