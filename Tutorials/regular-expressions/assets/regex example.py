#############################################
#=============Read in Libraries=============#
# Read in the necessary libraries.          #
#############################################

#import re
import regex


#############################################
#===========Regex Matched Object============#
# The following examples use the functions  #
# match() and search().                     #
#############################################

#===============================
# First example, using match()
#===============================
reg_string1 = "To catch a cat requires skill not caterpillar like slowness or cataract like myopia"
reg_string2 = "Cats exude cataract like myopia"
pattern1 = r"[Cc]at."

# The function match() only compares the 
# first word in a string
if regex.match(pattern1, reg_string1):
    print("You found a match!")
else: print("Bummer. No match.")

if regex.match(pattern1, reg_string2):
    print("You found a match!")
else: print("Bummer. No match.")


#=================================
# Second example, using search()
#=================================
if regex.search(pattern1, reg_string1):
    print("You found a match!")
else: print("Bummer. No match.")

if regex.search(pattern1, reg_string2):
    print("You found a match!")
else: print("Bummer. No match.")


#===========================================
# Comparing functions match() and search()
#===========================================
matches1 = regex.match(pattern1, reg_string1)
matches2 = regex.match(pattern1, reg_string2)
matches3 = regex.search(pattern1, reg_string1)
matches4 = regex.search(pattern1, reg_string2)
matches5 = regex.search("[Dd][Oo][Gg]", reg_string1)
matches6 = regex.search("[Dd][Oo][Gg]", reg_string2)

matches1
matches2
matches3
matches4
matches5
matches6

#===================================================
# Appending group() at the end of the match object
#===================================================
matches2.group()
matches3.group()
matches4.group()


#==========================================
# Other functions: span(), start(), end()
#==========================================
matches2.span()
matches2.start()
matches2.end()


#============================================
# Using group() to extract grouped patterns
#============================================
reg_email = r"([a-z\.-]+)@([a-z\.-]+)\.(com|edu)"
pattern_email1 = "bryan.hammer@okstate.edu"

matches7 = regex.search(reg_email, pattern_email1)
matches7.group()
matches7.group(1)
matches7.group(2)
matches7.group(3)


#========================================
# Use the function findall() to extract 
# all possible matches in a string
#========================================
reg_string3 = "To catch a cat requires skill not caterpillar like slowness or cataract like myopia"
pattern2 = r"(cat){1}([a-z]*)"

matches8 = regex.findall(pattern2,reg_string3)

matches8

# in the loop, cats is arbitrary; you could use
# asdf instead of cats
for cats in matches8: 
    print(cats)

len(matches8)


#====================================
# Pulling email addresses from html
#====================================
reg_string4 = '<p><a href="mailto:bryan.hammer@okstate.edu?subject=">bryan.hammer@okstate.edu</a></p><p><a href="mailto:ramesh.sharda@okstate.edu?subject=">ramesh.sharda@okstate.edu</a></p>'
reg_ptags = r"<p><a href=\"mailto:([a-z\.-]+)@([a-z\.-]+)\.(com|edu)\?subject=\">([a-z\.-]+)@([a-z\.-]+)\.(com|edu)</a></p>"

matches9 = regex.findall(reg_ptags,reg_string4)

for emaillist in matches9:
    print(emaillist)

# Another possibility
reg_ptags2 = r"<p><a href=\"mailto:(?P<username>[a-z\.-]+)@(?P<business>[a-z\.-]+)\.(?P<entitytype>com|edu)\?subject=\">([a-z\.-]+)@([a-z\.-]+)\.(com|edu)</a></p>"

for i in regex.finditer(reg_ptags2,reg_string4):
    print(i.group('username'), i.group('business'), i.group('entitytype'))


#############################################
#=========Regex Splitting Strings===========#
# The following examples use the function   #
# split() to create substrings.             #
#############################################

reg_string5 = reg_string1.split()
reg_string5

# Illustration of whitespace as delimiter
# Two additional spaces added around "cat"
reg_string6 = "To catch a  cat  requires skill not caterpillar like slowness or cataract like myopia"
reg_string7 = reg_string6.split(" ")
reg_string7

reg_string6 = "To catch a  cat  requires skill not caterpillar like slowness or cataract like myopia"
reg_string7 = reg_string6.split(None)
reg_string7

