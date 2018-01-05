# Install the packages below before running this script
# for the first time
#
# install.packages("dplyr")
# install.packages("prophet")

library(prophet)
library(dplyr)

# set the working directory where the serie.csv has 
# been dowloaded

setwd("C:/Users/Carlos/OneDrive/DS/2018 Prophet")
getwd() 

MonthlyMV <- read.csv("serie.csv", header=TRUE, stringsAsFactors=FALSE)

head(MonthlyMV)

MonthlyMV$Date <- as.Date(MonthlyMV$Date, '%m/%d/%Y')

periods = 50

df <- MonthlyMV[,1:2]

names(df) <- c('ds','y')

model <- prophet(df,weekly.seasonality=TRUE)
future <- make_future_dataframe(model,freq = 'w', periods)

forecast <- predict(model, future)
plot(model, forecast)

Predictions <- data.frame(forecast$ds[(nrow(forecast)-periods):nrow(forecast)],
                 forecast$yhat[(nrow(forecast)-periods):nrow(forecast)],
                 forecast$yhat_lower[(nrow(forecast)-periods):nrow(forecast)],
                 forecast$yhat_upper[(nrow(forecast)-periods):nrow(forecast)])
 
names(Predictions) <- c('Date', 'Price', 'Lower Limit', 'Upper Limit')
print(Predictions)