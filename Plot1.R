#Plot1.R
library(readr)
oldwarn <- getOption("warn")
options(warn = -1)

#include the CRAN package readr library
#Download the zip file for the UCI data. Unzip it in the current working direcoty 
#and save it as a text file "household_power_consumption.txt." The Plot1.R file. The result Plot1.png will be placed in
#and the resulting plots Plot1.png will be in the current working directory

#call the read_delim function of readr to read only those columns of the data file
#required for this Plot1 and read the rows of the columns in the proper format.
#For example: the following read statement reads the Date and Time fields in the
#format specified by the argument to cols_types = cols_only( colname = format(colname)...)


data <- read_delim("household_power_consumption.txt", delim=";", na="?", col_names = TRUE,
                   col_types = cols_only(Date = col_date(format = "%d/%m/%Y"), 
                   Time = col_time(format = "%H:%M:%S"), 
                   Global_active_power = col_double()),locale = default_locale())


#Now that the data table "data" has the three required columns and the data in each
#column is in the appropriate format corresponding to the column
#subset the data table "data" to only contain the rows required for this project.

data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#### Test to verify the contents of the data.table or tibble "data"
####data[1:5,]
# A tibble: 5 x 3
#Date       Time   Global_active_power
#    <date>     <time>               <dbl>
#  1 2007-02-01 00'00"               0.326
#  2 2007-02-01 01'00"               0.326
#  3 2007-02-01 02'00"               0.324
#  4 2007-02-01 03'00"               0.324
#  5 2007-02-01 04'00"               0.322

options(warn = oldwarn)

## Plot 1
hist(data$Global_active_power, main="Global Active Power",  xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.copy(png, file="Plot1.png", height=480, width=480)

dev.off()


