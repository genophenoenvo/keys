getwd()
loadNamespace("rgdal")
class(new_proj_and_gdal)
library(lidR)
#install.packages("lidR")
las = readLAS("/home/rstudio/keys/code/Example.las", select = "xyziar", filter = "-keep_first -drop_z_below_0")
plot(las)

las = lasground(las, csf())
plot(las, color = "Classification")

las = lasnormalize(las, tin())
plot(las)

algo = pitfree(thresholds = c(0,10,20,30,40,50), subcircle = 0.2)
chm  = grid_canopy(las, 0.5, algo)
plot(chm, col = height.colors(50))

ker = matrix(1,3,3)
chm = focal(chm, w = ker, fun = median)
chm = focal(chm, w = ker, fun = median)

plot(chm, col = height.colors(50))

##segmentation. Errors may ensue
algo = watershed(chm, th = 4)
las  = lastrees(las, algo)

# remove points that are not assigned to a tree
trees = filter_poi(las, !is.na(treeID))

plot(trees, color = "treeID", colorPalette = pastel.colors(100))
