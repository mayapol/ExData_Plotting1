##Exploratory data analysis
##Course Project 1
##PLOT 2

##Reading the dataset
##We set a working directory where we dowload the dataset. Dont change the names
getwd()
setwd("/home/dschaefer79/Rmaya")
list.files("/home/dschaefer79/Rmaya")
zipfile<-"exdata_data_household_power_consumption.zip"
unzip(zipfile,exdir="exdata")
database<-read.table("./exdata/household_power_consumption.txt",sep=";",header=TRUE, na.strings="?")
head(database)

##Convert to the date format 
class(database$Date)
?as.Date
database1<-database
database1$datetime<-paste(database$Date,database$Time)
head(database1)
database1$datatime.b<-strptime(datetime,"%d/%m/%Y %H:%M:%S")
head(database1)

database1$Datetotal<-as.Date(database1$datatime.b,"%d/%m/%Y %H:%M:%S")
head(database1)

##Set new database from 2007-02-01 to 2007-02-02
install.packages("lubridate")
library(lubridate)
debut<-as.Date("2007-02-01","%Y-%m-%d")
fin<-as.Date("2007-02-02","%Y-%m-%d")
ndatabase<-subset(database1,database1$Datetotal>=debut & database1$Datetotal<=fin)
head(ndatabase)
nrow(ndatabase)
?strptime
##keep just the short dataset 
write.table(ndatabase,file="./db1.csv",sep=",",na="NA")
?write.table
getwd()
##2. Draw graph weekdays vs. Global Active Power (kilowatts)
##Create variable days
require(lubridate)
ndatabase$weekdays<-wday(ndatabase$Datetotal,label=TRUE)
head(ndatabase)

##Plot Global_active_power
library(datasets)
table(ndatabase$weekdays)
par(mar=c(5.1,4.1,4.1,2.1))
png(filename="./plot2.png",width=480,height=480,units="px")
plot(ndatabase$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",xaxt="n")
axis(1,c(1,1440,2880),c("Thu","Fri","Sat"))
par(oma=c(1,1,4,4))
mtext("Plot 2", side=3,outer=TRUE,line=3,adj=0,padj=0)
dev.off()