### FILE DESCRIPTION

The run_analysis.R loads the original data from the Samsung Galaxy S smartphone from two different groups of data sets, 'train' and 'test' and combines it into a single data set and cleans up the data

The following files are requried and are loaded by the script with the file paths as listed in reference to the scipt run_analysis.R location

- 'features.txt'
- 'activity_labels.txt'
- 'test\X_test.txt'
- 'train\X_train.txt'
- 'test\Y_test.txt'
- 'train\Y_train.txt'
- 'test\subject_test.txt'
- 'train\subject_test.txt'

### CODE DESCRIPTION

The run_analysis.R performns the following functions:

- Loads the above 8 data sets into R. Creates a joint data set by combining all the 'train' and 'test' groups. 

-- 'jointData' contains the combined measurements from 'X_test.txt' and 'X_train.txt' data
-- 'jointAcc' contains the combined activities from 'Y_test.txt' and 'Y_train.txt' data
-- 'jointSubj' contains the combined subjects from 'subject_test.txt'and \subject_test.txt' data

- Adds column names to 'jointData'. The 561 columns names are in data set 'features.txt'

- Converts the activity numbers in 'jointAcc' to labels provided in 'activity_labels.txt'

- Creates a new data set called 'allData' which appends 2 columns 'jointSubj' and 'jointAcc' to the beginning of 'jointData'. The two new columns are labeled 'SubjectNum' and 'Activity'

- using 'allData' extracts all rows with features that contain the word '-mean()' and '-std()' and stores into a data frame 'meanStdData'

- splits 'allData' into lists with all measurements for a given user performing a particular activity. There are 180 suchs lists. The mean of all rows for each list is taken and stored into a new data frame called 'tidyData'

- Creates a character vector 'newNames' of length 180 with the user/activity combination, e.g. '1 Walking'. Appends this as first column to 'tidyData'

- Final 'tidayData' is a data frame with 180 rows and 562 columns. This data frame is written into a file 'tidyData.txt'.

 