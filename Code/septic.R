library(sf); library(dplyr)


septic <- st_read('data/henrico tax parcels/tax_parcels_cama_data.shp',
               query = "SELECT * FROM tax_parcels_cama_data WHERE WATER_SE_1 LIKE '%Septic%'")



ip <- st_read('data/tmdl_ip_watersheds.gdb',
        layer = 'IP_Watersheds_DEQ') %>% 
  st_cast('MULTIPOLYGON')

sep_rpj <- septic %>% 
  st_transform(st_crs(ip)) %>% 
  st_make_valid() %>% 
  st_cast('POLYGON')

t <- st_read('data/303d impaired waters/rad_303d_l.shp')

j <- tmdl %>% 
  filter(st_touches(., sep_rpj, sparse = FALSE))
  

jfilter(lengths(st_touches(., sep_rpj))>0)

j <-   ip %>% st_join(k)

k <- sep_rpj %>% 
  st_make_valid()


tmdl <- st_read('data/tmdl_ip_watersheds.gdb',
                layer = 'TMDL_Watersheds_DEQ') %>% 
  st_cast('MULTIPOLYGON')

j <- tmdl %>% 
  st_cast('MULTIPOLYGON') 
j <- tmdl[sep_rpj, ]


tax_rp <- tax %>% 
  st_transform(st_crs(tmdl)) %>% 
  st_cast('MULTIPOLYGON')
unique(st_geometry_type(st_geometry(ip)))

