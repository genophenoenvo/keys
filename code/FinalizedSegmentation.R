library(lidR)
file_path = "/home/rstudio/keys/code/Example.las"
las = readLAS(file_path)

las = lasground(las, csf())
plot(las, color = "Classification")
las = lasnormalize(las, tin())
trees_lmf = find_trees(las, lmf(ws = 5, hmin = 5), uniqueness = "incremental")
plot(trees_lmf)
las = lasnormalize(las, tin())
plot(las)
algo = pitfree(thresholds = c(0,10,20,30,40,50), subcircle = 0.2)
chm  = grid_canopy(las, 0.5, algo)#error in proj4string(x) CRS object has comment which is lost in output. It seems to stop the top of the legend from rendering.
plot(chm, col = height.colors(50))

ker = matrix(1,3,3)
chm = focal(chm, w = ker, fun = median)

plot(chm, col = height.colors(50))



algo = watershed(chm, th = 4)
las  = lastrees(las, algo)

trees = lasfilter(las, !is.na(treeID))

plot(trees, color = "treeID", colorPalette = pastel.colors(100))

hulls  = tree_hulls(las)
spplot(hulls, "Z")
crowns = watershed(chm, th = 4)()
plot(crowns, col = pastel.colors(100))
sp::plot(trees_lmf, add = TRUE)


contour = rasterToPolygons(crowns, dissolve = TRUE)
plot(contour)
plot(chm, col = height.colors(50))
plot(contour, add = T)


plot(chm, col = height.colors(50))
trees_lmf = find_trees(las, lmf(ws = 5, hmin = 7), uniqueness = "incremental")
plot(contour, add =T)
plot(trees_lmf, add =T)
