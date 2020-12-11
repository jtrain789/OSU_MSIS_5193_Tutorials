#==================================================
# The purpose of this is to cover the creation of 
# basic plots and graphs. The main focus will be 
# on plots for two variables: bar charts, line 
# charts, box plots, scatter plots, histograms 
# (Crawley Chapter 5; R libraries math, plot, 
# GGPlot).
#==================================================

wd = "C:\\Users\\bryan\\source\\repos\\msis5193-pds1-master\\visualization-fundamentals\\data"

setwd(wd)


###########################################
#==============Scatter Plot===============#
# Create a scatter plot for two variables #
###########################################

temptable = paste(wd, "\\ozone.data.txt", sep = "")
ozone_data = read.table(temptable, sep = '\t', header = TRUE)

plot(ozone_data$temp, ozone_data$ozone)

plot(ozone_data$wind, ozone_data$ozone)

plot(ozone_data$rad, ozone_data$ozone)


#########################################
#==============Histogram================#
# Create a histogram for two variables  #
#########################################

hist(ozone_data$temp)

hist(ozone_data$wind)

hist(ozone_data$rad)

hist(ozone_data$ozone)


#########################################
#===============Box Plot================#
# Create a box plot for two variables   #
#########################################

library(car)

range(ozone_data$temp)
# 57 --> 97

# Create non-overlapping sub-intervals (i.e. the bins).
# Select an arbitrary number to start out.
# Increment every 10: 57, 67, 77, 87, 97
(bin_interval = seq(57, 97, by = 10))
# 57 67 77 87 97

# View the binning in a table
table(cut(ozone_data$temp, bin_interval, right = FALSE))
# Result: binning appears to create a normal
# distribution of the data

# Recode the values in the temp column based on the binning
temp_vec = recode(ozone_data$temp, "57:66='57-66'; 67:76='67-76'; 
                    77:86='77-86'; 87:97='87-97'")

# Take the binning data and add it as a column to the dataframe
ozone_data$temp_categ = temp_vec

ozone_data$temp_categ = as.factor(ozone_data$temp_categ)

# Compare the original temperature column
# to the new temperature category
ozone_data[, c('temp', 'temp_categ')]

plot(ozone_data$temp_categ, ozone_data$ozone)

boxplot(ozone_data$temp)


#########################################
#===============Bar Chart===============#
# Create a bar graph for two variables  #
#########################################

# Elk populations 2013
elk_num = c(33000,265000,148000,17500,70000,80000)
elk_state = c('Arizona','Colorado','Montana','Nevada','New Mexico','Utah')

barplot(elk_num, names.arg = elk_state)

#=======================================
# Example of Temperature and Radiation
#=======================================
range(ozone_data$rad)
# 7 --> 334

# Create non-overlapping sub-intervals (i.e. the bins).
# Select an arbitrary number to start out.
(bin_interval = seq(7, 334, by = 50))

# View the binning in a table
table(cut(ozone_data$rad, bin_interval, right = FALSE))
# Missing the values above 307

# Add the last bin manually as it is left off
bin_interval[8] = 335
table(cut(ozone_data$rad, bin_interval, right = FALSE))
# Result: The values 57-106 and 107-156 could be combined
# to create an equal distribution 

# Recode the values in the rad column based on the binning
rad_vec = recode(ozone_data$rad,
                 "7:56='7-56';
                 57:156='57-156';
                 157:206='157-206';
                 207:256='207-256';
                 257:306='257-306';
                 307:334='307-334'",
                 as.factor = TRUE)

# Take the binning data and add it as a column to the dataframe
ozone_data$rad_categ = rad_vec

library(tidyverse)

group1 = group_by(ozone_data, rad_categ)

temp_median = summarise(group1,
  med_temp = median(temp),
  sd_temp = sd(temp)
)

# Alternative with piping
temp_median = ozone_data %>% 
  group_by(rad_categ) %>% 
  summarise(
    med_temp = median(temp),
    sd_temp = sd(temp)
  )

barplot(temp_median$med_temp, names.arg = temp_median$rad_categ)


#########################################
#==============Line Chart===============#
# Create a line chart for two variables #
#########################################

library(forecast)

data(AirPassengers)

plot(AirPassengers)
