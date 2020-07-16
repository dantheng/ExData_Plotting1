#Exploratory Data Analysis - Course Project 1 
#Plot 1
#Download the Dataset
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "/Users/danieltheng/Desktop/Learning R/Exploratory Data Analysis/ExData_Plotting1/household_power_consumption.zip", 
              method = "curl")
unzip("/Users/danieltheng/Desktop/Learning R/Exploratory Data Analysis/ExData_Plotting1/household_power_consumption.zip")

#Load the Data into R
library(rio)  #load the rio package for importing data
power_consumption <- 
    import("/Users/danieltheng/Desktop/Learning R/Exploratory Data Analysis/ExData_Plotting1/household_power_consumption.txt")
View(power_consumption)

#Subset the dates 2007-02-01 and 2007-02-02
    #Extract only the date and times
dates <- data.frame(power_consumption$Date, power_consumption$Time, row.names = 1:2075259)
    #Find which rows have the dates we want
index <- which(dates$power_consumption.Date %in% "1/2/2007") 
index2 <- which(dates$power_consumption.Date %in% "2/2/2007")
    #Merge the Date and Time into 1 variable 
dates <- unite(dates, col = "Date/Time", sep = " ")
    #Combine the row vector into 1 
index <- c(index, index2)
dates <- dates[index, ]           #Subset the dates we want

library(lubridate)                #Load lubridate to work with dates
Dates.time <- dmy_hms(dates)           #Choose correct fucntion to convert into dates
power_consumption <- power_consumption[index, ] #Subset only the observations we want
power_consumption <- data.frame(Dates.time, power_consumption[ , 3:9]) #Add the new dates/time column
#Convert all the columns to numerics
for(i in 2:8){
    power_consumption[ ,i] <- as.numeric(power_consumption[ ,i])
}

#Constructing the Plot
View(power_consumption)
    #Open png file
png("plot1.png", width = 480, height = 480, units = "px")
#Make Plot
with(power_consumption, hist(Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)"))
    #Close the png file
dev.off()
