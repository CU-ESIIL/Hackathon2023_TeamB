######################## FIRED Dataset Exploration #############################

######################## Install and Load packages #############################

# Install packages
packages <- c("tidyverse", "httr", "sf") 
new.packages <- packages[!(packages %in% installed.packages()[,"Package"])] 
if(length(new.packages)>0) install.packages(new.packages) 

library(remotes)
install_github("r-spatial/sf")
# Load packages 
lapply(packages, library, character.only = TRUE)

######################### Download  and Read Dataset ###########################

url <- "https://scholar.colorado.edu/downloads/9g54xj85m" 
fired <- GET(url) 
data_file <-"fired.zip" 
writeBin(content(fired, "raw"), data_file)

# Unzip the file
unzip(data_file)

# read df
#OLD --- fired <- st_read("fired_conus_ak_to_January_2022_gpkg_shp/conus_ak_to2022001_events.shp") 

fired_ha <- st_read("fired_hawaii_to2021121_events.gpkg") 

# Summary of df
summary(fired_ha)
str(fired_ha)
########################## Summary Plots #######################################
#Plot fire vs ingition day 
p1 <- 
  ggplot(fired_ha) +
  geom_point(aes(ig_day, event_dur)) +
  theme_bw() +
  xlab('Day') +
  ylab('Event duration (days)')

#Summarize fired data 

# set year as factor 
fired_ha$ig_year <- as.factor(fired_ha$ig_year)
str(fired_ha$ig_year)

# plot number of fire events per year 
p2 <-
  ggplot(fired_ha, aes(ig_year,
                       color = ig_year, fill = ig_year)) +
  geom_histogram(stat = "count", alpha = .33)+ 
  theme_bw() +
  theme(legend.position = "none")+
  ylab('# of fire events') +
  xlab('Year')

# plot area burend per year 
p3  <- 
  ggplot(fired_ha, aes(x = ig_year, y = tot_ar_km2, 
                       color = ig_year, fill = ig_year)) +
    geom_point(size = 3, alpha = .33)+
  theme_bw() +
    theme(legend.position = "none")+
  ylab('Total Area Burned (Km^2)') +
  xlab('Year')
  