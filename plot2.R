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

# Plot 2: Global Active Power Thu - Sat
  png(filename = "plot2.png", width = 480, height = 480)
  with(feb_days, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
  dev.off()