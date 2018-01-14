packages <- c("gsubfn", "ggplot2")
file_path <- paste(getwd(), "/CourseraDataScience/Exploratory Data Analysis/household_power_consumption.txt", sep="")
if (files.exists(file_path)){
    hpc_data <- fread(file_path)
}

#filter data, only keep data from 2/1/2007 - 2/2/2007
hpc_data <- hpc_data[grepl("^[12]\\/2\\/2007$", Date)]

idx <- names(hpc_data[,Global_active_power: Sub_metering_3])
hpc_data[, (idx) := lapply(.SD, as.numeric), .SDcols=idx]
hpc_data[, Date := as.Date(Date, format="%d/%m/%Y"]
hpc_data[, DateTime := as.POSIXct(paste(Date, Time))]

#plot1
plot1 <- function(){
    png(filename="plot1.png", width=480, height=480)
    hist(hpc_data$Global_active_power,main = "Global Active Power", col="red",xlab="Global Active Power (kilowatts)")
    dev.off()
}
plot2 <- function(){
    png(filename="plot2.png", width=480, height=480)
    plot(hpc_data$DateTime, hpc_data$Global_active_power, type="l" xlab="", ylab="Global Active Power (kilowatts)")
    dev.off()
}
plot3 <- function(){
    png(filename="plot3.png", width=480, height=480)
    ggplot(data=hpc_data, aes(DateTime)) + geom_line(aes(y=Sub_metering_1, colour="Sub_metering_1")) + geom_line(aes(y=Sub_metering_2, colour="Sub_metering_2")) + geom_line(aes(y=Sub_metering_3, colour="Sub_metering_3"))  + scale_x_datetime(breaks =c(as.POSIXct("2007-02-01 00:00:00 CST"), as.POSIXct("2007-02-02 00:00:00 CST"), as.POSIXct("2007-02-03 00:00:00 CST")),date_labels="%a") + xlab("") + ylab("Energy sub metering")
    dev.off()
}
plot4 <- function(){
    p1 <- ggplot(data=hpc_data, aes(DateTime)) + geom_line(aes(y=Global_active_power)) + scale_x_datetime(breaks =c(as.POSIXct("2007-02-01 00:00:00 CST"), as.POSIXct("2007-02-02 00:00:00 CST"), as.POSIXct("2007-02-03 00:00:00 CST")),date_labels="%a") + xlab("") + ylab("Global Active Power")
    p2 <- ggplot(data=hpc_data, aes(DateTime)) + geom_line(aes(y=Voltage)) + scale_x_datetime(breaks =c(as.POSIXct("2007-02-01 00:00:00 CST"), as.POSIXct("2007-02-02 00:00:00 CST"), as.POSIXct("2007-02-03 00:00:00 CST")),date_labels="%a") + xlab("") + ylab("Voltage")
    p3 <- ggplot(data=hpc_data, aes(DateTime)) + geom_line(aes(y=Sub_metering_1, colour="Sub_metering_1")) + geom_line(aes(y=Sub_metering_2, colour="Sub_metering_2")) + geom_line(aes(y=Sub_metering_3, colour="Sub_metering_3"))  + scale_x_datetime(breaks =c(as.POSIXct("2007-02-01 00:00:00 CST"), as.POSIXct("2007-02-02 00:00:00 CST"), as.POSIXct("2007-02-03 00:00:00 CST")),date_labels="%a") + xlab("") + ylab("Energy sub metering")
    p4 <- ggplot(data=hpc_data, aes(DateTime)) + geom_line(aes(y=Global_reactive_power)) + scale_x_datetime(breaks =c(as.POSIXct("2007-02-01 00:00:00 CST"), as.POSIXct("2007-02-02 00:00:00 CST"), as.POSIXct("2007-02-03 00:00:00 CST")),date_labels="%a") + xlab("") + ylab("Voltage")
}
