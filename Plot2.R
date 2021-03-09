#Plot2.R
library(readr)

oldwarn <- getOption("warn")
options(warn = -1)

#as explained in detail in the comments in Plot1.R, this file Plot2.R also 
#uses the read_delim function from the readr package to read the txt file such
#that only those columns needed for the plot2 are read in and the rows in those 
#columns are read in the correct format specified by the user

data <- read_delim("household_power_consumption.txt", delim=";", na="?", col_names = TRUE,
                   col_types = cols_only(Date = col_date(format = "%d/%m/%Y"), 
                                         Time = col_time(format = "%H:%M:%S"), 
                                         Global_active_power = col_double()),locale = default_locale())

#subset the data table (Tibble) to get a data table with only the required rows
data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#create a datetime object from the Date and Time objects
data$datetime <- as.POSIXct(paste(data$Date, data$Time, sep = " "))

options(warn = oldwarn)

## Plot 2
#create the basic plot 
plot(data$Global_active_power~data$datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png, file="Plot2.png", height=480, width=480)

dev.off()