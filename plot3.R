##Exploratory data analysis
##Course Project 1
##PLOT 3

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
##3. PLot Energy sub metering
png(filename="./plot3.png",width=480,height=480,units="px")
with(ndatabase,plot(Sub_metering_1,xlab="",type="l",ylab="Energy sub metering",xaxt="n"))
with(ndatabase,lines(Sub_metering_2,xlab="",type="l",ylab="",xaxt="n",col="red"))
with(ndatabase,lines(Sub_metering_3,xlab="",type="l",ylab="",xaxt="n",col="blue"))
axis(1,c(1,1440,2880),c("Thu","Fri","Sat"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
par(oma=c(1,1,4,4))
mtext("Plot 3", side=3,outer=TRUE,line=3,adj=0,padj=0)
dev.off()