library(readr)
library(lubridate)

data <- read_delim("household_power_consumption.txt", delim=";", na="?", 
                   col_names = c("Date","Time","Global_active_power",
                                 "Global_reactive_power","Voltage","Global_intensity",
                                 "Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                   col_types = cols_only(Date = col_date(format = "%d/%m/%Y"), 
                                         Time = col_time(format = "%H:%M:%S"),
                                         Global_active_power = col_double(),
                                         Global_reactive_power = col_double(),
                                         Voltage = col_double(),
                                         Global_intensity = col_double(),
                                         Sub_metering_1 = col_double(),Sub_metering_2 = col_double(),
                                         Sub_metering_3 = col_double()),locale = default_locale())

data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- as.POSIXct(paste(data$Date, data$Time, sep = " "))

## Plot 4
# calling the basic plot functions
par(mfrow = c(2, 2), mar = c(4,4,2,1), oma = c(0, 0, 1, 0))

with(data, {
  
  plot(Global_active_power~datetime, type="l",
       ylab="Global Active Power", xlab="")
  
  plot(datetime, Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  plot(Sub_metering_1~datetime, type="l",
       ylab="Global Active Power", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, bty= "n", 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex = 0.5)
  
  plot(datetime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
})

dev.copy(png, file="Plot4.png", height=480, width=480)

dev.off()