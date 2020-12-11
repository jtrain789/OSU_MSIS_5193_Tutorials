#############################################
#=============Read in Libraries=============#
# Read in the necessary libraries.          #
#############################################

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os

#For QQ Plot
import scipy.stats as sts

#####################################################
#============Setup the Working Directory============#
# Set the working directory to the project folder by#
# running the appropriate code below.               #
#####################################################

os.getcwd()

os.chdir(r'C:\Users\bryan\source\repos\msis5193-pds1-master\descriptive-statistics\data')
os.getcwd()


#############################################
#===============Read in data================#
#Read in the data for both data sets.	    #
#############################################

ozone_data = pd.read_table('ozone.data.txt')
ozone_data.columns

car_data = pd.read_table('car.test.frame.txt', sep='\t')
car_data.columns

#################################################
#=============Descriptive Analysis==============#
# This section is used to assess the variance 	#
# inflation factor, standard deviations, and 	#
# means for each variable. Also, the 		    #
# significance of the correlations is obtained.	#
# Place any other descriptive statistics here	#
# within this section. Be sure to add comments.	#
#################################################

ozone_data.describe()

car_data.describe()

car_data.describe(include=['object'])

car_data.describe(include=['number'])

car_data['Country_cat'] = car_data['Country'].astype('category')

car_data.columns

car_data.dtypes

car_data.describe()

car_data.describe(include=['object'])

car_data.describe(include=['category'])

car_data.kurt()

#===================================
# Create a simple timeseries plot
#===================================
ts = pd.Series(np.random.randn(1000), index=pd.date_range('1/1/2000', periods=1000))
ts = ts.cumsum()
ts.plot()

#==============================================
# Use ozone_data for scatter plot and box plot
#==============================================
ozone_data.plot.scatter(x='temp', y='rad')

ozone_data.boxplot()

ozone_data.loc[:,['temp','wind','ozone']].boxplot()

ozone_data.loc[:,['wind']].boxplot()

#================================
# Plot a histogram of radiation
#================================
#plt.figure();
ozone_data['rad'].plot.hist(alpha=0.5)

#================================
# Plot a bar chart of Country
#================================

car_data.Country.value_counts().plot.bar()

car_data.Country.value_counts().plot.barh()

car_data.Type.value_counts().plot.barh()

#=================================
# Assess normality using QQ Plot
#=================================

sts.probplot(ozone_data.rad, dist="norm", plot=plt)

#======================================
# Assess normality using Shapiro-Wilk
#======================================

sts.shapiro(ozone_data.rad)

ozone_data.wind.skew()
ozone_data.wind.kurt()