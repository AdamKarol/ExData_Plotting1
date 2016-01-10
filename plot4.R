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
png(filename = "plot4.png",width = 480, height = 480, units = "px")
par(mfrow = c(2, 2), mar=c(4,4,2,1))
with(data,{
    plot(Date_Time,Global_active_power, ylab="Global Active Power (kilowatts)",type="n")
    lines(Date_Time,Global_active_power,type = "l")
})
with(data,{
    plot(Date_Time,Voltage, ylab="Voltage",xlab="datetime", type="n")
    lines(Date_Time,Voltage,type = "l")
})
with(data,{
    plot(Date_Time,Sub_metering_1,type="n",ylab="Energy sub metering")
    lines(Date_Time,Sub_metering_1)
    lines(Date_Time,Sub_metering_2,col="red")
    lines(Date_Time,Sub_metering_3, col="blue")
    legend("topright",pch="-",col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})
with(data,{
    plot(Date_Time,Global_reactive_power,xlab="datetime", type="n")
    lines(Date_Time,Global_reactive_power,type = "l")
})
dev.off()
