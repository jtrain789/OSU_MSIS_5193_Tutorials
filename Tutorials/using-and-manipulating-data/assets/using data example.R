###########################################
#============Read in Libraries============#
# Read in the necessary libraries. Note,	#
# the commented code for installing		#
# packages. Remove the "#" and run the	#
# script to install them. You must be	#
# connected to the internet to download	#
# them.						#
###########################################

#### Lines of code to install various packages
#install.packages('installr')		#Updates R; run library(installr) then updateR()
#install.packages("psych")		#Perform descriptive statistics
#install.packages("tidyverse")		#For advanced figures, plots, charts
#install.packages("Hmisc")		#Provides correlation matrix with significance values
#install.packages("RODBC")		#Provides an ODBC interface for R

#library(foreign)
#library(ggplot2)


#######################################################
#=============Setup the Working Directory=============#
#Set the working directory to the project folder by 	#
#running the appropriate script below. Note, you can 	#
#run the data off of your OneDrive or DropBox.		    #
#######################################################

setwd("C:\\Users\\bryan\\source\\repos\\msis5193-pds1-master\\using-and-manipulating-data\\data")

#### Below is alternate code to set the working directory
workingdirectory = "C:\Users\bryan\source\repos\msis5193-pds1-master\using-and-manipulating-data\data"
acct_dir = "C:\\Users\\bryan\\AccountingData"
mark_dir = "C:\\MarketingData"
setwd(workingdirectory)


###########################################
#==============Read in data===============#
#Read in the data for both data sets.	#
###########################################

#### Warning! Do not leave blank spaces in column headers!
#### Use an underscore "_" or a period "." to fill the space

#Check if a file exists prior to attempting to open it
file.exists("C:\\Users\\bryan\\source\\repos\\msis5193-pds1-master\\using-and-manipulating-data\\data\\ozone.data.txt")

#### This loads the Ozone data
#### sep="" represents the separator; this one is white space which
#### includes \t (tab), \n (newline), or \r (carriage returns)
#### If you are using a csv file, use read.csv() instead
ozone_data = read.table("C:\\Users\\bryan\\source\\repos\\msis5193-pds1-master\\using-and-manipulating-data\\data\\ozone.data.txt", header=T, sep="\t")

#### Car data
car_data = read.table("C:\\Users\\bryan\\source\\repos\\msis5193-pds1-master\\using-and-manipulating-data\\data\\car.test.frame.txt", header=T, sep="\t")

#You can also browse for the file:
data = read.table(file.choose(),header=T)

#To view the data itself, you can also type
ozone_data

#Or, use this function to open a GUI to edit the table
#This is cleaner and doesn't clutter up the console
ozone_data2 = edit(ozone_data)

#Ensure the names are correct
names(ozone_data)

summary(ozone_data)			#Basic summary
str(ozone_data)				#Look at structure of data (i.e. datatypes)

#### I usually don't use this function in R
attach(ozone_data)
detach(ozone_data)

#### This loads the seedlings data; it is tab-delimited
#### This uses an alternative method to reading in the data
#### from that above.
temptable = paste(workingdirectory, "\\seedlings.txt", sep="")
seedlings_data = read.table(temptable, header=T, sep="\t")

summary(seedlings_data)			#Notice how the summary for Cohort differs from the others
str(seedlings_data)			#Contains a categorical variable, integer, and numeric (i.e. decimal)

#### Load in student grade data
stdt_data = read.table("C:\\Users\\bryan\\source\\repos\\msis5193-pds1-master\\using-and-manipulating-data\\data\\class_performance.txt",sep="\t",header=T)


#################################################
#=========Working with Data (Indices)===========#
# Indices (or subscripts) are the specific cell	#
# within the dataframe. It looks like this:	#
# 	[1,2]							#
# where the 1 is Row 1 and 2 is Column 2.		#
#################################################

ncol(ozone_data)	#Number of columns
nrow(ozone_data)	#Number of rows

#Row 8, Column 1
ozone_data[8,1]

#Row 57, Column 4
ozone_data[57,4]

#What about a specific record?
#Leave the column value blank
ozone_data[57,]

#What if you want just some of the columns?
#Just the first three columns, for example:
ozone_data[57,1:3]
ozone_data[57,c(1,2,3)]
ozone_data[57,c("rad","temp","wind")]

#How about the last three?
#?????

#How about the entire Temperature column?
#?????

#Saving an entire column of data into a new dataframe:
rad.data1 = ozone_data[,1]
rad.data2 = ozone_data$rad

