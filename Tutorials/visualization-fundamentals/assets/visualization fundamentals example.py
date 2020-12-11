#==================================================
# The purpose of this is to cover the creation of 
# basic plots and graphs. The main focus will be 
# on plots for two variables: bar charts, line 
# charts, box plots, scatter plots, histograms
#==================================================

#####################################################
#============Setup the Working Directory============#
# Set the working directory to the project folder by#
# running the appropriate code below.               #
#####################################################

import os
import pandas as pd
import matplotlib.pyplot as plt

os.chdir(r'C:\Users\bryan\source\repos\msis5193-pds1-master\visualization-fundamentals\data')

###########################################
#==============Scatter Plot===============#
# Create a scatter plot for two variables #
###########################################

ozone_data = pd.read_table('ozone.data.txt')

# plt.show()

ozone_data.plot.scatter(x='temp', y='ozone')

ozone_data.plot.scatter(x='wind', y='ozone')

ozone_data.plot.scatter(x='rad', y='ozone')


#########################################
#==============Histogram================#
# Create a histogram for two variables  #
#########################################

ozone_data['temp'].plot.hist(alpha=0.5)

ozone_data['wind'].plot.hist(alpha=0.5)

ozone_data['rad'].plot.hist(alpha=0.5)

ozone_data['ozone'].plot.hist(alpha=0.5)


#########################################
#===============Box Plot================#
# Create a box plot for two variables   #
#########################################

#Binning of data
from scipy.stats import binned_statistic

#===========================
# Perform binning for temp
#===========================
ozone_data['temp'].max()
# Max: 97

ozone_data['temp'].min()
# Min: 57

# Create non-overlapping sub-intervals (i.e. the bins).
# Select an arbitrary number to start out. 4 bins total
bin_counts,bin_edges,binnum = binned_statistic(ozone_data['temp'], 
                                               ozone_data['temp'], 
                                               statistic='count', 
                                               bins=4)

# Counts within each bin
bin_counts

# Bin Values (only shows left value, not right)
bin_edges

bin_interval = [57, 67, 77, 87, 98]

# Recode the values in the age column based on the binning
binlabels = ['57-66', '67-76', '77-86', '87-97']
temp_categ = pd.cut(ozone_data['temp'], bin_interval, right=False, retbins=False, labels=binlabels)

temp_categ.name = 'temp_categ'

# Take the binning data and add it as a column to the dataframe
ozone_data = ozone_data.join(pd.DataFrame(temp_categ))

# Compare the original column to the new
ozone_data[['temp', 'temp_categ']].sort_values(by='temp')

ozone_data.boxplot(column='ozone', by='temp_categ')


#########################################
#===============Bar Chart===============#
# Create a bar graph for two variables  #
#########################################

# Elk populations 2013
elk_d = {'population': [33000,265000,148000,17500,70000,80000], 
        'state':['Arizona','Colorado','Montana','Nevada','New Mexico','Utah']}

elk_data = pd.DataFrame(data=elk_d)

elk_data.plot.bar(x='state', y='population')


#########################################
#==============Line Chart===============#
# Create a line chart for two variables #
#########################################

import numpy as np

ts = pd.Series(np.random.randn(1000), index=pd.date_range('1/1/2000', periods=1000))

ts = ts.cumsum()

ts.plot()