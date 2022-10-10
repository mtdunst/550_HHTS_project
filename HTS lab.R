setwd("C:/Users/14145/OneDrive - PennO365/CPLN 550 Intro to Transportation Planning/DVRPC lab/DVRPC HTS Database Files")
library(tidyverse)
hh <- read.csv("1_Household_Public.csv")

per <- read.csv("2_Person_Public.csv")

veh <- read.csv("3_Vehicle_Public.csv")

trip <- read.csv("4_Trip_Public.csv")

head(trip)
summary(trip$O_TAZ)

#Question 1: Describe in detail the daily activities and trips of the first person in the trips data.
head(trip[c(3, 10, 17, 18, 27:35, 36, 37, 39, 64, 65, 69)],6)
#This person started the day at home and used the morning to relax, recreate, and do a little work from home.
#At 11:00 AM, 
table(trip$MODE_AGG)
mode_PHL <- table(trip$MODE_AGG)
mode_PHL
colnames(mode_PHL) <- c("walk", "bike", "car", "priv_transit", "pub_transit", "school_bus", "other")
sum(mode_PHL)
"tot_trips" <- sum(mode_PHL)
mode_PHL.df <- data.frame(mode_PHL, tot_trips)
"mode_share" <- (mode_PHL.df$Freq/tot_trips)
mode_PHL.df <- mode_PHL.df %>% 
  mutate(mode_share)
mode_PHL.df
mode_PHL.df <- mode_PHL.df[ -c(3) ]
mode_PHL.df
colnames(mode_PHL.df) <- c("Mode","Freq","Mode_Share")
mode_PHL.df

trip_hh <- merge(trip, hh, by = "HH_ID", all.x = FALSE, all.y=FALSE, sort = FALSE)
head(trip_hh)
PHL_trip <- subset(trip_hh, trip_hh$H_COUNTY == 42101)
PHL_trip_modes <- PHL_trip[c(38)]
glimpse(PHL_trip_modes)
PHL_trip_modes <- table(PHL_trip_modes)
"tot_trips_PHL" <- sum(PHL_trip_modes)
PHL_trip_modes.df <- data.frame(PHL_trip_modes, tot_trips_PHL)
"mode_share_PHL" <- (PHL_trip_modes.df$Freq/tot_trips_PHL)
PHL_trip_modes.df <- PHL_trip_modes.df %>% 
  mutate(mode_share_PHL)
PHL_trip_modes.df
PHL_trip_modes.df <- PHL_trip_modes.df[ -c(3) ]
PHL_trip_modes.df
colnames(PHL_trip_modes.df) <- c("Mode","Freq","Mode_Share")
PHL_trip_modes.df
plot(PHL_trip_modes.df$Mode,PHL_trip_modes.df$Mode_Share)
