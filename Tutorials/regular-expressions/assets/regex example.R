#####################################################
#============Setup the Working Directory============#
# Set the working directory to the project folder by#
# running the appropriate code below.               #
#####################################################

wd_home = "C:\\Users\\bryan\\OneDrive - Oklahoma State University\\Teaching\\MSIS 5193 4623 - Programming Data 1\\Data"
setwd(wd_home)

wd_office = "C:\\Users\\bryan\\OneDrive - Oklahoma A and M System\\Teaching\\MSIS 5193 4623 - Programming Data 1\\Data"
setwd(wd_office)


#############################################
#==============Regex with grep==============#
# The following examples use the basic      #
# function grep.                            #
#############################################

#==========================================================
# First example, using quantifiers for matching patterns
#==========================================================
reg_string1 = c('x', 'xy', 'xyz', 'xyyz', 'xyyyz', 'xyyyyz', 'xz')

grep("xy*z", reg_string1, value = TRUE)
grep("xy+z", reg_string1, value = TRUE)
grep("yy+", reg_string1, value = TRUE)
grep("xy?z", reg_string1, value = TRUE)
grep("yy?", reg_string1, value = TRUE)
grep("yy{1}", reg_string1, value = TRUE)
grep("xy{2}z", reg_string1, value = TRUE)
grep("xy{2,}z", reg_string1, value = TRUE)
grep("xy{2,3}z", reg_string1, value = TRUE)
grep("y{2,3}", reg_string1, value = TRUE)

#==================================
# Using anchors to match patterns
#==================================
reg_string2 = c('abcd', 'cdab', 'cabd', 'c abd')

grep("ab", reg_string2, value = TRUE)
grep("^ab", reg_string2, value = TRUE)
grep("bd$", reg_string2, value = TRUE)
grep("\\bab", reg_string2, value = TRUE)

#=============================
# Using the . as a wild card
#=============================
reg_string3 = c('catch', 'cater', 'ducat', 'scatter', 'locate')

grep(".cat", reg_string3, perl = TRUE, value = TRUE)
grep("cat.", reg_string3, perl = TRUE, value = TRUE)
grep(".cat.", reg_string3, perl = TRUE, value = TRUE)


#==========================================
# Real-world example, searching for "cat"
#==========================================
reg_string4 = c('To', 'catch', 'a', 'cat', 'requires', 'skill', 'not', 'caterpillar', 'like', 'slowness', 'or', 'cataract', 'like', 'myopia', 'asdcat')

grep("cat", reg_string4, perl = TRUE, value = FALSE)
grep("cat", reg_string4, perl = TRUE, value = TRUE)

grep("cat$", reg_string4, perl = TRUE, value = TRUE)

#===========================
# More real-world examples
#===========================
reg_string5 = c('catch', 'cat', 'caterpillar', 'cataract', 'asdcat', 'xycatzz', 'abc cat xyz')

grep("^cat", reg_string5, perl = TRUE, value = TRUE)
grep("cat$", reg_string5, perl = TRUE, value = TRUE)
grep("^cat$", reg_string5, perl = TRUE, value = TRUE)
grep("\\bcat\\b", reg_string5, perl = TRUE, value = TRUE)


#############################################
#=============Tidyverse Stringr=============#
# Use the functions contained in the library#
# stringr to identify, match, detect, count #
# regular expression patterns.              #
#############################################

#install.packages("stringr")
library(stringr)

#=========================================
# Using str_detect() to identify matches
#=========================================
reg_string6 = c('To', 'catch', 'a', 'cat', 'requires', 'skill', 'not', 'caterpillar', 'like', 'slowness', 'or', 'cataract', 'like', 'myopia')
str_detect(reg_string6, "cat")
sum(str_detect(reg_string6, "cat"))

str_subset(reg_string6, "cat")

#================================
# Words that do not contain cat
#================================
(no_cat = !str_detect(reg_string6,"cat"))

#==============
# str_count()
#==============
reg_string7 = c('catch', 'cat', 'caterpillar', 'catcatcat', 'catcat', 'xycatzz', 'abc cat xyz')
str_count(reg_string7, "cat")

#================================
# str_subset() vs str_extract()
#================================
reg_string8 = c('To catch a cat requires', 'skill', 'not caterpillar-like slowness or', 'cataract', 'like myopia')
str_subset(reg_string8, "cat")

matched_strings1 = str_subset(reg_string8, "cat")
matches1 = str_extract(matched_strings1, "cat")
matches1

# Extracting all the values from a string, not just the first
matches_more = str_extract_all(matched_strings1, "cat")
matches_more

matches_more = str_extract_all(matched_strings1, "cat", simplify = TRUE)
matches_more

# Another example
length(fruit)
head(fruit)

fruit_types = c('berry', 'fruit')
fruit_regex = str_c(fruit_types, collapse = "|")
fruit_regex

matched_strings2 = str_subset(fruit, fruit_regex)
matched_strings2

matches2 = str_extract(matched_strings2, fruit_regex)
matches2

#=================================
# Using the function str_match()
#=================================
str_match(reg_string6, "(.)[aeiou](.)")

# A more complex example
noun = "(a|the) ([^ ]+)"
matched_strings3 = str_subset(sentences, noun)
matches3 = str_extract(matched_strings3, noun)
head(matches3)
matches4 = str_match(matched_strings3, noun)
head(matches4)
