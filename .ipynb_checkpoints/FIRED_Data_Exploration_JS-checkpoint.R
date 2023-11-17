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

######################### Download  and Read Dataset #####################################

url <- "https://scholar.colorado.edu/downloads/zw12z650d" 
fired <- GET(url) 
data_file <-"fired.zip" 
writeBin(content(fired, "raw"), data_file)

# Unzip the file
unzip(data_file)

# read df
fired <- st_read("fired_conus_ak_to_January_2022_gpkg_shp/conus_ak_to2022001_events.shp") 

fired <- st_read("fired_conus_ak_to_January_2022_gpkg_shp/conus_ak_to2022001_events.shp") 

summary(fired)
str(fired)
