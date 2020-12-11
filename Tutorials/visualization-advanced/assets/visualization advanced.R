#===================================================
# The focus of this section of the course is to 
# cover the manipulation of graphics for plots and 
# graphs. Specifically, students will become 
# familiar with color palette selection, plot 
# symbol shape selection, plot and graph legends, 
# background and foreground colors, fonts, 
# cross-hatching, and phase planes (Crawley 
# Chapter 5, 29; R libraries GGPlot2).
#===================================================

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

library(ggplot2)

# GGPlot2 Quick Color Reference
# http://sape.inf.usi.ch/quick-reference/ggplot2/colour
d=data.frame(c=colors(), y=seq(0, length(colors())-1)%%66, x=seq(0, length(colors())-1)%/%66)

ggplot() +
  scale_x_continuous(name="", breaks=NULL, expand=c(0, 0)) +
  scale_y_continuous(name="", breaks=NULL, expand=c(0, 0)) +
  scale_fill_identity() +
  geom_rect(data=d, mapping=aes(xmin=x, xmax=x+1, ymin=y, ymax=y+1), fill="white") +
  geom_rect(data=d, mapping=aes(xmin=x+0.05, xmax=x+0.95, ymin=y+0.5, ymax=y+1, fill=c)) +
  geom_text(data=d, mapping=aes(x=x+0.5, y=y+0.5, label=c), colour="black", hjust=0.5, vjust=1, size=3)


#################################################
#==================Pepper Data==================#
# Scrape the data from the website              #
# https://chasingchilli.com.au/scoville-scale/  #
#################################################

library(RSelenium)
library(stringr)
library(dplyr)
library(forcats)

#install.packages('extrafont')
#extrafont::font_import()
extrafont::loadfonts(device = "win")

web_url = 'https://chasingchilli.com.au/scoville-scale/'
rD = rsDriver(verbose=FALSE, browser = 'firefox', port = 4566L)
remDr = rD$client
remDr$navigate(web_url)

namexp = '//div["tablepress-1_wrapper"]/table/tbody/tr/td[1]'
shuxp = '//div["tablepress-1_wrapper"]/table/tbody/tr/td[2]'

name_elem = remDr$findElements(using = "xpath", value = namexp)
pepperlist = unlist(sapply(name_elem, function(x) {x$getElementText()}))

shu_elem = remDr$findElements(using = "xpath", value = shuxp)
shulist = unlist(sapply(shu_elem, function(x) {x$getElementText()}))

shunits = vector()
pungency = vector()
pattern_shu = '[:blank:]SHUs$'
n = 0
for (i in shulist) {
  n = n + 1
  shunits[n] = as.numeric(str_replace(i, pattern_shu, ''))
  if(shunits[n]>79999)
    pungency[n] = 'Very Highly Pungent'
  else if(shunits[n]>24999)
    pungency[n] = 'Highly Pungent'
  else if(shunits[n]>2999)
    pungency[n] = 'Moderately Pungent'
  else if(shunits[n]>699)
    pungency[n] = 'Mildly Pungent'
  else
    pungency[n] = 'Non-Pungent'
}

pungency = as.factor(pungency)
pepper_df = data.frame(pepperlist, 
                       shunits,
                       pungency,
                       stringsAsFactors = FALSE)

# Remove the top 5 rows because they are not peppers
pepper_df = pepper_df[-c(1,2,3,4,5),]

remDr$close()
rD$server$stop()

pepper_df$shunits


###############################################
#=============Building a Boxplot==============#
# Create a boxplot to display the data from   #
# the pepper data.                            #
###############################################

#Plot the data
ggplot(pepper_df, aes(x=pungency, y=shunits)) +
  geom_boxplot()

# Sort the data
pepper_sort = pepper_df %>%
  mutate(pungency = fct_reorder(pungency, -shunits))

ggplot(pepper_sort, aes(x=pungency, y=shunits)) +
  geom_boxplot()


# Flip the coordinates
pepper_sort %>%
  ggplot(aes(x=pungency, y=shunits)) +
  coord_flip() +
  geom_boxplot()

# Sort the data once more
# Remove outliers
pepper_sort %>%
  mutate(pungency = fct_reorder(pungency, shunits)) %>%
  ggplot(aes(x=pungency, y=shunits)) +
  coord_flip() +
  geom_boxplot(outlier.shape = NA)

