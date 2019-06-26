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

# Adding in Weather
The first source for weather data was the NOAA daily observations. I downloaded files for 8 stations around Seattle then averaged the results together to come up with daily totals for Temperature and rainfall between 1/1/2010 and 5/15/2019. Just how often does it rain in Seattle (greater than .1 inches of rain in a day)?

3422 days in the dataset and 1005 were rain days. Nearly 1 in every 3 days (%33.25) it rains in Seattle!

![alt text](https://i.imgur.com/pISvQ1Y.png)

Do cyclist still cross the bridge in the rain? Yes. Ridership decreases in the winter when it rains and snows more, but cyclist still use the bridge every day. 

Point = Number of Daily Crossings
Size = Amount of Precipitaiton on the day
Color = Rain Day true or false
![alt text](https://i.imgur.com/gUcsVN1.png)

Another view of the same plot
Point = Daily Max Temp
Size = Number of Daily Crossings
Color = Rain Day true or false

![alt text](https://i.imgur.com/bkHmFLI.png)

# Daily Weather Regression
My first regression attempt was to use the NOAA daily observations and see how well a model could predict the total number of daily crossings. Along with Precipitation and temperature I made dummy variables out of Month, Day of Week and Is Rain day.
![alt text](https://i.imgur.com/y3vsFXn.png)

Through trial and error I settled on a ridge regression with an alpha of 5. Fitting the model gave the following evaluation metrics for each fo 4 possible y values. The baseline was set by taking the average of a given y.

| y               | EastSide | WestSide | Mean_Xing | Total_Xing |
|-----------------|----------|----------|-----------|------------|
| R**2            | 0.769    | .811     | .835      | .835       |
| Prediction_RMSE | 364.218  | 260.782  | 267.515   | 535.031    |
| Baseline_RMSE   | 759.509  | 600.138  | 658.996   | 1317.993   |


To evaluate the accuracy I used a yellowbrick Residual plot. The crossing value is on the X-axis while Y-axis shos the difference from the true value. Since the predictions roughly fall along the X axis and since the errors are normally distributed I belive this to be a well fitted model.
![alt text](https://i.imgur.com/7WewwI6.png)


# Getting down to Hourly Weather Observations
All the prior data has been based on Daily totals from NOAA. I found two resources to use for hourly WX. The first from open weather map contained fields you would expect (Temp, Precip, Humidity) along with one other that turned out to be fairly important. A textual weather description. For every hour between 10/1/2012 and 6/13/19 (56675 observations) I now had the following descriptions.
![alt text](https://i.imgur.com/H9MUcYZ.png)



