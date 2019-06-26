# Predicting Fremont Bridge Bicycle Crossings

In 2012 the city of Seattle installed induction loop counters on both sides of the Fremont bridge. They detect metal, like bicycles, passing over them every day. The fremont bridge is the main artery from anywhere North of the ship canal into Downtown via Dexter or Westlake. Every day thousands of cyclist commute into downtown and ride across the brdge. I wanted to analyze this data and see what factors played into the number of people crossing the bridge.

The Fremont bridge data has only 3 columns. A datetime filed for the observation and the number of crossings on the East and West side of the bridge. The observations are collected hourly. I knew there was plentiful amounts of Weather data readily available with datetime fields. After collecting the various datasets I would ensure all the datetimes are in pacific time then merge them together to create a dataset of the bridge crossings and Weather observations.

# Data Sources
Fremont Bridge Crossings

https://data.seattle.gov/Transportation/Fremont-Bridge-Hourly-Bicycle-Counts-by-Month-Octo/65db-xm6k

NOAA Daily observations from around seattle

https://www.ncdc.noaa.gov/cdo-web/search

Open weater map Hourly Bulk Data

https://openweathermap.org/

Seattle Air Quality

https://fortress.wa.gov/ecy/enviwa/
https://fortress.wa.gov/ecy/enviwa/StationInfo.aspx?ST_ID=163


# Objectives
How often is the bridge used?

What are some Seattle Weather Trends?

How does temperature and precipitation affect ridership?

What seasonal factors are important, months or days that are more poplular than others?

Can a linear model be fitted to predict the number of crossings?

# How often is the bridge used
One of the first views of this was to resample the hourly fremont data to get total daily crossings and plot as a histogram.

![alt text](https://i.imgur.com/7KPTMlY.png)
EastSide Mean - 1414

WestSide Mean - 1251

Through the entire dataset nearly 3000 riders cross the bridge every day.

Next I wanted to see how seasonality came into play. Plotting a 4 week rolling average made it clear that ridership increases in the summer and decreases in the winter. The lower WestSide crosssings in 2017 and 2018 stuck out as odd.

![alt text](https://i.imgur.com/t2S8vpz.png)

How about hourly, When is the most common time to cross the bridge? It's no suprise that commuting hours of 7-9 AM and 4-7 PM are the most commonly traversed. Also important to notice the difference in morning on evengin commutes. The EastSide of the bridge corresponds to Southbound traffic lanes heading into downtown and Northbound for the west. Though Cyclist go in both directions the generally follow traffic patterns.

![alt text](https://i.imgur.com/dqFbusP.png)