# Adjust the scale to reduce width
pepper_sort %>%
  mutate(pungency = fct_reorder(pungency, shunits)) %>%
  ggplot(aes(x=pungency, y=shunits)) +
  coord_flip() +
  scale_y_continuous(limits=c(0,500000)) +
  geom_boxplot(outlier.alpha = 0)

# The warning indicates 21 data points were
# removed by forcing a scale limit
pungency_data = pepper_df %>%
  filter(shunits <= 500000)
# Result: Identify other data points
# the program does not consider outliers

pungency_data


#==========================================================
# Add color by pungency, adjust scale, add a light theme
# for the background color, add labels, remove the legend
#==========================================================
pepper_sort = pungency_data %>%
  mutate(pungency = fct_reorder(pungency, shunits)) %>%
  ggplot(aes(x=pungency, y=shunits, color=pungency)) +
  coord_flip() +
  scale_y_continuous(limits=c(0,500000)) +
  theme_light(base_size = 15) +
  labs(
    x='',
    y='Median Pungency'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  ) +
  geom_boxplot(outlier.alpha = 0) +
  geom_point(size = 3, alpha = 0.15)

pepper_sort

#======================================
# Use theme to render different plots
#======================================
pepper_theme = 
  ggplot(pungency_data, aes(x=pungency, y=shunits, color=pungency)) +
  coord_flip() +
  scale_y_continuous(limits=c(0,500000)) +
  theme_light(base_size = 15) +
  labs(
    x='',
    y='Median Pungency'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  )

pepper_theme + 
  geom_boxplot(outlier.alpha = 0,
               color='gray20') +
  geom_point(size = 3, alpha = 0.15)

pepper_theme + 
  geom_boxplot(outlier.alpha = 0,
               color='gray50') +
  geom_point(size = 3, alpha = 0.15)

pepper_theme + 
  geom_boxplot(outlier.alpha = 0,
               color='gray90') +
  geom_point(size = 3, alpha = 0.15)

pepper_theme +
  geom_line(size=2)

pepper_theme +
  geom_point(size=3)


#================================================
# The data is tightly packed, use geom_jitter()
# to tease the data apart sideways
#================================================
pepper_theme +
  geom_jitter(size=3, alpha=0.15, width = 0.2)

pepper_theme +
  geom_jitter(size=3, alpha=0.15, width = 0.4)

# Note: every time the geom_hitter() is run
# the data is randomly output
pepper_theme +
  geom_jitter(size=3, alpha=0.15, width = 0.4)

pepper_theme +
  geom_jitter(size=3, alpha=0.15, width = 0.4)

pepper_theme +
  geom_jitter(size=3, alpha=0.15, width = 0.4)

# To fix this problem, use set.seed()
set.seed(54321)
pepper_theme +
  geom_jitter(size=3, alpha=0.15, width = 0.4)

set.seed(54321)
pepper_theme +
  geom_jitter(size=3, alpha=0.15, width = 0.4)

set.seed(54321)
pepper_theme +
  geom_jitter(size=3, alpha=0.15, width = 0.4)


#============================================
# Where is the median? Adding in a summary 
# statistic into the plot. First, generate 
# the median scores for each pungency group
# and then the overall median for the
# entire dataset.
#============================================

# Pungency Median
pungency_data2 = pungency_data %>% 
  group_by(pungency) %>% 
  mutate(med_pungency = median(shunits, na.rm = T)) %>%
  ungroup()

unique(pungency_data2$med_pungency)

# Overall Median
pepper_med = pungency_data2 %>% 
  summarise(avg = median(shunits)) %>%
  pull(avg)

pepper_med

# Create a new theme to use the new data
pepper_theme2 = 
  ggplot(pungency_data2, aes(x=pungency, y=shunits, color=pungency)) +
  coord_flip() +
  scale_y_continuous(limits=c(0,500000)) +
  theme_light(base_size = 15) +
  labs(
    x='',
    y='Median Pungency'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    plot.title = element_text(size=14,
                              face = 'bold',
                              lineheight = 0.8)
  )


set.seed(54321)
pepper_theme2 +
  geom_jitter(size=3, alpha=0.15, width = 0.4) +
  stat_summary(fun.y = median,
               geom = 'point',
               size=6.3)


# Add in the median for shunits
set.seed(54321)
pepper_theme2 +
  geom_hline(aes(yintercept = pepper_med), 
             color = "chartreuse2", 
             size = 0.8) +
  geom_jitter(size=3, alpha=0.15, width = 0.4) +
  stat_summary(fun.y = median,
               geom = 'point',
               size=6.3)


