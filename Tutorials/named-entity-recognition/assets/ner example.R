#####################################################
#============Setup the Working Directory============#
# Set the working directory to the project folder by#
# running the appropriate code below.               #
#####################################################

# home
wd = "C:\\Users\\bryan\\OneDrive - Oklahoma State University\\Teaching\\MSIS 5193 4623 - Programming Data 1\\Data"

# office
wd = "C:\\Users\\bryan\\OneDrive - Oklahoma A and M System\\Teaching\\MSIS 5193 4623 - Programming Data 1\\Data"

setwd(wd)


#################################################
#================Tutorial Data==================#
# Scrape data from webpage on Wikipedia         #
#################################################

library(RSelenium)
library(stringr)
library(NLP)
library(openNLP)
#install.packages("openNLPmodels.en", repos = "http://datacube.wu.ac.at/", type = "source")

#===============================
# Wikipedia page on Bill Gates
#===============================
wiki_url = "https://en.wikipedia.org/wiki/Bill_Gates"
rD = rsDriver(verbose=FALSE, browser = 'firefox', port = 4566L)
remDr = rD$client
remDr$navigate(wiki_url)

xp_name1 = '/html/body/div[3]/div[3]/div[4]/div/p[2]'
xp_name2 = '/html/body/div[3]/div[3]/div[4]/div/p[3]'
xp_name3 = '/html/body/div[3]/div[3]/div[4]/div/p[4]'
xp_name4 = '/html/body/div[3]/div[3]/div[4]/div/p[5]'
xp_name5 = '/html/body/div[3]/div[3]/div[4]/div/p[6]'

person_elem = remDr$findElements(using = "xpath", value = xp_name1)
para1 = unlist(sapply(person_elem, function(x) {x$getElementText()}))

person_elem = remDr$findElements(using = "xpath", value = xp_name2)
para2 = unlist(sapply(person_elem, function(x) {x$getElementText()}))

person_elem = remDr$findElements(using = "xpath", value = xp_name3)
para3 = unlist(sapply(person_elem, function(x) {x$getElementText()}))

person_elem = remDr$findElements(using = "xpath", value = xp_name4)
para4 = unlist(sapply(person_elem, function(x) {x$getElementText()}))

person_elem = remDr$findElements(using = "xpath", value = xp_name5)
para5 = unlist(sapply(person_elem, function(x) {x$getElementText()}))

textbank = paste(para1, para2, para3, para4, para5)

remDr$close()
rD$server$stop()

# Remove reference notation from text
ref_pattern = '\\[[0-9]]|\\[[0-9][0-9]]|\\[[0-9][0-9][0-9]]'
textbank2 = str_replace_all(textbank, ref_pattern, "")

textbank2 = as.String(textbank2)

sent_token_annotator = Maxent_Sent_Token_Annotator()
word_token_annotator = Maxent_Word_Token_Annotator()
pos_tag_annotator = Maxent_POS_Tag_Annotator() 

anno1 = annotate(textbank2, list(sent_token_annotator, 
                               word_token_annotator))

anno2 = annotate(textbank2, pos_tag_annotator, anno1)

# POST probabilities
(annotate(textbank2, Maxent_POS_Tag_Annotator(probs = TRUE), anno2))

# Filter out everything except words
anno2wrd = subset(anno2, type == "word")
# Under the column features, filter out only POS
tags = sapply(anno2wrd$features, `[[`, "POS")
tags
table(tags)
## Extract token/POS pairs for all text. 
sprintf("%s/%s", textbank2[anno2wrd], tags)

#======================
# Named-entity people
#======================
anno3 = annotate(textbank2, list(sent_token_annotator, 
                                 word_token_annotator))

entity_annotator = Maxent_Entity_Annotator(kind='person')
entity_annotator

# Select only entities
anno4 = annotate(textbank2, entity_annotator, anno3)
anno5 = subset(anno4, type == "entity")
anno5

# Alternative Method, quicker
anno5 = entity_annotator(textbank2, anno3)
anno5

# Retrieve text
textbank2[anno5]

#=========================
# Named-entity locations
#=========================
loc_annotator = Maxent_Entity_Annotator(kind='location')

anno6 = loc_annotator(textbank2, anno3)
anno6

# Retrieve text
textbank2[anno6]

#=============================
# Named-entity organizations
#=============================
org_annotator = Maxent_Entity_Annotator(kind='organization')

anno7 = org_annotator(textbank2, anno3)
anno7

# Retrieve text
textbank2[anno7]
