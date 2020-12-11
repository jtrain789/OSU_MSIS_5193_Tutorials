###########################################
#==============Read in data===============#
# Read in the data from imdb.com.   	    #
###########################################
# install.packages('rvest')
library(rvest)
library(stringr)

# The Princess Bride movie
princ_url = 'https://www.imdb.com/title/tt0093779/'

#=================================
# Scrape the rating from webpage
#=================================
princbride = read_html(princ_url)
find_code = html_node(princbride, "div.ratingValue>strong>span")
rating_value = html_text(find_code)
imdb_rating = as.numeric(rating_value)

########################
# Alternative using pipe
imdb_rating = princbride %>%
  html_node('div.ratingValue>strong>span') %>%
  html_text() %>%
  as.numeric()

#====================================
# Scrape the cast list from webpage
# Identify CSS selectors by using
# the "inspect element" function
# in the web browser
#====================================
find_code2 = html_nodes(princbride, 'tr.odd, tr.even')
imdb_castlist = html_text(find_code2)

# Alternative using pipe %>%
imdb_castlist = princbride %>%
  html_nodes('tr.odd, tr.even') %>%
  html_text()

cast_regex = "([A-Za-z]+ [A-Za-z]+)(\\n\\s+){3}\\.\\.\\.(\\n\\s+){3}([A-Za-z ]+)"

cast_extract = str_extract_all(imdb_castlist,cast_regex)
castlist_match = str_match(cast_extract, cast_regex)

# Alternative
castlist_match = str_extract_all(imdb_castlist,cast_regex) %>%
  str_match(cast_regex)

# Look at the data extracted using the
# regular expression
castlist_match

# Convert the matrix into a data frame
castlist_data = as.data.frame(castlist_match)

# We only want the second and fifth columns of data
castlist_data = castlist_data[, c(2,5)]

# View the newly created data frame
castlist_data


###########################################
#==============Read in data===============#
# Read in the data from wikipedia.com	    #
###########################################

i7proc = read_html("https://en.wikipedia.org/wiki/List_of_Intel_Core_i7_microprocessors")

find_code3 = html_nodes(i7proc, xpath="/html/body/div[3]/div[3]/div[5]/div[1]/table[7]")

i7proc_table = html_table(find_code3,fill=TRUE)

i7proc_table

# Alternative using piping
i7proc_table = i7proc %>%
  html_nodes(xpath="/html/body/div[3]/div[3]/div[5]/div[1]/table[7]") %>%
  html_table(fill=TRUE)


#############################
# Selenium and Princess Bride
#############################
library(RSelenium)

rD = rsDriver(verbose=FALSE, browser = 'firefox', port = 4566L)
remDr = rD$client

web_url = 'https://www.imdb.com/title/tt0093779/'

remDr$navigate(web_url)

rating_css = 'div.ratingValue>strong>span'

(rating_elem = remDr$findElements(using = "css selector", value = rating_css))

rating_val = unlist(sapply(rating_elem, function(x) {x$getElementText()}))


cast_url = 'https://www.imdb.com/title/tt0093779/fullcredits?ref_=tt_ql_1'

remDr$navigate(cast_url)

cast_css = 'table.cast_list>tbody>tr'

(cast_elem = remDr$findElements(using = "css selector", value = cast_css))

cast_val = unlist(sapply(cast_elem, function(x) {x$getElementText()}))

cast_regex2 = "([A-Za-z]+ [A-Za-z]+)(\\s)\\.\\.\\.(\\s)([A-Za-z ]+)"

cast_extract2 = str_extract_all(cast_val,cast_regex2)
castlist_match2 = str_match(cast_extract2, cast_regex2)

castlist_data2 = as.data.frame(castlist_match2)

castlist_data2 = castlist_data2[, c(2,5)]

remDr$close()
rD$server$stop()

###########################################
#=============Create Session==============#
# Create a session to login to canvas	    #
###########################################

library(RSelenium)

canvas_url = "https://stwcas.okstate.edu/cas/login?service=https%3A%2F%2Fcanvas.okstate.edu%2Flogin%2Fcas"
rD = rsDriver(verbose=FALSE, browser = 'firefox', port = 4566L)
remDr = rD$client
remDr$navigate(canvas_url)

remDr$findElement("id", "username")$sendKeysToElement(list("yourusername@okstate.edu"))
remDr$findElement("id", "password")$sendKeysToElement(list("yourpassword", key='enter'))

course_url = 'https://canvas.okstate.edu/courses/51579'

remDr$navigate(course_url)

