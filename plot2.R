##Loading the Data
household <- read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings = "?",
                        colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
df <- household

##Transforming the date
df$Date <- as.Date(df$Date, "%d/%m/%Y")

##Filtering the specificis dates
df <- subset(df,Date >= "2007-2-1" & Date <= "2007-2-2")

##Creating the datetime column
datetime <- paste(df$Date, df$Time)
df <- cbind(datetime,df)
df$datetime <- as.POSIXct(datetime)

##Second plot
plot(df$Global_active_power ~ df$datetime, type="l", ylab = "Global Active Power (Kilowatts)", xlab = "")

## Save file and close device
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()