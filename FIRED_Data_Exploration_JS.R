######################## FIRED Dataset Exploration #############################

######################## Install and Load packages #############################

# Install packages
packages <- c("tidyverse", "httr", "sf") 
new.packages <- packages[!(packages %in% installed.packages()[,"Package"])] 
if(length(new.packages)>0) install.packages(new.packages) 

install.packages("ggpubr")

# Load packages 
lapply(packages, library, character.only = TRUE)
library("ggpubr")

######################### Download  and Read Dataset ###########################

url <- "https://scholar.colorado.edu/downloads/9g54xj85m" 
fired <- GET(url) 
data_file <-"fired.zip" 
writeBin(content(fired, "raw"), data_file)

# Unzip the file
unzip(data_file)

# read df
fired_ha <- st_read("fired_hawaii_to2021121_events.gpkg") 

# Summary of df
summary(fired_ha)
str(fired_ha)
########################## Summary Plots #######################################
### Summary of fire events

#Plot fire vs ingition day 
p1 <- 
  ggplot(fired_ha) +
  geom_point(aes(ig_day, event_dur),
             size = 4) +
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
  geom_bar(alpha = .5)+ 
  theme_bw() +
  theme(legend.position = "none")+
  ylab('# of fire events') +
  xlab('Year')

# plot area burend per year 
p3  <- 
  ggplot(fired_ha, aes(x = ig_year, y = tot_ar_km2, 
                       color = ig_year, fill = ig_year)) +
    geom_point(size = 4, alpha = .5)+
  theme_bw() +
    theme(legend.position = "none")+
  ylab('Total Area Burned (Km^2)') +
  xlab('Year')
  
# plot event duration per year 
p4 <-
  ggplot(fired_ha, aes(x = ig_year, y = event_dur, 
                       color = ig_year, fill = ig_year)) +
  geom_point(size = 4, alpha = .5)+
  theme_bw()+
  theme(legend.position = "none")+
  xlab('Year') +
  ylab('Event Duration (days)')

# Save graphs 

### Summary by vegetation type 

#factor information 

factor(fired_ha$lc_desc)
factor(fired_ha$lc_name)

# plot events by vegetation type 
p1b <-
  ggplot(fired_ha, aes(lc_name,
                       color = lc_name, fill = lc_name)) +
  geom_bar(alpha = .5)+
  theme_bw() +
  theme(legend.position = "none")+
    theme(axis.text.x=element_text(size=rel(0.9)))+
  ylab('# of fire events') +
  xlab("Vegetation Type")

# plot area burned per VT 
p2b <-
  ggplot(fired_ha, aes(x = lc_name, y = tot_ar_km2, 
                       color = lc_name, fill = lc_name)) +
  geom_point(size = 4, alpha = .5)+
  theme_bw() +
  theme(legend.position = "none")+
  theme(axis.text.x=element_text(size=rel(0.9)))+
  ylab('Total Area Burned (Km^2)') +
  xlab('Vegetation Type')

# plot event duration per VT 
p3b <-
  ggplot(fired_ha, aes(x = lc_name, y = event_dur, 
                       color = lc_name, fill = lc_name)) +
  geom_point(size = 4, alpha = .5)+
  theme_bw()+
  theme(legend.position = "none")+
  theme(axis.text.x=element_text(size=rel(0.9)))+
  xlab('Year') +
  ylab('Event Duration (days)')

# plot vegetation type events by year
p4b <- 
  ggplot(fired_ha, aes(x=ig_year, fill=lc_name)) + 
    geom_bar(stat="count", alpha = .7)+
    theme_bw() +
    xlab('Year')+
    ylab('# of fire events')+
    scale_fill_discrete(name = "Vegetation Type")
  
  