#--------------------------------------------------
# Exploaratory Data Analysis Wk1 Assignment: Plot1
#
# Plot of Fequency vs Global Active Power
#
# Produces an PNG file of plot (480 by 480 pixels)
# from source data url provide by assignment.
# The name of the file is plot1.png
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

#-----------------------------------------
# Convert Global_active_power column class
# from character to numeric
#-----------------------------------------
din$Global_active_power <- as.numeric(din$Global_active_power)

#-----------------------------------------
# Open a PNG file device for output plot
#-----------------------------------------
png(filename="plot1.png")

#---------------------------------------------
# Plot the histogram with appropriate labels
#---------------------------------------------
hist(din$Global_active_power,col="red",breaks=20,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

#----------------------------------------------
# Close the file device to save it in the
# current directory.
#----------------------------------------------
dev.off()
  