#Saving Radiation and Wind as a new dataframe:
rad.temp.data = ozone_data[,c(1,3)]
names(rad.temp.data)
edit(rad.temp.data)

#===================
# Sorting data
#===================

ozone_data[order(ozone_data$rad),]

ozone_data[rev(order(ozone_data$rad)),]

#Sort multiple columns
ozone_data[order(ozone_data$rad,ozone_data$temp),]

#Sort multiple columns with only those columns
ozone_data[order(ozone_data$rad,ozone_data$temp),c(1,2)]

#Alternative for previous sort:
ozone_data[order(ozone_data$rad,ozone_data$temp),c("rad","temp")]

#=================
# Remove columns
#=================

ozone_datasmall = subset(ozone_data, select=-c(rad,temp))

#====================================
# Subsampling from a dataframe
# Select 60% of the data at random
#====================================

#Determine how many rows is 60%
split.num = round(nrow(ozone_data)*.60,0)

#Found out how many rows are in the dataframe
nrow(ozone_data)

#Range of data to sample
x = 1:111	

#Perform splitting
ozone_data.split = ozone_data[sample(x,split.num,replace=F),]

nrow(ozone_data.split)

#================================
# Subsampling from a dataframe
# Perform a simple bootstrap
#================================

ozone_data.bootstrap = ozone_data[sample(x, replace=T),]

nrow(ozone_data.bootstrap)

#Save the newly created bootstrap data
write.table(ozone_data.bootstrap,file="ozone_data_bootstrap.txt",sep="\t",row.names=FALSE,qmethod="escape")

#================================
# Subsampling from a dataframe
# Training, Testing, Validation
#================================

#### Create training, testing, validation data
#### Use the car data
temptable = paste(workingdirectory, "\\car.test.frame.txt", sep="")
car_data = read.table(temptable, header=T, sep="\t")

#### Set the percentages of your subsets
train.size = 0.6
valid.size = 0.2
test.size = 0.2

#### Calculate the sample sizes
samp.train = floor(train.size * nrow(car_data))
samp.valid = floor(valid.size * nrow(car_data))
samp.test = floor(test.size * nrow(car_data))

#### Determine the indices each subset will have
#### 1) randomly select the indices for the training set
#### 2) determine the remaining indices not in the training set
#### 3) from the list of indices in Step 2, randomly select
#### indices for the validation set
#### 4) determine the testing-subset indices by selecting those
#### not in the validation-subset
indices.train = sort(sample(seq_len(nrow(car_data)), size=samp.train))
indices.valid_test = setdiff(seq_len(nrow(car_data)), indices.train)
indices.valid = sort(sample(indices.valid_test, size=samp.valid))
indices.test = setdiff(indices.valid_test, indices.valid)

#### Use the indices to select the data from the dataframe
car_data.train = car_data[indices.train,]
car_data.valid = car_data[indices.valid,]
car_data.test = car_data[indices.test,]

#================================
# Subsampling from a dataframe
# k-fold cross validation sets
#================================

#### Perform a k-fold cross validation for 5 subsets
#### because 60 rows divides evenly
samp.size = nrow(car_data) / 5

#### Determine the indices each subset will have
indices.one = sort(sample(seq_len(nrow(car_data)), size=samp.size))
indices.not_1 = setdiff(seq_len(nrow(car_data)), indices.one)
indices.two = sort(sample(indices.not_1, size=samp.size))
indices.not_12 = setdiff(indices.not_1, indices.two)
indices.three = sort(sample(indices.not_12, size=samp.size))
indices.not_123 = setdiff(indices.not_12, indices.three)
indices.four = sort(sample(indices.not_123, size=samp.size))
indices.five = setdiff(indices.not_123, indices.four)

#### Use the indices to select the data
car_data.1 = car_data[indices.one,]
car_data.2 = car_data[indices.two,]
car_data.3 = car_data[indices.three,]
car_data.4 = car_data[indices.four,]
car_data.5 = car_data[indices.five,]

#===================================
# Select rows based on conditions
# Use pollution data for example
#===================================

names(seedlings_data)
edit(seedlings_data)

#Identify the unique values in cohort
unique(seedlings_data$cohort)

#Select data obtained in September
seedlings_data[seedlings_data$cohort=="September",]

#Select data not obtained in October
seedlings_data[!(seedlings_data$cohort=="October"),]

