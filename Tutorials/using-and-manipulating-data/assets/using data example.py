#############################################
#=============Read in Libraries=============#
# Read in the necessary libraries.          #
#############################################

import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

#from sklearn.cross_validation import KFold
#this method function is deprecated; use the below function instead
from sklearn.model_selection import KFold


#####################################################
#============Setup the Working Directory============#
# Set the working directory to the project folder by#
# running the appropriate code below.               #
#####################################################

os.getcwd()

os.chdir(r'C:\Users\bryan\source\repos\msis5193-pds1-master\using-and-manipulating-data\data')

os.getcwd()


#############################################
#===============Read in data================#
#Read in the data for both data sets.	    #
#############################################

ozone_data = pd.read_table('ozone.data.txt', sep='\t')
ozone_data

ozone_data.rad

ozone_data.columns

ozone_data.head(5)

car_data = pd.read_table('car.test.frame.txt', sep='\t')
car_data.columns

car_data.drop(['Mileage', 'Type', 'Weight'], axis=1, inplace=True)
car_data.columns

car_data = pd.read_table('car.test.frame.txt', sep='\t')
car_data.drop(car_data.columns[[3,4,5]], axis=1, inplace=True)
car_data.columns

car_data = pd.read_table('car.test.frame.txt', sep='\t')

#Rename Mileage to Total_Mileage
car_data.columns = ['Price', 'Country', 'Reliability', 'Total_Mileage', 'Type', 'Weight', 'Disp.', 'HP']

car_data.columns

#Change the name of Mileage back
car_data.rename(columns={'Total_Mileage':'Mileage'}, inplace=True)

car_data.columns

seedlings_data = pd.read_table('seedlings.txt')

#Convert to categorical datatype
seedlings_data['cohort'] = seedlings_data['cohort'].astype('category')

#Select categorical columns
seedlings_data.select_dtypes(include=['category'])


#################################################
#=========Working with Data (Indices)===========#
# Indices (or subscripts) are the specific cell	#
# within the dataframe. It looks like this:	    #
# 	[1,2]							            #
#################################################

#========================
# Selection by position
#========================
# Integer: Select Row 37
car_data.iloc[36]

# Slicing: First 3 rows
car_data.iloc[:3]
car_data.iloc[0:3]

# Array: First 3 rows
car_data.iloc[[0,1,2]]

# Integer: Select Row 3, Column 3
car_data.iloc[2,2]

# Slicing: First 3 rows and first 3 columns
car_data.iloc[:3,:3]
car_data.iloc[0:3,0:3]

# What about rows 10 through 16 and the last 3 columns?
car_data.iloc[9:16,5:8]

# All rows in the data but only the last three columns
car_data.iloc[:,5:8]

# Array: First 3 rows; last 3 columns
car_data.iloc[[0,1,2],[5,6,7]]

#========================
# Selection by label
#========================
# Slicing examples
car_data.loc[:,'Price']
car_data.loc[:,'Price':'Mileage']

car_data.loc[0:3,'Price':'Mileage']

# Array example
car_data.loc[[0,1,2],['Weight','Disp.','HP']]

#================
# Unique Values
#================
pd.unique(car_data.Country)

#==========================
# Meta-Data for Dataframe
#==========================
car_data.shape
len(car_data.index)
len(car_data.columns)

#=================
# Sorting data
#=================
car_data.sort_values(by='Reliability')

car_data.sort_values(by='Reliability',na_position='first')

car_data.nlargest(6,'Reliability')

car_data.nlargest(6,['Reliability','Mileage'])

car_data.sort_values(by=['Reliability','Mileage'])

car_data.sort_values(by=['Mileage','Reliability'])

#====================================
# Subsampling from a dataframe
# Select 60% of the data at random
#===================================

#=== First Method
splitnum = np.round((len(ozone_data.index) * 0.6), 0).astype(int)
splitnum
ozone_data_sample = ozone_data.sample(n=splitnum, replace=False)
len(ozone_data_sample.index)

#=== Second Method
ozone_data_sample = ozone_data.sample(frac=0.6, replace=False)
len(ozone_data_sample.index)


#===================================
# Select rows based on conditions
# Use seedlings data for example
#===================================

seedlings_data.head()

seedlings_data.columns

seedlings_data.cohort.unique()

#Select September data
seedlings_data[seedlings_data.cohort=='September']
seedlings_data[seedlings_data.cohort!='October']

seedlings_data[(seedlings_data.cohort=='September')&(seedlings_data.death<=10)]

seedlings_data[(seedlings_data.cohort=='September')|(seedlings_data.cohort=='October')]

pd.notnull(seedlings_data)

pd.isnull(seedlings_data)

#================================
# Subsampling from a dataframe
# k-fold cross validation sets
#================================

#deprecated process due to library changes; see new process below
#kf = KFold(len(car_data.index), n_folds=2)
#
#for train, test in kf:
#    print("%s %s" % (train, test))
#
#car_data.ix[train]

kf = KFold(n_splits=2)

for train, test in kf.split(car_data):
    print("%s %s" % (train, test))

car_data.iloc[train]

car_data.iloc[test]

#==========================
# Adding rows and columns
#==========================

#Simple example to add 3 new rows
newrows = [{'cohort':'November', 'death':333, 'gapsize':0.333},
           {'cohort':'November', 'death':444, 'gapsize':0.444},
           {'cohort':'December', 'death':5555, 'gapsize':0.555}]

seedlings_data2 = seedlings_data.append(newrows, ignore_index=True)

len(seedlings_data.index.values)

len(seedlings_data2.index.values)

#Adding an existing dataframe containing 5 records
newrows2 = pd.DataFrame({'cohort':['July', 'December', 'January', 'April', 'December'],
                         'death':[1,2,3,4,4],
                         'gapsize':[0.4216,0.1532,0.5434,0.6843,0.8531]},
                        index=[63,64,65,66,67])

seedlings_data3 = pd.concat([seedlings_data2, newrows2])

#Appending a dataframe column
newcols = pd.DataFrame({'daylight': range(490,558)})

seedlings_data4 = pd.concat([seedlings_data3, newcols], axis=1)

seedlings_data4.head()

#See here for more details http://pandas.pydata.org/pandas-docs/stable/merging.html


#################################################
#===============Dates and Times=================#
# Provides a brief introduction to date-time	#
# objects in R. Columns containing dates and	#
# times are read in as if they are objects.		#
#################################################

afib_data = pd.read_table('afib_data.txt')

afib_data.dtypes

afib_data.admitted_dt_tm.head()

afib_data['admitted_dt_tm'] = pd.to_datetime(afib_data['admitted_dt_tm'])

afib_data.admitted_dt_tm.head()
