# Load Libary
library(lubridate)

# Read in Data
  electric <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Create DateTime Column and Change Class for Variables
    # Change Date and Time columns to character
    electric$Date <- as.character(electric$Date)
    electric$Time <- as.character(electric$Time)

    # Create new column in electric data set pasting Date and Time together
    electric <- mutate(electric, DateTime = paste(Date, Time))
    
    # Use luberidate package to covert into appropriate Date data types
    electric$DateTime <- dmy_hms(electric$DateTime)
    electric$Date <- dmy(electric$Date)
    electric$Time <- hms(electric$Time)

# Subset data to the appropriate days Feb 1-2, 2007 and store into new variable feb_days
  feb_days <- subset(electric, Date <= "2007-02-02" & Date >= "2007-02-01")

# Plot 3
  png(filename = "plot3.png", width = 480, height = 480)
  with(feb_days, plot(DateTime, Sub_metering_1, type = "n", 
                      ylab = "Energy sub meeting", xlab = ""))
  with(feb_days, points(DateTime, Sub_metering_1, type = "s"))
  with(feb_days, points(DateTime, Sub_metering_2, type = "s", col = "red"))
  with(feb_days, points(DateTime, Sub_metering_3, type = "s", col = "blue"))
  legend("topright", lty = 1, col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()