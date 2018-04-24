#Sue Wallace
#24.04.2018

#Learning leflet

#https://rstudio.github.io/leaflet/

#https://matt-dray.github.io/how-to-leaflet/


#load libraries
library(leaflet)
library(dplyr)

#load data

data <- read.csv("bar_locations.csv", header = TRUE)

#basic intro----

m <- leaflet() %>%
  addProviderTiles(providers$Stamen.Toner) %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m  # Print the map


#using basemaps (https://rstudio.github.io/leaflet/basemaps.html)----

#WMS Tiles

#You can use addWMSTiles() to add WMS (Web Map Service) tiles

leaflet() %>% addTiles() %>% setView(-93.65, 42.0285, zoom = 4) %>%
  addWMSTiles(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    layers = "nexrad-n0r-900913",
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  )


#ADD MARKERS----


leaflet(data=data[1:100,]) %>% addTiles() %>%
  addProviderTiles(providers$Thunderforest) %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=~Longitude, lat=~Latitude)

#Just the residences that have more than 100 calls


data %>%
  filter(num_calls>=100) -> a


leaflet(data=a) %>% addTiles() %>%
  addProviderTiles(providers$Thunderforest) %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=~Longitude, lat=~Latitude)

#Customizing Marker Icons

greenLeafIcon <- makeIcon(
  iconUrl = "http://leafletjs.com/examples/custom-icons/leaf-green.png",
  iconWidth = 38, iconHeight = 95,
  iconAnchorX = 22, iconAnchorY = 94,
  shadowUrl = "http://leafletjs.com/examples/custom-icons/leaf-shadow.png",
  shadowWidth = 50, shadowHeight = 64,
  shadowAnchorX = 4, shadowAnchorY = 62
)

leaflet(data = quakes[1:4,]) %>% addTiles() %>%
  addMarkers(~long, ~lat, icon = greenLeafIcon)

# first 20 quakes
df.20 <- quakes[1:20,]

getColor <- function(quakes) {
  sapply(quakes$mag, function(mag) {
    if(mag <= 4) {
      "green"
    } else if(mag <= 5) {
      "orange"
    } else {
      "red"
    } })
}

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(df.20)
)

leaflet(df.20) %>% addTiles() %>%
  addAwesomeMarkers(~long, ~lat, icon=icons, label=~as.character(mag))


##applying different coloured markers to my dataset


getColor <- function(data) {
  sapply(data$num_calls, function(num_calls) {
    if(num_calls <=11) {
      "green"
    } else if(num_calls <=50) {
      "orange"
    } else {
      "red"
    } })
}


icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(data)
)


leaflet(data=a) %>% addTiles() %>%
  addProviderTiles(providers$Thunderforest) %>%  # Add default OpenStreetMap map tiles
  addAwesomeMarkers(lng=~Longitude, lat=~Latitude, icon = icons, label=~as.character(num_calls))

#Marker Clusters

#When there are a large number of markers on a map, you can cluster them using the
#Leaflet.markercluster plug-in. To enable this plug-in,
#you can provide a list of options to the argument clusterOptions, e.g.

#example

leaflet(quakes) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions()
)

leaflet(data=a) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions()
)

#POPUPS and LABELS----

#Popups are small boxes containing arbitrary HTML, that point to a specific point on the map.
#Use the addPopups() function to add standalone popup to the map.


#example

content <- paste(sep = "<br/>",
                 "<b><a href='http://www.edsheeran.com/'>Ed Sheeran</a></b>",
                 "Degraw Street",
                 "New York, New York"
)

leaflet() %>% addTiles() %>%
  addPopups(-73.98343,40.67915, content,
            options = popupOptions(closeButton = FALSE)
  )

#lables popping up

library(htmltools)

df <- read.csv(textConnection(
  "Name,Lat,Long
  Really noisy,-73.98343,40.67915
  Kind of noisy,-73.95065,40.66820
  Not too noisy,-73.96654,40.71113"
))

leaflet(df) %>% addTiles() %>%
  addMarkers(~Lat, ~Long, popup = ~htmlEscape(Name))


#Labels

#A label is a textual or HTML content that can attached to markers and shapes to be always displayed or
#displayed on mouse over. Unlike popups you don’t need to click a marker/polygon for the label to be shown.

df <- read.csv(textConnection(
  "Name,Lat,Long
  Really noisy,-73.98343,40.67915
  Kind of noisy,-73.95065,40.66820
  Not too noisy,-73.96654,40.71113"))

leaflet(df) %>% addTiles() %>%
  addMarkers(~Lat, ~Long, label = ~htmlEscape(Name))

#Customizing Marker Labels

#You can customize marker labels using the labelOptions argument of the addMarkers function. T
#he labelOptions argument can be populated using the labelOptions() function. If noHide is false (the default)
#then the label is displayed only when you hover the mouse over the marker;
#if noHide is set to true then the label is always displayed.

#example

# Change Text Size and text Only and also a custom CSS

leaflet() %>% addTiles() %>% setView(-118.456554, 34.09, 13) %>%
  addMarkers(
    lng = -118.456554, lat = 34.105,
    label = "Default Label",
    labelOptions = labelOptions(noHide = T)) %>%
  addMarkers(
    lng = -118.456554, lat = 34.095,
    label = "Label w/o surrounding box",
    labelOptions = labelOptions(noHide = T, textOnly = TRUE)) %>%
  addMarkers(
    lng = -118.456554, lat = 34.085,
    label = "label w/ textsize 15px",
    labelOptions = labelOptions(noHide = T, textsize = "15px")) %>%
  addMarkers(
    lng = -118.456554, lat = 34.075,
    label = "Label w/ custom CSS style",
    labelOptions = labelOptions(noHide = T, direction = "bottom",
                                style = list(
                                  "color" = "red",
                                  "font-family" = "serif",
                                  "font-style" = "italic",
                                  "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                  "font-size" = "12px",
                                  "border-color" = "rgba(0,0,0,0.5)"
                                )))

#using my data


leaflet(data=a) %>% addTiles() %>%
  addProviderTiles(providers$Thunderforest) %>%  # Add default OpenStreetMap map tiles
  addAwesomeMarkers(lng=~Longitude, lat=~Latitude, icon = icons, label=~as.character(num_calls))

leaflet() %>% addTiles() %>%
  addMarkers (
    lng = -73.96372, lat = 40.79807,
    label = "Changing label text size",
    labelOptions = labelOptions(noHide = T, textsize = "15px"))

#LINES AND SHAPES----





