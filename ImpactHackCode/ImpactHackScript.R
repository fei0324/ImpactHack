setwd("D:/ImpactHack/Energy_Investment_and_Risk_final")

library(leaflet)
library(RColorBrewer)

power_plant_db <- read.csv("global_power_plant_database.csv", header=T, sep=",")
power_plant_loc <- power_plant_db[c(6,7)]
names(power_plant_db)

# Add an indicator variable for renewable energy
unique(power_plant_db["fuel1"])
power_plant_db$renewable <- power_plant_db$fuel1 %in% c("Hydro", "Wind", "Nuclear", "Solar", "Waste", "Biomass", "Wave and Tidal", "Geothermal", "Cogeneration", "Storage") 

# Plot the renewable and nonrenewable power plants
pal_renewable <- colorFactor("#66FF66", domain = power_plant_db$renewable == 1)

m_renewable <-  leaflet(data=power_plant_db) %>%
  addTiles() %>%
  addCircleMarkers(~longitude, ~latitude,
                   popup = power_plant_db$country_long,
                   radius = 5,
                   color = ~pal_renewable(power_plant_db$renewable == 1)) %>%
                   #clusterOptions = markerClusterOptions())

nonrenewable_plants <- subset(power_plant_db, renewable == 0)
m_renewable_nonrenewable <- addCircles(m_renewable,
                                       ~nonrenewable_plants$longitude, ~nonrenewable_plants$latitude,
                                       popup = power_plant_db$country_long,
                                       radius = 5,
                                       color = "#FF3333",
                                       fillOpacity = 0.2)
m_renewable
m_renewable_nonrenewable

pal_nonrenewable <- colorFactor("#FF3333", domain = power_plant_db$renewable == 0)

m_nonrenewable <-  leaflet(data=power_plant_db[1:200,]) %>%
  addTiles() %>%
  addCircleMarkers(~longitude, ~latitude,
                   popup = power_plant_db$country_long,
                   radius = 5,
                   color = ~pal_nonrenewable(power_plant_db$renewable == 0))
m_renewable
m_nonrenewable

finance_data <- read.csv("nrdc_coal_renewable_financing_with_locations.csv")

# Want to be able to add sector as a parameter as well. plot renewable and not renewable separately
plot_finance <- function(this_country){
  data_to_plot <- subset(finance_data, Country == this_country)
print(dim(data_to_plot))
    m_investment <- leaflet(data=data_to_plot) %>%
    addTiles() %>%
    addCircleMarkers(~Longitude, ~Latitude,
                     radius = 5,
                     color = "orange")
  return(m_investment)
}
plot_finance("India")
plot_finance("China")

load("hackData.Rda")

china_finance_data = subset(finance_data, Country == "China")
m_investment <- leaflet(data=china_finance_data) %>%
  addTiles() %>%
  addCircleMarkers(~Longitude, ~Latitude,
                   radius = 5,
                   color = "orange",
                   popup = paste("Recipient country:", china_finance_data$Recipient.Country, "<br>",
                                 "Investment amount:", china_finance_data$Amount..in.USD., "<br>"))
m_investment

# plot by drought level (average SPEI)

binpal <- colorBin("Reds", hackData$X25_year_avg, 6, pretty=FALSE)
m_drought <- leaflet(data=hackData) %>%
  addTiles() %>%
  addCircleMarkers(~longitude, ~latitude,
                   popup = paste("COuntry:", hackData$country_long),
                   radius = 5,
                   color = ~binpal(hackData$X25_year_avg))

m_drought
plot_averageSPEI("China")

# plot by elevation
# Log transformation to avoid outliers
hackData$log_elevation <- log(hackData$elevation_meters)

elevation_qpal <- colorQuantile("Blues", hackData$log_elevation, n=4)
m_elevation <- leaflet(data=hackData) %>%
  addTiles() %>%
  addCircleMarkers(~longitude, ~latitude,
                   popup = hackData$elevation_meters,
                   radius = 5,
                   color = ~elevation_qpal(hackData$log_elevation)) %>%
  addLegend("bottomright", pal = elevation_qpal,
            values = ~hackData$log_elevation,
            title = "Elevation (meters)",
            opacity = 1)
m_elevation

storm_risk <- subset(hackData, X100_year_surge_at_risk == 1)

# add red circles for storm risk power plants onto the elevation plot
m_elevation_storm <- addCircles(m_elevation, ~storm_risk$longitude, ~storm_risk$latitude,
           popup = storm_risk$country_long,
           radius = 7,
           color = "red")

m_renewable
m_renewable_nonrenewable
m_investment
m_drought
m_elevation
m_elevation_storm

