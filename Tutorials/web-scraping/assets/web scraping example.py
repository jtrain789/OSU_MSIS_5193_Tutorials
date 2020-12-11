#############################################
#=============Read in Libraries=============#
# Read in the necessary libraries.          #
#############################################

import pandas as pd

from lxml import html
from lxml import etree

import requests
import urllib3

# An alternative for scraping static pages;
# this cannot use CSS selectors or XPath
# selectors
#from bs4 import BeautifulSoup

#############################################
#===============Read in data================#
# Read in the data from imdb.com    	    #
#############################################

#============================================
# Connect to the webpage for Princess Bride
#============================================
imdburl = "https://www.imdb.com/title/tt0093779/"

resp = requests.get(imdburl)

# Alternative
httpmng = urllib3.PoolManager()
resp2 = httpmng.request('GET', imdburl)


#=====================================
# Create a lxml object to pull data
#=====================================
tagtree = html.fromstring(resp.content)

# Alternative
tagtree2 = html.fromstring(resp2.data)


#======================================================
# Extracting data from the webpage; 
# Sometimes, errors occur from copying the XPath
# from the browser will not work here; this is
# because the libraries requests and urllib3 pull the
# html prior to it being rendered by the web browser.
# Often, web browsers will insert new tags into the
# source code to make it more readable; thus, html
# tags that the developer did not place in the code
# are inserted by the browser;
#======================================================
xp1 = '//div[@class="ratingValue"]/strong/span/text()'

imdb_rating = tagtree.xpath(xp1)
imdb_rating


#========================================================
# Extracting a table from wikipedia on Intel processors
#========================================================
i7url = 'https://en.wikipedia.org/wiki/List_of_Intel_Core_i7_microprocessors'
resp3 = requests.get(i7url)
tagtree3 = html.fromstring(resp3.content)

i7xp = '//div[@class="mw-content-ltr"]/div[@class="mw-parser-output"]/table[2]'

i7table = tagtree3.xpath(i7xp)

#============================================
# Convert to a string for Pandas to read;
# then convert to html and then a dataframe
#============================================
tstring = etree.tostring(i7table[0], method='html')
i7lists = pd.read_html(tstring)
i7data = pd.DataFrame(i7lists[0])
i7data.dtypes


#############################################
#===============Read in data================#
# Use the library Selenium to scrape web    #
# data                                      #
#############################################
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
driver = webdriver.Firefox(executable_path=r'C:\Users\bryan\Documents\geckodriver.exe')

canvas_url = 'https://stwcas.okstate.edu/cas/login?service=https%3A%2F%2Fcanvas.okstate.edu%2Flogin%2Fcas'
driver.get(canvas_url)

canv_username = driver.find_element_by_id('username')
canv_password = driver.find_element_by_id('password')
canv_submit = driver.find_element_by_name('submit')

canv_username.send_keys('username@okstate.edu')
canv_password.send_keys('yourpassword')
canv_submit.submit()

canvas_url = 'https://canvas.okstate.edu/courses/51579'
driver.get(canvas_url)

# Grab the modules for a list of assignments,
# quizzes, documents, videos, etc. using
# CSS selectors
module_elem = driver.find_element_by_css_selector('.content')
module_elem.text

driver.quit()
