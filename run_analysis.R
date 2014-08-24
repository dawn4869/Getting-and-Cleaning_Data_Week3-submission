
# Read all the files and get a clear idea of contents in each file---------------------------------------
features<-read.table("features.txt")

activity_labels<-read.table("activity_labels.txt")

subject.test<-read.table("./test/subject_test.txt")

subject.train<-read.table("./train/subject_test.txt")

label.test<-read.table("./test/x_test.txt")

label.test<-read.table("./test/y_test.txt")
label.train<-read.table("./train/y_train.txt")
set.test<-read.table("./test/x_test.txt")
set.train<-read.table("./test/x_train.txt")

# Make a dataset for all test data===================================================================
# Combine label and set------------------------------------------------------------------------------
label.set.test<-cbind(label.test,set.test)
names(label.set.test)<-c("Activity",as.character(features$V2))

# Only keep mean and std value for each measurement---------------------------------------------------
select.mean.test<-grep("mean",names(label.set.test))
select.std.test<-grep("std",names(label.set.test))
select.vector.test.<-c(select.mean.test,select.std.test)
select.vector.test<-c(1,select.vector.test)
test.select.test<-label.set.test[,select.vector.test]

# Label activity number using activity name-------------------------------------------------------------
activity.factor.test<-activity_labels$V2
test.select$Activity<-as.factor(test.select$Activity)
levels(test.select$Activity)<-levels(activity.factor.test)

# Add subject information-------------------------------------------------------------------------------
names(subject.test)<-c("Subject")
test.final<-cbind(subject.test,test.select)

# Creat a new vector labeling as "test"-----------------------------------------------------------------
test.final$test.or.train<-rep(c("test"),each=2947)


# Make a dataset for all TRAIN data=====================================================================
# Combine label and set------------------------------------------------------------------------------
label.set.train<-cbind(label.train,set.train)
names(label.set.train)<-c("Activity",as.character(features$V2))

# Only keep mean and std value for each measurement---------------------------------------------------
select.mean.train<-grep("mean",names(label.set.train))
select.std.train<-grep("std",names(label.set.train))
select.vector.train<-c(select.mean,select.std)
select.vector.train<-c(1,select.vector.train)
train.select<-label.set.train[,select.vector.train]

# Label activity number using activity name-------------------------------------------------------------
activity.factor.train<-activity_labels$V2
train.select$Activity<-as.factor(train.select$Activity)
levels(train.select$Activity)<-levels(activity.factor.train)

# Add subject information-------------------------------------------------------------------------------
names(subject.train)<-c("Subject")
train.final<-cbind(subject.train,train.select)

# Creat a new vector labeling as "test"-----------------------------------------------------------------
train.final$test.or.train<-rep(c("train"),each=7352)


# Combine 2 datasets========================================================================================
data.final<-rbind(test.final,train.final)

# Generate the second data set, hence, calculate the average value for each variable for each activity and each subject==========
# Calculate the average of each variable for each subject-------------------------------------------------
data.by.activity<-split(data.final,data.final$Activity)

for (i in names(data.by.activity)){
        activity.by.subject<-split(data.by.activity,data.by.activity$i$Subject)
        sapply(activity.by.subject,calculate.mean)
}

input<-data.frame()
value.mean<-c()
calculate.mean<-function(input){
        for(i in 3:81){
                
                   value.mean<-cbind(value.mean,mean(input[,i]))
        }
        return(value.mean)
}

walking.by.subject<-split(data.by.activity$WALKING,data.by.activity$WALKING$Subject)
walking.upstairs.by.subject<-split(data.by.activity$WALKING_UPSTAIRS,data.by.activity$WALKING_UPSTAIRS$Subject)
walking.downstrais.by.subject<-split(data.by.activity$WALKING_DOWNSTAIRS,data.by.activity$WALKING_DOWNSTAIRS$Subject)
sitting.by.subject<-split(data.by.activity$SITTING,data.by.activity$SITTING$Subject)
standing.by.subject<-split(data.by.activity$STANDING,data.by.activity$STANDING$Subject)
laying.by.subject<-split(data.by.activity$LAYING,data.by.activity$LAYING$Subject)


walking.summary<-t(sapply(walking.by.subject,calculate.mean))
walking.upstairs.summary<-t(sapply(walking.upstairs.by.subject,calculate.mean))
walking.downstairs.summary<-t(sapply(walking.downstrais.by.subject,calculate.mean))
sitting.summary<-t(sapply(sitting.by.subject,calculate.mean))
standing.summary<-t(sapply(standing.by.subject,calculate.mean))
laying.summary<-t(sapply(laying.by.subject,calculate.mean))


data<-rbind(walking.summary,walking.upstairs.summary)
data<-rbind(data,walking.downstairs.summary)
data<-rbind(data,sitting.summary)
data<-rbind(data,standing.summary)
data<-rbind(data,laying.summary)

data.cleaned<-as.data.frame(data)
names(data)<-names(data.final)[3:81]
data.cleaned$activity<-rep(c("walking","walking upstairs","walking downstairs","sitting","standing","laying"),each=30)
data.cleaned$Subject<-rep(1:30,6)

# Write a table======================================================================================
write.table(data.cleaned,file="data.submission.txt",row.names=FALSE)
