##########################################
# Assignment 1 Plot 4 Coursea EDA course
##########################################
#
# By ORatWork
#
# Created 		: 2014 05 05
# Last revision 	: 2014 05 10 
#
#
##########################################

# read the data from file in to temporary data frame, used to proces data
# add columns after which it is subsettet to data from 1/2/2007 and 2/2/2007 

RawData<-read.csv(file.choose(), 
			header=TRUE, sep=";", na.strings=c("",".","NA", "?"))

# Combine Date and Time factor fields to one DateTime collumn
# paste() used to create on CharString, that is than converted into a POSIXct collumn using strptime()

RawData$DateTime<-strptime( paste(RawData$Date, RawData$Time, sep=" ") ,"%d/%m/%Y %H:%M:%S")

# Convert Date string to Date format 

RawData$Date<-as.Date(RawData$Date, "%d/%m/%Y")

#subset the data to fit the periode we are interested in 

SubSet<-RawData[which(RawData$Date==as.Date("1/2/2007", "%d/%m/%Y") | 
			    RawData$Date==as.Date("2/2/2007", "%d/%m/%Y")),]
SubSet$DateTime<-as.POSIXct(SubSet$DateTime)

#Release the memory for the RawData, we don't need it anymore
rm(RawData)

#plot 4

#prepare format for x axis for date/time for all plots
r <- as.POSIXct(round(range(SubSet$DateTime), "days"))

# set yrange for the Energy sub metering plot
yrange<-range(c(SubSet$Sub_metering_1,SubSet$Sub_metering_2,SubSet$Sub_metering_3))

#open PNG device

png(filename = "Plot4.png", width = 480, height = 480)

# set canvas to 2x2 format
par(mfrow = c(2,2))

with(SubSet, {

#global active power plot

plot(DateTime, Global_active_power, type="l", xaxt="n", xlab="", ylab="Global Active Power")
axis.POSIXct(1, at=seq(r[1], r[2], by="day"), format="%a")

# voltage plot

plot(DateTime, Voltage, type="l", xaxt="n", xlab="datatime", ylab="Voltage")
axis.POSIXct(1, at=seq(r[1], r[2], by="day"), format="%a")

# sub metering plot

plot(DateTime, Sub_metering_1, type="l", 
			xaxt="n", xlab="", 
			ylab="Energy sub metering",
			ylim=yrange)
lines(DateTime, Sub_metering_2, type="l", col="red")
lines(DateTime, Sub_metering_3, type="l", col="blue")
axis.POSIXct(1, at=seq(r[1], r[2], by="day"), format="%a")
legend("topright", bty="n", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
lty=c(1,1,1), lwd=c(2.5,2.5, 2.5),col=c("black","red","blue")) 

# Global_reactive_power plot

plot(DateTime, Global_reactive_power, type="l", xaxt="n", xlab="datatime", ylab="Global_reactive_power")
axis.POSIXct(1, at=seq(r[1], r[2], by="day"), format="%a")

})

# reset format to default
par(mfrow = c(1,1))

dev.off() #close the device

#release the memory from all remaining objects

rm(SubSet, r, yrange)


