##########################################
# Assignment 1 Plot 1 Coursea EDA course
##########################################
#
# By ORatWork
#
# Created 		: 2014 05 05
# Last revision 	: 2014 05 08 
#
#
##########################################

# read the data from file in to temporary data frame, used to proces data
# add columns after which it is subsettet to data from 1/2/2007 and 2/2/2007 

RawData<-read.csv(file.choose(), 
			header=TRUE, sep=";", na.strings=c("",".","NA", "?"))

# Convert Date string to Date format 

RawData$Date<-as.Date(RawData$Date, "%d/%m/%Y")

#subset the data to fit the periode we are interested in 

SubSet<-RawData[which(RawData$Date==as.Date("1/2/2007", "%d/%m/%Y") | 
			    RawData$Date==as.Date("2/2/2007", "%d/%m/%Y")),]

#Release the memory for the RawData, we don't need it anymore
rm(RawData)

#plot 1 

#open graph device and create Plot1.png file

png(filename = "Plot1.png", width = 480, height = 480)

hist(SubSet$Global_active_power,col="red", 
					  ylab="Frequency", xlab="Global Active Power (kilowatts)", 
					  main="Global Active Power") 

dev.off() #close the device
