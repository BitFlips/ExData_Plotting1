#--------------------------------------------------
# Exploaratory Data Analysis Wk1 Assignment: Plot4
#
# Plot four graphs per plot4 example
#
# Produces an PNG file of plot (480 by 480 pixels)
# from source data url provide by assignment.
# The name of the file is plot4.png
#--------------------------------------------------

#-------------------------------------
# Read file from source and unzip it
#-------------------------------------
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,"zipped.data") 
unzip("zipped.data")

#------------------------------------------------
# Read in file and prune to dates requried,
# which are 2007-02-01 and 2007-02-02 (yy/mm/dd)   
#------------------------------------------------
filename <- "household_power_consumption.txt"
big_din  <- read.table(filename,header=TRUE,sep=";",stringsAsFactors=FALSE)
date1_rows <- grep("^1/2/2007",big_din$Date)    
date2_rows <- grep("^2/2/2007",big_din$Date)
din <- big_din[date1_rows,]
din <- rbind(din,big_din[date2_rows,])
rm(big_din)

#--------------------------------------------
# Do conversions of data
#  1) Convert fields to numeric
#  2) Combine Date and Time into new column
#     New DateTime column is Date class
#--------------------------------------------
din$Global_active_power <- as.numeric(din$Global_active_power)
din$Global_reactive_power <- as.numeric(din$Global_reactive_power)
din$Voltage <- as.numeric(din$Voltage)
din$Sub_metering_1 <- as.numeric(din$Sub_metering_1)
din$Sub_metering_2 <- as.numeric(din$Sub_metering_2)
din$Sub_metering_3 <- as.numeric(din$Sub_metering_3)
x <- paste(din$Date, din$Time)
din$DateTime <- strptime(x,"%d/%m/%Y %H:%M:%S")

#-----------------------------------------
# Open a PNG file device for output plot
#-----------------------------------------
png(filename="plot4.png")

#-----------------------------------------
# Configure for 4 plots on graphics device
#-----------------------------------------
par(mfrow=c(2,2))

#-----------------------------------------------
# Render 1st plot on screen device as specified
#-----------------------------------------------
plot(din$DateTime,din$Global_active_power,type='l',
     xlab="",
     ylab="Global Active Power")
#-----------------------------------------------
# Render 2nd plot on screen device as specified
#-----------------------------------------------
plot(din$DateTime,din$Voltage,type='l',
     xlab="datetime",
     ylab="Voltage")
#-----------------------------------------------
# Render 3rd plot on screen device as specified
#-----------------------------------------------
plot(din$DateTime,din$Sub_metering_1,type='l',
     xlab="",
     ylab="Energy sub metering")
lines(din$DateTime,din$Sub_metering_2,type='l',col="red")
lines(din$DateTime,din$Sub_metering_3,type='l',col="blue")
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=c(1,1,1),bty="n")
#-----------------------------------------------
# Render 4th plot on screen device as specified
#-----------------------------------------------
plot(din$DateTime,din$Global_reactive_power,type='l',
     xlab="datetime",
     ylab="Global_reactive_power")
#----------------------------------------------
# Close the file device to save it in the
# current directory.
#----------------------------------------------
dev.off()
  
