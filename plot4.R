## function that takes two separate vectors x (Date)
## and y (Time) to return a vector of type time (POSIXct)

getdt <- function(x, y){

      ## create an empty numeric vector
      newDateTimeVec <- vector("numeric")

      class(newDateTimeVec) = "POSIXct"
      for(index in seq_along(x)){

                ## concenate the date and time
      		cdt <- paste(x[index], y[index], sep=" ")

                ## use as.POSIXct since strptime returns POSIXlt
		newDateTimeVec <- c(newDateTimeVec,
		as.POSIXct(strptime(cdt, format="%d/%m/%Y %H:%M:%S")))

      }
      newDateTimeVec      
}

## read the table headers
row1 <- read.table("household_power_consumption.txt",
sep=";",na.strings="?",  nrows=1, header=TRUE)

## read only the relevant rows into a data frame

subtable <- read.table("household_power_consumption.txt", sep=";",
na.strings="?",  skip=66637, nrows=2880, col.names=names(row1),
colClasses=c("character", "character", "numeric", "numeric",
"numeric", "numeric", "numeric", "numeric", "numeric"))

## create a new datetime vector from the first two columns

newdtcol <- getdt(subtable[,1], subtable[,2])
subtable <- cbind(subtable, DateTime = newdtcol)

## 4 graphs in a two by two matrix
par(mfrow = c(2, 2))

## plot the graphs
with(subtable, {

     ## line graph identical to plot2
     plot(DateTime, Global_active_power, xlab="", ylab="Global Active Power", type="l", col="black")

     ## line graph for voltage
     plot(DateTime, Voltage, xlab="datetime", ylab="Voltage", type="l", col="black")

     ## line graph identical to plot 3
     plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black")
     lines(DateTime, Sub_metering_2, col="red")
     lines(DateTime, Sub_metering_3, col="blue")
     legend("topright", lty=c(1,1,1), lwd=2, , col=c("black", "red",
     "blue"), legend=c("Sub_metering_1", "Sub_metering_2",
     "Sub_metering_3"))

     ## line graph for global reactive power
     plot(DateTime, Global_reactive_power, xlab="datetime", ylab="Global_reactive_power",
     type="l", col="black")
})

## create a plot4.png file with the same plots
dev.copy(png, file="plot4.png", width = 480, height = 480)

## close the png device
dev.off()

## close the graphics display device
dev.off()
