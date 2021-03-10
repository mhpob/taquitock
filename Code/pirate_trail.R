library(stars)

elev_data <- read_stars('data/USGS_NED_one_meter_x28y416_VA_Sandy_2014_IMG_2015.img', 
                        proxy = T)




path <- read.csv('data/osm_pirate_trail_path.csv') %>% 
  st_as_sf(coords = c('longitude', 'latitude'),
           crs = 4326) %>% 
  st_combine %>% 
  st_cast('LINESTRING') %>% 
  st_transform(st_crs(elev_data))


focus_point <- c(-77.3879, 37.52816) %>%
  # Make coordinate into a point
  st_point() %>%
  # Make point into an simple feature (sf object)
  st_sfc() %>% 
  # Make coordinate reference system lat/long
  st_set_crs(4326) %>%
  # Transform CRS to the proper UTM (CRS of elev_data)
  st_transform(st_crs(elev_data)) %>%
  st_bbox() + c(-600, -500, 500, 400)

focus_point <- focus_point %>% 
  st_as_sfc()



elev_data <- elev_data[focus_point]


plot(elev_data)
plot(path, add = T, col  = 'red', lwd = 5)


library(ggplot2)

ggplot() +
  geom_stars(data = elev_data, downsample = 5) +
  geom_sf(data = path)


library(rayshader)


# Pull elevation data into memory as a raster object, then convert to matrix for
# rayshader

elev_data <- elev_data %>%
  as('Raster')

ext <- attr(elev_data,"extent")

elev_data <- elev_data %>% 
  raster_to_matrix()

# Throw some shade

elev_data %>%
  sphere_shade(colorintensity = 50, sunangle = 270) %>%
  plot_map()

raymat <- elev_data %>% 
  ray_shade(sunangle = 73)




elev_data %>% 
  sphere_shade(colorintensity = 50) %>%
  add_shadow(raymat, max_darken = 0.5) %>%
  plot_3d(elev_data, theta = 195, phi = 20,
          zscale = 0.55, zoom = 0.35, windowsize = c(1000, 900))

render_path(extent = ext, 
            lat = st_coordinates(path)[, 2], long = st_coordinates(path)[, 1],
            altitude = 70)

rgl::rgl.close()






render_snapshot(clear = T, instant_capture = F)
