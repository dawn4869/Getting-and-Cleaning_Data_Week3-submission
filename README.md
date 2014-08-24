Getting-and-Cleaning_Data_Week3-submission
==========================================

Submit for course project

This dataset contains 181 observations of 81 variables
The V1 to V79 is the average for each variable for each project and each subject
The last two columns are infomration about activity and subjects involved

To read the file can use
data<-read.table("data.submission.txt")

Following is the outline for data processing:

# Read all the files and get a clear idea of contents in each file---------------------------------------

# Make a dataset for all TEST data===================================================================
# Combine label and set------------------------------------------------------------------------------

# Only keep mean and std value for each measurement---------------------------------------------------

# Label activity number using activity name-------------------------------------------------------------

# Add subject information-------------------------------------------------------------------------------

# Creat a new vector labeling as "test"-----------------------------------------------------------------

# Make a dataset for all TRAIN data=====================================================================
# Combine label and set------------------------------------------------------------------------------
# Only keep mean and std value for each measurement---------------------------------------------------
# Label activity number using activity name-------------------------------------------------------------
# Add subject information-------------------------------------------------------------------------------
# Creat a new vector labeling as "test"-----------------------------------------------------------------

# Combine 2 datasets========================================================================================
# Generate the second data set, hence, calculate the average value for each variable for each activity and each subject==========
# Calculate the average of each variable for each subject-------------------------------------------------

# Write a table======================================================================================
write.table(data.cleaned,file="data.submission.txt",row.names=FALSE)
