##########################################
# Assignment 1 Plot 3 Coursea EDA course
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

#plot 3

#make sure that the axis scale is set to capture the range of all series

yrange<-range(c(SubSet$Sub_metering_1,SubSet$Sub_metering_2,SubSet$Sub_metering_3))

#open PNG device

png(filename = "Plot3.png", width = 480, height = 480)


#creacte plot, but no x-axis 

plot(SubSet$DateTime, SubSet$Sub_metering_1, type="l", 
			xaxt="n", xlab="", 
			ylab="Energy sub metering",
			ylim=yrange)

#add additional series

lines(SubSet$DateTime, SubSet$Sub_metering_2, type="l", col="red")
lines(SubSet$DateTime, SubSet$Sub_metering_3, type="l", col="blue")

#now, format and add labels to the x-axis

r <- as.POSIXct(round(range(SubSet$DateTime), "days"))
axis.POSIXct(1, at=seq(r[1], r[2], by="day"), format="%a")

#add legend 

legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
lty=c(1,1,1), lwd=c(2.5,2.5, 2.5),col=c("black","red","blue")) 

dev.off() #close the device

#release the memory from all remaining objects

rm(SubSet, r, yrange)

