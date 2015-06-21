 Getting and cleaning data- Course Project
 =========================================
 
Script Explanation
------------------

The scripts first prepares the test set, then prepares the training set and then join them. 
The preaparation process of each set is the same for both sets: 

*  Read the data (test/X_test.txt or train/X_train.txt) and create a dataset testSet or trainSet
*  Each observaction of that dataset contains a vector  of measures of more than 500 indicators. We only keep those of mean and standard deviation.The number of te columns of that indicatores are allocated in the meanAndStdColumns vector. 
*  To name the variables of the dataset we get those names from the file features.txt, joining the number of the column with te correspondent name (will match the number of line in features.txt)
*  Then we read the activity number files in a vector called  testActivityLabels and trainActivityLabels respectivelly  from file y_test.txt  or y_train.txt
* Then we read the subject file /subject_test.txt or /subject_train.txt respectivelly to create a vector (testSubjects or trainSubjects) that allocates the subject (individual) of each observation. 
* We paste the columns of the trhee vectors or datasets (testSubjects,testActivityLabels,testSet) and cbind(trainSubjects,trainActivityLabels,trainSet) and allocates in testSet and trainSet respectivelly 
* We merge the 2 datasets (testSEt and trainSet ) in a new set:mergedSet
* To assign the correct name of each activity (testActivityLabels and trainActivityLabels are numbers until now) we create a data set containing the number of the activity and the correspondent name reading the file  "activity_labels.txt" and then we join that file with the mergedSet using the merge function  
* Finally we name the first two columns of the mergedset, activityLabel and subjectId and  we use the group_by and sumarize_each functions of the dplyr library to group the  merged dataset by  activity label and subjectID respectectivelly and then sumarrize the remaining columns using the mean summarization. 
* We write the dataset in a file (newDataSet.csv) using the write table function