# Grab the modules for a list of assignments,
# quizzes, documents, videos, etc. using
# CSS selectors; can use xpath as well
module_elem = remDr$findElements(using = "css", "content")
modulelist = unlist(sapply(module_elem, function(x) {x$getElementText()}))

remDr$close()
rD$server$stop()


###########################################
#==========Example Web Scraping===========#
# Scrape Wikipedia data on fuel economy   #
###########################################

library(RSelenium)

wiki_url = 'https://en.wikipedia.org/wiki/National_Highway_Traffic_Safety_Administration'
rD = rsDriver(verbose=FALSE, browser = 'firefox', port = 4566L)
remDr = rD$client
remDr$navigate(wiki_url)

# Use CSS Selectors
td_manuf = remDr$findElements(using = "css", 'div.mw-parser-output>table.wikitable.sortable>tbody>tr>td:nth-child(1)')
td_dom_std = remDr$findElements(using = "css", 'div.mw-parser-output>table.wikitable.sortable>tbody>tr>td:nth-child(2)')
td_dom_cafe = remDr$findElements(using = "css", 'div.mw-parser-output>table.wikitable.sortable>tbody>tr>td:nth-child(3)')
td_dom_cafe_std = remDr$findElements(using = "css", 'div.mw-parser-output>table.wikitable.sortable>tbody>tr>td:nth-child(4)')

# Extract Contents
(manuf_list = unlist(sapply(td_manuf, function(x) {x$getElementText()})))
(dom_std_list = unlist(sapply(td_dom_std, function(x) {x$getElementText()})))
(dom_cafe_list = unlist(sapply(td_dom_cafe, function(x) {x$getElementText()})))
(dom_cafe_std_list = unlist(sapply(td_dom_cafe_std, function(x) {x$getElementText()})))

new_dataframe = data.frame(manuf_list, 
                           dom_std_list, 
                           dom_cafe_list, 
                           dom_cafe_std_list, 
                           stringsAsFactors = FALSE)

remDr$close()
rD$server$stop()


###########################################
#==========Example Web Scraping===========#
# Scrape names from a conference to sell  #
###########################################

library(RSelenium)
library(stringr)

web_url = 'https://icis2019.aisconferences.org/about/conference-committee/'
rD = rsDriver(verbose=FALSE, browser = 'firefox', port = 4566L)
remDr = rD$client
remDr$navigate(web_url)

xp_name = '//section[@class="av_textblock_section "]/div/h3'
person_elem = remDr$findElements(using = "xpath", value = xp_name)
personlist = unlist(sapply(person_elem, function(x) {x$getElementText()}))

xp_credent = '//section[@class="av_textblock_section "]/div/p'
credent_elem = remDr$findElements(using = "xpath", value = xp_credent)
credentlist = unlist(sapply(credent_elem, function(x) {x$getElementText()}))

#====================================================
# personlist and credentlist have differing lengths
# credentlist contains two blanks
#====================================================
length(personlist) == length(credentlist)

#==========================================
# Create vectors to hold the data scraped
# from the website
#==========================================
rip_person = function(name, credent) {
  #name = personlist
  #credent = credentlist
  firstname = vector()
  lastname = vector()
  title = vector()
  email = vector()
  
  pattern_first = '^[A-Za-z]+[:punct:]*[A-Za-z]*\\s'
  pattern_last = '\\s{1}[A-Za-z]+\\s{0,1}[A-Za-z]*'
  pattern_email = '([A-Za-z0-9\\.-]+)@([A-Za-z0-9\\.-]+)\\.(com|edu|de|sg|ch|org|au|dk|kr)'
  
  n = 0
  
  for (i in name) {
    n = n + 1
    firstname[n] = str_extract(str_subset(i, pattern_first), pattern_first)
    lastname[n] = str_extract(str_subset(i, pattern_last), pattern_last)
  }
  
  f = 1
  
  for (t in credent) {
    emailtemp = str_extract(str_subset(t, pattern_email), pattern_email)
    
    if(length(emailtemp != 0))
      email[f] = emailtemp
    if(str_detect(t, '') != FALSE) {
      #cat('Data: "', t, '"\n', 'Email: ', emailtemp, '\n', 'Count: ', f, '\n')
      #cat(str_detect(t, ''), '\n')
      titletemp = str_replace(t, pattern_email, "")
      titletemp = str_replace_all(titletemp, '\n', " ")
      title[f] = titletemp
      f = f + 1
    }
  }
  
  new_dataframe = data.frame(firstname, 
                              lastname, 
                              email, 
                              title, 
                              stringsAsFactors = FALSE)
  
  return(new_dataframe)
}


directory_df = rip_person(personlist, credentlist)

remDr$close()
rD$server$stop()
