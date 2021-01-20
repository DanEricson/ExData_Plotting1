#set working directory for text file
setwd("/Users/dan 1/Desktop/Coursera/Data Science with R/Exploratory Data Analysis with R")

#Establish file type and settings for third plot creation
png(file="Plot3.png", width=480, height=480, units="px")

#Create a vector of column names to use for data set
col_names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
               "Voltage", "Global_intensity", "Sub_metering_1", 
               "Sub_metering_2", "Sub_metering_3")

#Read in dataset with column names and replacing ?s with NAs
power <- read.table(file="household_power_consumption.txt", header = TRUE, 
                    sep=";", col.names = col_names, na.strings="?", 
                    colClasses=c("character", "character", "numeric", "numeric", 
                                 "numeric", "numeric", "numeric", "numeric", 
                                 "numeric"))

#Combine the Date and Time columns to create one date-time column for easier
#filtering
power$datetime <- strptime(paste(power$Date, power$Time), 
                           format = "%d/%m/%Y %H:%M:%S")

#Filter the dataset for the specified date range
filtered <- filter(power, power$datetime >= "2007-02-01 00:00:00" 
                   & power$datetime <= "2007-02-03 00:00:00")

#Creates the appropriate line chart with additional series added for 
#sub-metering 
with(filtered, plot(datetime, Sub_metering_1, type="l", col="black", 
                    xlab="", ylab="Energy Sub Metering"))
points(filtered$datetime, filtered$Sub_metering_2, type="l", col="red")
points(filtered$datetime, filtered$Sub_metering_3, type="l", col="blue")

#Include a legend
legend("topright", col=c("black", "red", "blue"), lty=1, 
       legend=c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))

#Turn off graphics device
dev.off()