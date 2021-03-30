library(sf)

parcels <- st_read('data derived/taquitock_parcels.gpkg')
plot(st_geometry(parcels))

tracks <- list.files('data/gps tracks', pattern = 'Track', full.names = T)
tracks <- lapply(tracks, st_read, layer = 'tracks')

tracks <- do.call(rbind, tracks)

plot(st_geometry(tracks), add = T)

points <- list.files('data/gps tracks', pattern = 'Waypoints', full.names = T)
points <- st_read(points, layer = 'waypoints')

# points <- do.call(rbind, points)


plot(st_geometry(points), add = T, col = 'blue')