#Select data for either September or October
seedlings_data[seedlings_data$cohort=="September" | seedlings_data$cohort=="October",]

#Select September data with death less than and equal to 10
seedlings_data[seedlings_data$cohort=="September" & seedlings_data$death<=10,]

#Select data for September or October with death less than and equal to 10
#What is the difference between these two?
#Notice the placement of the parentheses
seedlings_data[(seedlings_data$cohort=="September" | seedlings_data$cohort=="October")& seedlings_data$death<=10,]
seedlings_data[seedlings_data$cohort=="September" | (seedlings_data$cohort=="October" & seedlings_data$death<=10),]

#Select only data that are numeric
seedlings_data[,sapply(seedlings_data,is.numeric)]

#Select only data that are categorical
seedlings_data[,sapply(seedlings_data,is.factor)]

#Test dataframe for missing values
#TRUE means it is complete; no missing values
complete.cases(seedlings_data)

#Select rows that do not have missing values
na.omit(seedlings_data)

#=============================================
# Convert values in a column from a factor
# to a numerical value; use the student data
#=============================================

#### Need to convert values to numerical
#### Data contains a column Grade which has
#### only As and Bs. Convert the values
#### A --> 1 and B --> 0.
grade1 = gsub("A",1,stdt_data$Grade)
stdt_data = data.frame(stdt_data, grade1)			#Add new column to dataframe
grade2 = gsub("B",0,stdt_data$grade1)
stdt_data = data.frame(stdt_data, grade2)			#Add new column to dataframe
stdt_data = subset(stdt_data,select=-c(Grade,grade1))		#Remove the extraneous columns

#### The numeric values are in place,
#### but the datatype is still a factor
str(stdt_data$grade2)

#### Create a new column that converts the datatype
grade3 = as.numeric(levels(stdt_data$grade2))[stdt_data$grade2]
stdt_data = data.frame(stdt_data, grade3)
str(stdt_data$grade3)						#datatype is numeric!
stdt_data = subset(stdt_data,select=-c(grade2))		#Remove the column grade2
names(stdt_data)[7] = "Grade"					#Rename grade3 to Grade


#################################################
#=============Dates and Times in R==============#
# Provides a brief introduction to date-time	#
# objects in R. Columns containing dates and	#
# times are read into R as if they are		#
# categorical, not date-time objects.		#
#################################################

#### Read in the Cerner atrial fibrillation data
afib_data = read.table("C:\\Users\\bryan\\source\\repos\\msis5193-pds1-master\\using-and-manipulating-data\\data\\afib_data.txt", header=T, sep="\t")

names(afib_data)

#### Notice the datatypes for the admitted date
#### and discharge date columns are categorical,
#### not date-time. This means you cannot 
#### perform date-time calculations on these
#### columns (e.g. subtraction to get the length
#### of stay).
str(afib_data)

#### Notice the format of the date-time value
afib_data[1,c("admitted_dt_tm","discharged_dt_tm")]

#### Use the strptime() function to convert the variables
#### Create a new date object based off of admitted_dt_tm
admitdate = strptime(as.character(afib_data$admitted_dt_tm),"%Y-%m-%d %H:%M:%S.0000000")

#### Convert the new date object to a dataframe
admitdate = as.data.frame(admitdate)

#### Add the new dataframe to the original dataframe
afib_data = data.frame(afib_data,admitdate)

#### Create a new date object based off of discharged_dt_tm
dischargedate = strptime(as.character(afib_data$discharged_dt_tm),"%Y-%m-%d %H:%M:%S.0000000")

#### Convert the new date object to a dataframe
dischargedate = as.data.frame(dischargedate)

#### Add the new dataframe to the original dataframe
afib_data = data.frame(afib_data,dischargedate)

#### The new columns are the last two listed
names(afib_data)

#### Both are datatype POSIXct, which is continuous time
str(afib_data)

#### Calculate the difference between the admit date
#### and the discharge date to get the length of stay
#### for the first record in the dataframe
time1 = afib_data[1,c("admitdate")]			#when patient was admitted
time2 = afib_data[1,c("dischargedate")]		#when patient was discharged
difftime(time1,time2)					#difference of time


#### For more information, please read Chapters 2, 3, and 4 in The R Book
#### by Michael J. Crawley.


###########################################
#============Read in ODBC data============#
# Read in the data by creating a channel.	#
# Ensure that the channel exists in "ODBC	#
# Data Sources" found in Administrative	#
# Tools in Windows.				#
###########################################

library(RODBC)

