#set you R directory
setwd("D:/Adam Karolewski/Studia podyplomowe/Coursera/Data Science Specialization/Exploratory Data Analysis/Project1")
getwd()

data<-read.csv("./exdata-data-household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";",na.strings = "?")

#take more-less the record where are the records
z=(as.Date("2007-02-01")-as.Date("2006-12-17"))*1440
z=z-1000
#header rows
header<-read.csv("./exdata-data-household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", nrow=1)
header<-colnames(header)
#main data
data<-read.csv("./exdata-data-household_power_consumption/household_power_consumption.txt", sep=";",na.strings = "?",
               skip=z,nrow=5000, col.names=header)

#changing data format as asked
data$Date_Time<-paste(data$Date,data$Time)
data$Date_Time<-as.POSIXct(strptime(data$Date_Time,format="%d/%m/%Y %H:%M:%S"))

data$Date<-as.Date(strptime(data$Date,format="%d/%m/%Y"))
#focusing only on those 2 days
data<-data[data$Date>="2007-02-01" & data$Date<="2007-02-02",]

#creating the plot
png(filename = "plot2.png",width = 480, height = 480, units = "px")
par(mar=c(2,4,2,1))
with(data,plot(Date_Time,Global_active_power, ylab="Global Active Power (kilowatts)",type="n"))
with(data,lines(Date_Time,Global_active_power,type = "l"))
dev.off()
