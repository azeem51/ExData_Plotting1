cstod <- function(x){
   newDateVec <- vector("numeric")
   class(newDateVec) = "Date"
   for(britdate in x){
   	newDateVec <- c(newDateVec, as.Date(britdate, "%d/%m/%Y"))
   }
   newDateVec
}

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

## plot the graph with type=l for line graph

with(subtable, plot(DateTime, Global_active_power, xlab="",
ylab="Global active power (kilowatts)", type="l"))

dev.copy(png, file="plot2.png", width = 480, height = 480)
dev.off()
dev.off()
