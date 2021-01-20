#set working directory for text file
setwd("/Users/dan 1/Desktop/Coursera/Data Science with R/Exploratory Data Analysis with R")

#Establish file type and settings for fourth plot creation
png(file="Plot4.png", width=480, height=480, units="px")

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

#Set margins for the 4-part plot
par(mfrow=c(2,2), mar=c(4,4,2,2), oma=c(1,1,1,1))

#Includes four plots centering on Global Active Power, Voltage, Energy Sub-
#Metering, and Global Reactive Power
with(filtered, {  plot(datetime, Global_active_power, type="l", col="black", 
                        xlab="", ylab="Global Active Power")
                  plot(datetime, Voltage, type="l", col="black",
                       xlab="", ylab="Voltage")
                  plot(datetime, Sub_metering_1, type="l", col="black", 
                       xlab="", ylab="Energy Sub Metering")
                        points(filtered$datetime, filtered$Sub_metering_2, 
                               type="l", col="red")
                        points(filtered$datetime, filtered$Sub_metering_3, 
                               type="l", col="blue")
                  plot(datetime, Global_reactive_power, type="l", 
                       xlab="Date Time", ylab="Global Reactive Power")
})

#Turn off graphics device
dev.off()