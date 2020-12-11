# The First Deliverable
The main purpose of the first deliverable is to plan out the goal, context, and motivation of your project as well as prepare your data for analysis. This is one of the most time consuming aspects of business analytics. You will need to engage in the tasks of data consolidation, data cleaning, data transformation, and data reduction. As you write this, assume I have no previous knowledge of your project. This means if you have words or phrases specific to an industry, business, etc. you need to define it.  

## Title Page (1 pt.)
Provide a project title, list project team members with CWID, and if applicable, sponsor/business associated with your data. 

## Executive Summary (6 pts.)
A short, written overview of the project proposed. This is a managerial statement that should not be more than a half a page long (12 pt font, doubled space). The summary should address the business problem, or opportunity identified, and how the project addresses the problem or opportunity. What are the results and recommendations? Briefly, who does this benefit and how? Identify and briefly explain the potential problem or opportunity. Include any citations supporting why this is important. You may expand what you used in the previous semester. 

## Statement of Scope
Write a statement explaining the scope of the proposed project. Do not just provide me with a list of items. I want full sentences here explaining to me fully what you are discussing. You are creating a report to a manager or potential investor in your project, not creating a to-do list for me. Remember, I can’t read your mind so you need to spell it out for me. This statement should include the following:
* Project objectives (2 pts.): List the objectives you or “the client” hopes to achieve with this (remember objectives must be measurable; keep it short!). List these in a bulleted list. Mention what your sample will be and population you will generalize to (people, traffic tickets per capita, dollars per hour, etc.)
* Variables (3 pts.): Provide an idea of what data you collect can be used as variables. What specific variables are you predicting (i.e. target variables)? What variables lead to those targets (i.e. predictors)? If you have multiple target variables, specify which predictor variables belong to each target variable. 

## Project Schedule (5 pts.)
Provide a GANTT chart which encompasses all of the activities/tasks of all deliverables, including the Final submission. Identify which team member or the whole team performed the activities/tasks. I realize that these tasks and resource assignments are subject to change but at least you will start out with a plan. 

## Data Preparation 
Wherever you use code, please comment inside your code explaining the process. Be specific in labeling your code for its intended purpose; i.e. if the code is for Data Access, then label it as such with a comment. Comments should be understandable to others who have not used the code.

### Data Access (3.5 pts.)
In this section you need to list the sources of your data files. List out all websites and social media platforms. Indicate which data comes from which website. Describe why you are using the sources you chose. If you wrote a web-crawler to parse your own data, instead of APIs provided by social media platform, describe why and how you did this. Include your code in an Appendix as well as a separate file. If the data comes from multiple webpages, then provide the links to the various pages.  

### Data Consolidation (3.5 pts.)
After obtaining your data you will have to consolidate it into a single file. What methods did you choose? If you used SQL queries in R or Python, include them. If you wrote code, please include comments of the code to explain what each part is doing. Include all code in the Appendix.

### Data Cleaning (3.5 pts.)
Prior to or after you have consolidated your data you need to cleanse it to become useful. Please explain what processes you used to cleanse the data. Also, explain the problems in your data. Specifically, address the following:
* columns with missing values and how you handle them
* elimination of erroneous data
* detection of outliers and your response to them
* your response to records with missing values
* adjustments to data types if you import the data into an application

### Data Transformation (3.5 pts.)
In this step of preparing your data you need to take your cleansed data and further enhance its usability for analysis. You will most likely go through this single step multiple times because you will continually update the types of analyses you are performing and will, therefore, update the data accordingly. Please explain the issues you have and how you corrected them. This may include the following:
* normalizing the data
* discretizing or aggregating the data
* constructing new attributes
* transforming text into categories
* log or inverse transformations 

### Data Reduction (3.5 pts.)
This step is not always performed. This step is designed to reduce the size and scope of your dataset. This is done by removing attributes and/or records or combining attributes and/or records. If you did not remove any variables or create any new ones, please state it in your report. A word of caution is needed here. If you are planning on reducing the number of attributes, do not remove them from your data file! Just create a new data file each time.

If you find you need to remove records from your data, you must absolutely justify this with a solid explanation. Any dataset theoretically represents the population you are attempting to assess. By removing records from your data you are stating you do not have need for that segment of the population in your analysis. Justify this. As you make changes, create a secondary, tertiary, etc. file that contains a subset of the records.

### Data Dictionary (Preliminary) (3.5 pts.)
You need to document your data sources and any attributes of the data that you have identified so far. This is done in the data dictionary. The complete data dictionary will be more extensive (you will keep adding to your data throughout the semester), but this will be a good start at documenting. The data dictionary at this point should include all attributes and should have the fields in the example below, at a minimum:

| Attribute Name | Description | Data Type | Source |
|:---|:---|:---:|:---|
| DepartmentID | Unique integer identifier for a department | integer | http://www.company.org |
| DepartmentName | Text description of a department | char(50) | http://www.company.org |
| Address | Physical mailing address of department | char(30) | http://www.company.org |
| EmployeeID | Unique integer identifier for an employee | integer | internal website |
| FirstName | First legal name of employee | char(30) | http://www.web.com/contact |
| LastName | The legal last name of employee | char(30) | http://www.web.com/contact |
| StartDate | Date employee started | datetime | http://hr.web.com/?dept=23 |
