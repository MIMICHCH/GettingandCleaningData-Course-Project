Introduction

The script run_analysis.R performs the following steps described in the course project's instruction.

-	First, training and test data are merged using the rbind() function. 

-	Second, Activity and Subject data are added as two additional columns to the above merged data using cbind() function. And columns names are set using given files.

-	And the Activity names are joined into the data set using activity_labels.txt 

-	And in addition all the column names are reset with more descriptive names

-	Third, only columns with the mean and standard deviation measurements, together with the Subject and Activity identifiers are subset from the whole dataset. 

-	Finally, we generate a new dataset with all the average measures for each subject and activity (30 subjects * 6 activities = 180 rows). The output file is called averages_data.txt, and uploaded to this repository.

Variables

-	ActivityLabel, ActivityValue_Test, ActivityValue_Train contain the activity related data such labels, values from test sample and training sample. Similarly for Feature and Subject. There are FeatureLabel, FeatureValue_Test, FeatureValue_Train and SubjectValue_Test, SubjectValue_Train.

-	Activity is the merged data of activity values from test folder and training folder with proper column names set. Same for Feature and Subject.

-	SubFeatureLabel contains all wanted feature names in order to extract only mean and standard deviation related measurements

-	Data merges Activity, Subject and Feature into one dataset.

-	Data2 contains an independent data set  with the mean of the selected features for each subject and activity
