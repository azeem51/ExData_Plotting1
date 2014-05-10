## read the relevant rows from the csv file
fulltable <- read.table("household_power_consumption.txt", sep=";",
skip=66637, nrows=2880, na.string="?")

## select only the relevant column (global active power)
gap <- fulltable[, 3]

## remove the NA values
gapc <- complete.cases(fulltable[, 3])
gap <- gap[gapc]

## plot the histogram
hist(gap, breaks=12, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")

## create the png file with name plot1.png
dev.copy(png, file="plot1.png", width = 480, height = 480)
## close the png device
dev.off()

## close the graphics display device
dev.off()
