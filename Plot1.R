#Plot1.R
library(readr)

data <- read_delim("household_power_consumption.txt", delim=";", na="?", col_names = TRUE,
                   col_types = cols_only(Date = col_date(format = "%d/%m/%Y"), 
                   Time = col_time(format = "%H:%M:%S"), 
                   Global_active_power = col_double()),locale = default_locale())

data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Plot 1
hist(data$Global_active_power, main="Global Active Power",  xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.copy(png, file="Plotx.png", height=480, width=480)

dev.off()