#Scan the computer for available databases
odbcDataSources(type = c("all", "user", "system"))

#Open a channel to the hypermobility database
jhs.channel = odbcConnect("HypermobilityDatabase")

#Pull basic information on the database
odbcGetInfo(jhs.channel)

#Obtain the available data types in the database
jhs.datatype = sqlTypeInfo(jhs.channel, type = "all")
jhs.datatype$TYPE_NAME

#List the available tables from the database
sqlTables(jhs.channel)

#Look at the columns for the tables in the database
sqlColumns(jhs.channel, "hypermob_ehlersdanlos_admitdate")
sqlColumns(jhs.channel, "hypermob_ehlersdanlos_data")
sqlColumns(jhs.channel, "ICD9_Codes")
sqlColumns(jhs.channel, "JHS_CPT_Codes")


#######################################################
#===================Perform Queries===================#
#Obtain data from the DBMS via a set of queries		#
#######################################################

#========================================================
#Assesses CPT procedures after the diagnosis date of JHS.
#========================================================
postjhs.cpt.data = sqlQuery(jhs.channel, "
	SELECT hmad.patient_sk AS JHS_patientsk, hmad.admitted_dt_tm AS JHS_admitdate, hmad.DIAGNOSIS_CODE AS JHS_ICD9_code, hmd.patient_sk, hmd.admitted_dt_tm AS diag_date, 
		hmd.DIAGNOSIS_CODE AS ICD9_code, hmd.DIAGNOSIS_DESCRIPTION, hmd.DIAGNOSIS_TYPE_DISPLAY, hmd.PAYER_CODE_DESC, hmd.procedure_type, hmd.caresetting_desc,
		hmd.age_in_years, hmd.CENSUS_DIVISION, hmd.gender, hmd.marital_status, hmd.procedure_id, hmd.PROCEDURE_DT_TM, hmd.procedure_priority,
		hmd.PROCEDURE_CODE, hmd.PROCEDURE_DESCRIPTION, hmd.MEDICAL_SPECIALTY
	FROM hypermob_ehlersdanlos_admitdate hmad, hypermob_ehlersdanlos_data hmd
	WHERE hmad.admitted_dt_tm < hmd.admitted_dt_tm
		AND hmad.patient_sk = hmd.patient_sk
		AND hmd.procedure_code IN (SELECT CPT_codes FROM JHS_CPT_Codes)
	ORDER BY patient_sk, diag_date
	")

#Use this function to open a GUI
postjhs.cpt.data = edit(postjhs.cpt.data)

#Ensure the names are correct
names(postjhs.cpt.data)

#============================================================
#Assesses Non-CPT procedures after the diagnosis date of JHS.
#============================================================
postjhs.noncpt.data = sqlQuery(jhs.channel, "
	SELECT hmad.patient_sk AS JHS_patientsk, hmad.admitted_dt_tm AS JHS_admitdate, hmad.DIAGNOSIS_CODE AS JHS_ICD9_code, hmd.patient_sk, hmd.admitted_dt_tm AS diag_date, 
		hmd.DIAGNOSIS_CODE AS ICD9_code, hmd.DIAGNOSIS_DESCRIPTION, hmd.DIAGNOSIS_TYPE_DISPLAY, hmd.PAYER_CODE_DESC, hmd.procedure_type, hmd.caresetting_desc,
		hmd.age_in_years, hmd.CENSUS_DIVISION, hmd.gender, hmd.marital_status, hmd.procedure_id, hmd.PROCEDURE_DT_TM, hmd.procedure_priority,
		hmd.PROCEDURE_CODE, hmd.PROCEDURE_DESCRIPTION, hmd.MEDICAL_SPECIALTY
	FROM hypermob_ehlersdanlos_admitdate hmad, hypermob_ehlersdanlos_data hmd
	WHERE hmad.admitted_dt_tm < hmd.admitted_dt_tm
		AND hmad.patient_sk = hmd.patient_sk
		AND hmd.procedure_code NOT IN (SELECT cpt_codes FROM JHS_CPT_Codes)
		AND hmd.procedure_type NOT LIKE 'ICD9'
	ORDER BY patient_sk, diag_date
	")

#Use this function to open a GUI
edit(postjhs.noncpt.data)

#Ensure the names are correct
names(postjhs.noncpt.data)

summary(postjhs.noncpt.data) #Basic summary
str(postjhs.noncpt.data) #Look at structure of data

odbcClose(jhs.channel)