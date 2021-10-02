setwd('~/Documents/AdminInfo/HotelBookingDemand-AnalysisCC50')
path = "dataset-hotel-bookings.csv"

na_values = c("", "Undefined", "NA")
# read csv ignoring {na_values}
hotel <- read.csv(path, na.strings=na_values)
# View(head(hotel, 15))
dim(hotel) #119390 32
sum(is.na(hotel))

hotel = na.omit(hotel)

sum(is.na(hotel))

# new dim = 118071 32
dim(hotel)

# Merge dates 
# Retreieve info from columns
# Year : Integer
Year<-hotel$arrival_date_year
# Month = 'January' regular expresion -> 'Jan'
Month <- sub('(^.{3}).*','\\1', hotel$arrival_date_month)
# Day : Integer
Day<-hotel$arrival_date_day_of_month
dates <- paste(Year,Month,Day,sep="-")
#delete old date columns
hotel <- hotel[,!(names(hotel) %in% c("arrival_date_year",
                                      "arrival_date_month",
                                      "arrival_date_day_of_month"))]
# put it into the existing df
hotel$arrival_date = dates
# parse it
#hotel %>% group_by(hotel) %>%
#  mutate(arrival_date=as.Date(arrival_date, format = "%Y-%m-%d"))

write.csv(hotel, "clean-hotel-bookings.csv")
