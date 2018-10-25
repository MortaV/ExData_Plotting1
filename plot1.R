#downloading the source file and createing a dataset in R

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "data.zip")
unzip("data.zip")
power <- read.csv("household_power_consumption.txt",
                  sep = ";",
                  stringsAsFactors = FALSE)

#converting date and time to the correct type
library(lubridate)
power$Date <- dmy(power$Date)
power$Time <- hms(power$Time)

#eliminating "?" (replacing it with NA) and converting numbers to numeric
power_without_NA <- power
power_without_NA[, 3:8] <- sapply(power_without_NA[, 3:8], 
                                  function(x) ifelse(x == "?", NA , x))
power_without_NA[, 3:8] <- sapply(power_without_NA[, 3:8], 
                                  as.numeric)

#subseting only 1st and second of February

feb12 <- subset(power_without_NA, 
                Date %in% c(ymd("2007-02-01"), ymd("2007-02-02")))

#creating new variable with date and time in one column
feb12$datetime <- feb12$Date + feb12$Time


#openening PNG file device
png(filename = "plot1.png",
    width = 480, 
    height = 480, 
    units = "px")

#histogram of Global active power
hist(feb12$Global_active_power, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     breaks = 20)

#closing PNG file device
dev.off()