set.seed(54321)
pepper_theme2 +
  geom_segment(aes(x=pungency,
                   xend=pungency,
                   y=pepper_med,
                   yend=med_pungency),
               size=0.8) +
  geom_hline(aes(yintercept = pepper_med), 
             color = "gray80", 
             size = 0.8) +
  geom_jitter(size=3, alpha=0.15, width = 0.4) +
  stat_summary(fun.y = median,
               geom = 'point',
               size=6.3)


#==============================
# Annotate the plot to
# insert descriptive elements
#==============================
set.seed(54321)
pepper_text = pepper_theme2 +
  geom_segment(aes(x=pungency,
                   xend=pungency,
                   y=pepper_med,
                   yend=med_pungency),
               size=0.8) +
  geom_hline(aes(yintercept = pepper_med), 
             color = "gray80", 
             size = 0.8) +
  geom_jitter(size=3, alpha=0.15, width = 0.4) +
  stat_summary(fun.y = median,
               geom = 'point',
               size=6.3) +
  annotate('text', x = 3.5, y = 100000, size = 2.7, color = 'gray20',
           label = glue::glue('Worldwide Average:\n{round(pepper_med, 1)} SHU')) +
  annotate('text', x = 4.3, y = 300000, size = 2.7, color = 'gray20',
           label = glue::glue('Very Highly Pungent\nhas the highest SHU'))
  
pepper_text


arrows = tibble(
  x1 = c(3.2, 4.3),
  y1 = c(100000, 360000),
  x2 = c(2.4, 4.7),
  y2 = c(pepper_med, 450000)
)

# If you wrap the entire thing in parentheses
# You do not have to type pepper_text to run it
(pepper_text + geom_curve(data = arrows, 
                         aes(x = x1, y = y1, xend = x2, yend = y2),
                         arrow = arrow(length = unit(0.07, 'inch')), 
                         size = 0.4,
                         color = 'gray20', 
                         curvature = 0.3))


#===================================
# Adjusting the Legend of the plot
#===================================
(pepper_theme3 = 
  ggplot(pungency_data2, aes(x=pungency, y=shunits, color=pungency)) +
  coord_flip() +
  scale_y_continuous(limits=c(0,500000)) +
  theme_light(base_size = 15) +
  labs(
    x='',
    y='Median Pungency',
    color = 'Pungency Levels'
  ) +
  theme(
    legend.title = element_text(family = 'Arial',
                                color = 'wheat3',
                                size = 10),
    legend.position = 'bottom',
    legend.text = element_text(size = 8),
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_blank(),
    plot.title = element_text(size=14,
                              face = 'bold',
                              lineheight = 0.8)
  ) +
  geom_segment(aes(x=pungency,
                   xend=pungency,
                   y=pepper_med,
                   yend=med_pungency),
               size=0.8) +
  geom_hline(aes(yintercept = pepper_med), 
             color = "gray80", 
             size = 0.8) +
  geom_jitter(size=3, alpha=0.15, width = 0.4) +
  stat_summary(fun.y = median,
               geom = 'point',
               size=6.3) +
  annotate('text', x = 3.5, y = 100000, size = 2.7, color = 'gray20',
           label = glue::glue('Worldwide Average:\n{round(pepper_med, 1)} SHU')) +
  annotate('text', x = 4.3, y = 300000, size = 2.7, color = 'gray20',
           label = glue::glue('Very Highly Pungent\nhas the highest SHU')) +
  geom_curve(data = arrows, 
             aes(x = x1, y = y1, xend = x2, yend = y2),
             arrow = arrow(length = unit(0.07, 'inch')), 
             size = 0.4,
             color = 'gray20', 
             curvature = 0.0)
)


