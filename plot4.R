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

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(df, 
     {
             plot(Global_active_power~datetime, type="l", ylab="Global Active Power (Kilowatts)", xlab = "")
             plot(Voltage~datetime, type= "l", ylab="Voltage (Volt)", xlab="datetime")
             plot(Sub_metering_1~datetime, type="l", ylab="Global Active Power (Kilowatts)", xlab="")
             lines(Sub_metering_2~datetime,col='Red')
             lines(Sub_metering_3~datetime,col='Blue')
             legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
                    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
             plot(Global_reactive_power~datetime, type="l", ylab="Global Rective Power (kilowatts)",xlab="datetime")
     }
     
)

## Save file and close device
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()