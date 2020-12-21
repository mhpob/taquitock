library(sf); library(dplyr)


tqtk <- st_read('data/henrico tax parcels/tax_parcels_cama_data.shp',
                query = "select * from Tax_Parcels_CAMA_Data
                         where FULL_ADDRE like '4300 EANES%'
                         or FULL_ADDRE like '5011 EAST RICHMOND%'")


tqtk <- tqtk %>% 
  st_transform(4326)

plot(st_geometry(tqtk))