# Alternative for editing legend text
(pepper_theme4 = 
    ggplot(pungency_data2, aes(x=pungency, y=shunits, color=pungency)) +
    coord_flip() +
    scale_y_continuous(limits=c(0,500000)) +
    theme_light(base_size = 15) +
    labs(
      x='',
      y='Median Pungency'
    ) +
    theme(
      legend.title = element_text(family = 'Arial',
                                  color = 'wheat3',
                                  size = 10),
      legend.position = 'bottom',
      legend.text = element_text(size = 8),
      panel.grid = element_blank(),
      axis.title = element_text(size = 10),
      axis.text.x = element_text(size = 10),
      axis.text.y = element_blank(),
      plot.title = element_text(size=14,
                                face = 'bold',
                                lineheight = 0.8)
    ) +
    scale_color_discrete("Pungency\nLevels:", 
                         labels = c('Highly\nPungent',
                                    'Mildly\nPungent',
                                    'Moderately\nPungent',
                                    'Non-Pungent',
                                    'Very Highly\nPungent')) +
    geom_segment(aes(x=pungency,
                     xend=pungency,
                     y=pepper_med,
                     yend=med_pungency),
                 size=0.8) +
    geom_hline(aes(yintercept = pepper_med), 
               color = "gray80", 
               size = 0.8) +
    geom_jitter(size=3, alpha=0.15, width = 0.4) +
    stat_summary(fun.y = median,
                 geom = 'point',
                 size=6.3) +
    annotate('text', x = 3.5, y = 100000, size = 2.7, color = 'gray20',
             label = glue::glue('Worldwide Average:\n{round(pepper_med, 1)} SHU')) +
    annotate('text', x = 4.3, y = 300000, size = 2.7, color = 'gray20',
             label = glue::glue('Very Highly Pungent\nhas the highest SHU')) +
    geom_curve(data = arrows, 
               aes(x = x1, y = y1, xend = x2, yend = y2),
               arrow = arrow(length = unit(0.07, 'inch')), 
               size = 0.4,
               color = 'gray20', 
               curvature = 0.0)
)


(pepper_theme5 = 
    ggplot(pungency_data2, aes(x=pungency, y=shunits, color=pungency)) +
    coord_flip() +
    scale_y_continuous(limits=c(0,500000)) +
    theme_light(base_size = 15) +
    labs(
      x='',
      y='Median Pungency'
    ) +
    theme(
      legend.title = element_text(family = 'Arial',
                                  color = 'wheat3',
                                  size = 10),
      legend.position = 'bottom',
      legend.text = element_text(size = 8),
      panel.grid = element_blank(),
      axis.title = element_text(size = 10),
      axis.text.x = element_text(size = 10),
      axis.text.y = element_blank(),
      plot.title = element_text(size=14,
                                face = 'bold',
                                lineheight = 0.8)
    ) +
    scale_color_discrete("", 
                         labels = c('Highly\nPungent',
                                    'Mildly\nPungent',
                                    'Moderately\nPungent',
                                    'Non-Pungent',
                                    'Very Highly\nPungent')) +
    geom_segment(aes(x=pungency,
                     xend=pungency,
                     y=pepper_med,
                     yend=med_pungency),
                 size=0.8) +
    geom_hline(aes(yintercept = pepper_med), 
               color = "gray80", 
               size = 0.8) +
    geom_jitter(size=3, alpha=0.15, width = 0.4) +
    stat_summary(fun.y = median,
                 geom = 'point',
                 size=6.3) +
    annotate('text', x = 3.5, y = 100000, size = 2.7, color = 'gray20',
             label = glue::glue('Worldwide Average:\n{round(pepper_med, 1)} SHU')) +
    annotate('text', x = 4.3, y = 300000, size = 2.7, color = 'gray20',
             label = glue::glue('Very Highly Pungent\nhas the highest SHU')) +
    geom_curve(data = arrows, 
               aes(x = x1, y = y1, xend = x2, yend = y2),
               arrow = arrow(length = unit(0.07, 'inch')), 
               size = 0.4,
               color = 'gray20', 
               curvature = 0.0)
)


#===================================
# The scale of Very Highly Pungent
# is still too large. Alternative
# plot to improve?
#===================================
pepper_theme6 = 
  ggplot(pungency_data2, aes(x=pungency, y=shunits, color=pungency)) +
  theme_light(base_size = 15) +
  labs(y='Median Pungency') +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    plot.title = element_text(size=14,
                              face = 'bold',
                              lineheight = 0.8)
  ) +
  geom_jitter(size=3, alpha=0.15, width = 0.4)

pepper_theme6 + 
  facet_wrap(~ pungency,
             nrow = 1,
             scales = 'free') +
  theme(strip.text = element_blank())


# https://ggplot2tutor.com/simple_barchart_with_p_values/barchart_simple/
# https://github.com/jennadv/MakeoverMonday/tree/master/SF%20Evictions