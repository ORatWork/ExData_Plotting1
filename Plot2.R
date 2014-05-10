##########################################
# Assignment 1 Plot 2 Coursea EDA course
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

#open PNG device

png(filename = "Plot2.png", width = 480, height = 480)

#plot 2, don't plot labels at the x-axis

plot(SubSet$DateTime, SubSet$Global_active_power, type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")

#now, format and add labels to the x-axis

r <- as.POSIXct(round(range(SubSet$DateTime), "days"))
axis.POSIXct(1, at=seq(r[1], r[2], by="day"), format="%a")

dev.off() #close the device

#release memory from remaining objects.

rm(SubSet, r)