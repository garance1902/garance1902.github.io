install.packages("osmdata")

library(osmdata)
library(sf)
install.packages("tidyverse")
library(tidyverse)

# Biarritz
biarritz <- opq("Biarritz") %>%
  add_osm_feature("boundary", "administrative") %>%
  add_osm_feature("ref:INSEE", "64122") %>%
  osmdata_sf()

# Bordeaux
bordeaux <- opq("Bordeaux") %>%
  add_osm_feature("boundary", "administrative") %>%
  add_osm_feature("ref:INSEE", "33063") %>%
  osmdata_sf()

# Fusion
biarritz_sf <- biarritz$osm_multipolygons %>%
  mutate(commune = "Biarritz") %>%
  select(commune, geometry)

bordeaux_sf <- bordeaux$osm_multipolygons %>%
  mutate(commune = "Bordeaux") %>%
  select(commune, geometry)

communes_sf <- bind_rows(biarritz_sf, bordeaux_sf)

#sauveagrde dans data
st_write(communes_sf, "data/communes.gpkg", delete_dsn = TRUE)


# 
