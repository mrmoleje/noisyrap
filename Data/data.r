###Data downloaded from Kaggle
##08.04.2018

#the data details noise complaints for residences in NYC

#Location - the type of residence
#incidenct.zip -the zip code of the location
#City - which burough of NYC
#Latitude
#longitude
#num_calls - the number of calls per residence

#source {https://www.kaggle.com/somesnm/partynyc}

"noisyrap"

library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=-73.98343, lat=40.67915,
             popup="1,513 calls")
