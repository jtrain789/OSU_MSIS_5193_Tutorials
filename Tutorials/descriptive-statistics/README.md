# Descriptive Statistics
The purpose of this tutorial is to help you become familiar with performing descriptive statistics. This is an important step in familiarizing yourself with your data so you can better determine what type of analysis to perform later on.

## Module Tasks
Please complete the following tasks:

* :notebook:Read the tutorial documentation for R and Python
* :school:Complete the ICE in class, in groups or individually
* :computer:Complete the THA on your own, individually

## What is Descriptive Statistics?
Traditionally, three distinct phases of analysis are performed on data:
* Descriptive Analysis
* Predictive Analysis
* Prescriptive Analysis

The first phase, descriptive analysis, typically deals with *data understanding* and *data preparation*. This involves identifying the data for a project, collecting the data, assessing the quality of the data, preparing the data (cleaning, transforming, converting), summarizing the data (typically visualizations), and finally selecting the final columns and records. Think of descriptive analysis as a process aimed at describing the data. The other two phases, predictive and prescriptive, are inferential: they attempt to infer or imply meaning from the data. Descriptive analysis merely illustrates what the data is.

The second phase, predictive analysis, applies statistical procedures and techniques to analyzing the subset of data selected from the first phase. This involves developing models that predict or forecast outcomes. Examples of these outcomes include purchasing behavior, identifying favorable drilling sites, flight pathway of an airline, stock market trends, and much more. Models are assessed for viability, reliability, and consistency across contexts and domains.

The third phase, prescriptive analysis, also involves model building, but for a different purpose. These models suggest recommended changes to business processes. Predictive analysis often focuses on what will happen, rather than suggesting what should happen like prescriptive. Many of the statistical models utilized in prescriptive analysis are the same as predictive analysis. 

Notice that the latter two phases rely heavily on the first phase. If the final set of data selected at the end of the descriptive analysis contains errors or the wrong scope for the question asked, then the models developed under the second and third phases will incorrectly answer the question of interest. This is why most of the resources and time for a data analysis are focused on the first phase. Get it wrong, and the rest of the project suffers.

My favorite examples of descriptive analysis includes visualizations. These are graphs, plots, figures, and other visual representations of the data that provide a summarized perspective on the data. Here are some examples.

The data includes tweets from customers pulled from several airlines in the United States. The words from the tweets were categorized by negative, neutral, or positive. For example, "happy" is categorized as positive; "terrible" as negative. The first visualization below provides the counts of the words per airline. Notice that American, United, and US Airways have the highest number of negative words used in tweets from customers. Though, these three airlines also represent a large volume of flights compared to the other airlines.

![img01](/assets/img01.png)

The second visualization is a count of all the words from all the tweets regardless of airline. Not surprisingly, the most frequently occuring word is "flight". 

![img02](/assets/img02.png)

This last visualization is similar to the previous one, except only adjectives are used. Most of them are not surprising.

![img03](/assets/img03.png)

Descriptive statistics and analysis also utilizes count-based or summarizations of the data. These include mean, median, mode, standard deviation, skewness, kurtosis, counts, distributions, minimums, maximums, and many others. Again, these do not infer anything about the data, but describe the characteristics of the data.

The remainder of this tutorial will teach you how to perform various descriptive statistics in R and Python. This tutorial will not cover visualizations. That will come later in another tutorial because it is more complex and a greater creative process.

* [Descriptive Statistics in R](assets/tutorial%20desc%20stats%20in%20r.md)
* [Descriptive Statistics in Python](assets/tutorial%20desc%20stats%20in%20python.md)

The accompanying example script files are found here:
1. [Example R file](assets/desc%20stats%20example.R)
2. [Example Python file](assets/desc%20stats%20example.py)
