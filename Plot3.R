#Plot3.R
library(readr)

oldwarn <- getOption("warn")
options(warn = -1)
options(readr.num_columns = 0)

##as explained in detail in the comments in Plot1.R, this file Plot3.R also 
#uses the read_delim function from the readr package to read the txt file such
#that only those columns needed for the plot2 are read in and the rows in those 
#columns are read in the correct format specified by the user

data <- read_delim("household_power_consumption.txt", delim=";", na="?", 
                   col_names = c("Date","Time","Global_active_power",
                   "Global_reactive_power","Voltage","Global_intensity",
                   "Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                   col_types = cols_only(Date = col_date(format = "%d/%m/%Y"), 
                   Time = col_time(format = "%H:%M:%S"),
                   Global_active_power = col_double(),
                   Sub_metering_1 = col_double(),Sub_metering_2 = col_double(),
                   Sub_metering_3 = col_double()),locale = default_locale())

#subset the data table (Tibble) to get a data table with only the required rows
data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#create a datetime object from the Date and Time objects
datetime <- as.POSIXct(paste(data$Date, data$Time, sep = " "))

options(warn = oldwarn)

## Plot 3
# calling the basic plot functions 
# and re-sizing the legend display
par(mfrow = c(1, 1), mar = c(4,4,2,1), oma = c(0, 0, 1, 0))

with(data, {
  plot(Sub_metering_1~datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.7)
  
})

dev.copy(png, file="Plot3.png", height=480, width=480)

dev.off()