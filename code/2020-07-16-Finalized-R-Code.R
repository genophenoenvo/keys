library(lidR)
library(magrittr)
library(leaflet)
set_lidr_threads(16)
chm_final<-raster("/home/rstudio/dav/iplant/commons/community_released/aes/srer/suas/2019/ecostate_mapping/products/Sept/15_g2/15_g2_CHM.tif")
chm_downsized <- aggregate(chm_final, fact=20, fun=max)
#chm_lmf = find_trees(chm_downsized, lmf(ws = 5, hmin = .5), uniqueness = "incremental")
#plot(chm_lmf)
set_lidr_threads(16)
chm_lmf3 <- find_trees(chm_final, lmf(ws = 5, hmin = 1), uniqueness = "incremental")
values = c(0.001, 0.005, 0.01, 0.015, 0.05, 0.1, 0.15)
colors <- c("blue", "red", "yellow", "green", "black", "cyan", "darkmagenta")
i = 0
for(item in values)
{
  chm_lmf = find_trees(chm_downsized, lmf(ws = 5, hmin = item), uniqueness = "incremental")
  plot(chm_lmf, col=colors[i], add = TRUE)
  i = i+1
}
chm_lmf2 = find_trees(chm_downsized, lmf(ws = 10, hmin = 0.005), uniqueness = "incremental")
plot(chm_lmf2, col="red", add = T)
plot(chm_downsized)
pal <- colorNumeric(palette="plasma", values(chm_downsized),
                    na.color = "transparent")
leaflet() %>% addTiles() %>%
  addRasterImage(chm_downsized, colors = pal, opacity = 0.8, maxBytes = 1280 * 1024 * 1024) %>%
  addLegend(pal = pal, values = values(chm_downsized),
            title = "Tree Height")

decimate_points(chm_final)

las = readLAS("/home/rstudio/dav/iplant/commons/community_released/aes/srer/suas/2019/ecostate_mapping/pointclouds/sept/15_g2_highdensity.laz")

las_small <-decimate_points(las, random(100))
plot(las_small)
plot(las)
las_small <- lasground(las_small, csf())
plot(las_small)
las_small<- lasnormalize(las_small, tin())
plot(las_small)
algo = pitfree(thresholds = c(0,1,2,3,4,5), subcircle = 0.2)
chm  = grid_canopy(las_small, 0.5, algo)
plot(chm, col = height.colors(50))
ttops = find_trees(las_small, lmf(ws = 5, hmin = 2))
plot(ttops)
