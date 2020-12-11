# Fundamentals of Data Visualization
The human mind is highly dependent on visual cues and imagery to understand the world. Biologically, our eyes focus on specific shapes. For example, some of our visual neurons are attuned to facial shapes; others, for diagonal lines. Our ability to digest visual data is quicker than through conceptual means such as reading. This is why presenting data in a visual manner is so desirable. As the saying goes, a picture is worth a thousand words. In this module, you will learn how to create basic visualizations.

## Two Variables
The basic relationship in science is between two variables. When plotting these variables, typically the response or target variable is on the *y*-axis and the explanatory variable is on the *x*-axis. The response variable is the one that changes based on what the target is doing. In this tutorial you will learn about six different types of plots for two variables. 

The table below summarizes these. The first column contains the name of the plot. The second column contains the type of data that should be used for that plot. This is important to understand. Visualization is about telling a story. Certain plots utilize specific types of data better than other types.

| Plot Name | Explanatory Variable |
|:---|:---|
| Scatterplot | Continuous |
| Histogram | Continuous |
| Box Plot | Categorical |
| Bar Chart (aka Bar Graph) | Categorical or Discrete |
| Line Chart | Time-Ordered |

The decision to use a specific plot is largely determined by the type of data your explanatory variable is as well as the message you wish to convey. For example, if you would like to show the relationship between height and points scored for NBA players, you would use a scatterplot or histogram. A scatterplot shows a simple relationship between the two variables while a histogram would show the relationship based on binning or "buckets" (i.e. range of data).

In the below tutorials, I will provide examples of creating plots for the three types of explanatory variables: continuous, categorical, and time-ordered.
* [Visualization in R](assets/tutorial%20visualization%20fundamentals%20in%20r.md)
* [Visualization in Python](assets/tutorial%20visualization%20fundamentals%20in%20python.md)

The accompanying example script files are found here:
1. [Example R file](assets/visualization%20fundamentals%20example.R)
1. [Example Python file](assets/visualization%20fundamentals%20example.py)