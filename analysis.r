setwd('~/Documents/AdminInfo/HotelBookingDemand-AnalysisCC50')
path = "clean-hotel-bookings.csv"

hotel <- read.csv(path, na.strings="")
#View(hotel)

# a. ¿Cuántas  reservas  se  realizan  por  tipo  de  hotel?  o  ¿Qué  tipo  de  hotel  prefiere  la 
# gente? 
barplot(table(hotel['hotel']), 
        main='Type of hotel preference',
        ylab='Num. Reservations', xlab='Type of hotel')

# b. ¿Está aumentando la demanda con el tiempo? 
# array of %Y-%m of original dates
#and table it
hotel <- hotel[order(as.Date(hotel$arrival_date, format="%Y-%m-%d")), ]
dates <- table(sub('(^.{8}).*','\\1', hotel$arrival_date))
barplot(dates, main="Number of reservations per month",
        xlab="Month", ylab="Num of reservations")

# c. ¿Cuándo se producen las temporadas de reservas: alta, media y baja? 
mnts <- sort(substring(hotel$arrival_date,first=6,last=8))
barplot(sort(table(mnts)), horiz=TRUE, main="Bookings per month", 
        xlab="Bookings", ylab="Month")

# d. ¿Cuándo es menor la demanda de reservas? 
 # Winter
# e. ¿Cuántas reservas incluyen niños y/o bebes? 
unblessed <- nrow(subset(hotel, children == 0 & babies == 0 ))
blessed <- nrow(subset(hotel, children > 0 | babies > 0 ))
# f. ¿Es importante contar con espacios de estacionamiento? 
parking <- nrow(subset(hotel, required_car_parking_spaces > 0))
no_parking <- nrow(subset(hotel, required_car_parking_spaces == 0))
# g. ¿En qué meses del año se producen más cancelaciones de reservas? 
cancelled <- subset(hotel, reservation_status == "Canceled")
mnts <- sort(substring(hotel$arrival_date,first=6,last=8))
barplot(sort(table(mnts)), horiz=TRUE, main="Cancelations per month", 
        xlab="Bookings", ylab="Month")

