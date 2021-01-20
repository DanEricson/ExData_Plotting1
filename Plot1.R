#set working directory for text file
setwd("/Users/dan 1/Desktop/Coursera/Data Science with R/Exploratory Data Analysis with R")

#Establish file type and settings for first plot creation
png(file="Plot1.png", width=480, height=480, units="px")

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

#Creates histogram with 15 breaks, adds title and x-axis label
hist(filtered$Global_active_power, col="red", breaks=15, 
     main="Global Active Power", xlab="Global Active Power (kw)")

#Turn off graphics device
dev.off()