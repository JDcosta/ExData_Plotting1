library(readr)
library(lubridate)

data <- read_delim("household_power_consumption.txt", delim=";", na="?", 
                   col_names = c("Date","Time","Global_active_power",
                   "Global_reactive_power","Voltage","Global_intensity",
                   "Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                   col_types = cols_only(Date = col_date(format = "%d/%m/%Y"), 
                   Time = col_time(format = "%H:%M:%S"),
                   Global_active_power = col_double(),
                   Sub_metering_1 = col_double(),Sub_metering_2 = col_double(),
                   Sub_metering_3 = col_double()),locale = default_locale())

data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- as.POSIXct(paste(data$Date, data$Time, sep = " "))

## Plot 3
# calling the basic plot functions
with(data, {
  plot(Sub_metering_1~datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
})

dev.copy(png, file="Plot3.png", height=480, width=480)

dev.off()