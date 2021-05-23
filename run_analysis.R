A <- rbind(x_train, x_test)
B <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
MData <- cbind(Subject, B, A)
TidyD <- MData %>% select(subject, code, contains("mean"), contains("std"))
TidyD$code <- activities[TidyD$code, 2]
names(TidyD)[2] = "activity"
names(TidyD)<-gsub("Acc", "Accelerometer", names(TidyD))
names(TidyD)<-gsub("Gyro", "Gyroscope", names(TidyD))
names(TidyD)<-gsub("BodyBody", "Body", names(TidyD))
names(TidyD)<-gsub("Mag", "Magnitude", names(TidyD))
names(TidyD)<-gsub("^t", "Time", names(TidyD))
names(TidyD)<-gsub("^f", "Frequency", names(TidyD))
names(TidyD)<-gsub("tBody", "TimeBody", names(TidyD))
names(TidyD)<-gsub("-mean()", "Mean", names(TidyD), ignore.case = TRUE)
names(TidyD)<-gsub("-std()", "STD", names(TidyD), ignore.case = TRUE)
names(TidyD)<-gsub("-freq()", "Frequency", names(TidyD), ignore.case = TRUE)
names(TidyD)<-gsub("angle", "Angle", names(TidyD))
names(TidyD)<-gsub("gravity", "Gravity", names(TidyD))
FinalData <- TidyD %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)