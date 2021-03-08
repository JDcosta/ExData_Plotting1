#Plot2.R
library(readr)
library(lubridate)

data <- read_delim("household_power_consumption.txt", delim=";", na="?", col_names = TRUE,
                   col_types = cols_only(Date = col_date(format = "%d/%m/%Y"), 
                                         Time = col_time(format = "%H:%M:%S"), 
                                         Global_active_power = col_double()),locale = default_locale())

data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
data$datetime <- as.POSIXct(paste(data$Date, data$Time, sep = " "))

## Plot 2

plot(data$Global_active_power~data$datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png, file="Plot2.png", height=480, width=480)

dev.off()