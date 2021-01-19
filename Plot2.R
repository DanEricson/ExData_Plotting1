#set working directory for text file
setwd("/Users/dan 1/Desktop/Coursera/Data Science with R/Exploratory Data Analysis with R")

#set up first plot creation
png(file="Plot2.png", width=480, height=480, units="px")

#create vector of column names to use for data set
col_names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
               "Voltage", "Global_intensity", "Sub_metering_1", 
               "Sub_metering_2", "Sub_metering_3")

#read in dataset with column names and replacing ?s with NAs
power <- read.table(file="household_power_consumption.txt", header = TRUE, 
                    sep=";", col.names = col_names, na.strings="?", 
                    colClasses=c("character", "character", "numeric", "numeric", 
                                 "numeric", "numeric", "numeric", "numeric", 
                                 "numeric"))

#combine the Date and Time columns to create one date-time column for easier
#filtering
power$datetime <- strptime(paste(power$Date, power$Time), 
                           format = "%d/%m/%Y %H:%M:%S")

#filter the dataset for the appropriate date range
filtered <- filter(power, power$datetime >= "2007-02-01 00:00:00" 
                   & power$datetime <= "2007-02-03 00:00:00")

#creates the appropriate line chart
with(filtered, plot(datetime, Global_active_power, xlab="", 
                    ylab="Global Active Power", type="l"))

#Turn off graphics device
dev.off()