#######################################################
#=============Setup the Working Directory=============#
#Set the working directory to the project folder by 	#
#running the appropriate script below. Note, you can 	#
#run the data off of your OneDrive or DropBox.		#
#######################################################

workingdirectory = "C:\\Users\\bryan\\source\\repos\\msis5193-pds1-master\\descriptive-statistics\\data"
setwd(workingdirectory)


###########################################
#==============Read in data===============#
#Read in the data for both data sets.	#
###########################################

temptable = paste(workingdirectory, "\\ozone.data.txt", sep="")
ozone_data = read.table(temptable, header=T, sep="\t")

ozone_data

summary(ozone_data)

str(ozone_data)


#################################################
#=============Descriptive Analysis==============#
# This section is used to assess the variance 	#
# inflation factor, standard deviations, and 	#
# means for each variable. Also, the 		#
# significance of the correlations is obtained.	#
# Place any other descriptive statistics here	#
# within this section. Be sure to add comments.	#
#################################################

#install.packages("psych")		#Perform descriptive statistics
library(psych)

#=================================================================
# Obtain the Means, Standard Deviations, etc. for the data.	
# You must first install the "pysch" package before proceeding.
#=================================================================

#### Radiation (IV)
describe(ozone_data$rad)					#Obtain descriptive stats
sprintf("%.3f", describe(ozone_data$rad))			#Round to 3 decimal places
var(ozone_data$rad)						#Variance has a high degree of spread
sd(ozone_data$rad)						#Standard deviation

plot(ozone_data$rad)						#Index plot; x-axis is the order number the data point appears
ozone_data$rad							#All data for radiation listed in order by row
boxplot(ozone_data$rad)

#Check for normality using Shapiro-Wilk Test
#Normality results in non-significance
shapiro.test(ozone_data$rad)

#Visual test for normality using QQ Plot
#Run both at the same time
qqnorm(ozone_data$rad)
qqline(ozone_data$rad, lty=2)


#### Temperature (IV)
describe(ozone_data$temp)					#Obtain descriptives
var(ozone_data$temp)						#Variance not as spread out as Radiation
sd(ozone_data$temp)						#Standard deviation

plot(ozone_data$temp)						#Index plot
boxplot(ozone_data$temp, main="Boxplot of Temp")	#Boxplot

#Plot temp against target variable, ozone
#This scatterplot can help with assessing linearity
plot(ozone_data$temp, ozone_data$ozone)

qqnorm(ozone_data$temp)
qqline(ozone_data$temp, lty=2)
shapiro.test(ozone_data$temp)		#Shapiro_Wilk Normality Test


#### Wind (IV)
describe(ozone_data$wind)
sprintf("%.3f", describe(ozone_data$wind))
boxplot(ozone_data$wind)


#### Ozone Concentration (DV)
describe(ozone_data$ozone)
sprintf("%.3f", describe(ozone_data$ozone))


# Allow the R Graphics window to display 2 graphics
# with 1 rows and 2 columns. If you already have a
# figure or plot open, close it first before running
par(mfrow=c(2,1))

boxplot(ozone_data$ozone, main="Boxplot of Ozone")	#Appears to have outliers; skewness as well?
hist(ozone_data$ozone, main="Ozone Histogram")

skew(ozone_data$ozone)						#The function describe() gives the same value
kurtosi(ozone_data$ozone)					#Same value as given by describe()

shapiro.test(ozone_data$ozone)
qqnorm(ozone_data$ozone)
qqline(ozone_data$ozone, lty=2)

par(mfrow=c(1,1))

#### Multiple variables at the same time
describe(ozone_data)

#### Create scatter plots for all variables simultaneously
#### Look at the row with the DV, ozone
pairs(ozone_data, panel=panel.smooth)

#### Run boxplot for all variables
boxplot(ozone_data)


#################################################
#==============Correlation Analysis=============#
# Create a new dataset that only contains the	#
# variables for your final regression model.	#
# Pass that new dataset into the cor()		#
# function below.						#
#################################################

#install.packages("Hmisc")		#Provides correlation matrix with significance values
library(Hmisc)					#To use the rcorr() function

ozone_corr = cor(ozone_data)			#pearson correlation
ozone_corr						#show correlations; this doesn't round the correlation values

#### What about significance of the correlations? 
#### This shows the correlation values (rounded) and their associated p-values
rcorr(as.matrix(ozone_data))			



#### For more information, please read Chapters 2, 3, and 4 in The R Book
#### by Michael J. Crawley.