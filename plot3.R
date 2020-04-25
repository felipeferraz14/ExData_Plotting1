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

## Third Plot
with(df, {
        plot(Sub_metering_1~datetime, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~datetime,col='Red')
        lines(Sub_metering_3~datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save file and close device
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()