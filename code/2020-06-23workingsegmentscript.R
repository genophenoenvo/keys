#print
library(lidR)


#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install(version = "3.7")
#BiocManager::install("EBImage")
#las = readLAS("/home/rstudio/keys_work/keys/code/Example.las", select = "xyziar", filter = "-keep_first -drop_z_below_0")
#las = readLAS("/home/rstudio/keys_work/keys/code/NEON_D14_SRER_DP1_L090-1_2019091314_unclassified_point_cloud.laz")
las = readLAS("/home/rstudio/NEON_SRER_DP1.30003.001_2019/2019/FullSite/D14/2019_SRER_3/L1/DiscreteLidar/ClassifiedPointCloud/NEON_D14_SRER_DP1_501000_3519000_classified_point_cloud_colorized.laz")
#las = readLAS("/home/rstudio/NEON_SRER_DP1.30003.001_2019/2019/FullSite/D14/2019_SRER_3/L1/DiscreteLidar/ClassifiedPointCloud/NEON_D14_SRER_DP1_501000_3518000_classified_point_cloud_colorized.laz")
plot(las)
#finished


#second chunk
#las = lasground(las, csf())
#warning return number / number of returns not found. Data issue?
plot(las, color = "Classification")
#finished second chunk

#third chunk
las = lasnormalize(las, tin())#no issue
plot(las)
#finished third chunk

#fourth chunk
algo = pitfree(thresholds = c(0,10,20,30,40,50), subcircle = 0.2)
chm  = grid_canopy(las, 0.5, algo)#error in proj4string(x) CRS object has comment which is lost in output. It seems to stop the top of the legend from rendering.
plot(chm, col = height.colors(50))
#finished fourth chunk


#fifth chunk
ker = matrix(1,3,3)
chm = focal(chm, w = ker, fun = median)
chm = focal(chm, w = ker, fun = median)

plot(chm, col = height.colors(50)) # check the image
#ignore previous error, the code still works with it. Still odd
#finished fifth chunk

#sixth chunk
algo = watershed(chm, th = 4)
las  = lastrees(las, algo)

# remove points that are not assigned to a tree
#trees = filter(las, !is.na(treeID))
trees = lasfilter(las, !is.na(treeID))

plot(trees, color = "treeID", colorPalette = pastel.colors(100))
#Error, there were 50 or more warnings. Don't know why yet.
#finished sixth chunk

#seventh chunk
hulls  = tree_hulls(las)#, func = .stdmetrics)
#Error in eval(bysub, x, parent.frame()) : object 'treeID' not found
spplot(hulls, "Z")
#object hulls not found, the previous code gets terminated. I think it is due to the 50+ warnings line.
#at this point, the plot is no longer going to run.
#finished 7th chunk

#eighth chunk
crowns = watershed(chm, th = 4)()
plot(crowns, col = pastel.colors(100))
#All right, at this point, the code has so many holes I don't think I can do anything short of fixing earlier issues. Otherwise I won't be able to competantly test the rest of the code
#The issue this time is that I'm missing EMImage, but when I installed it before, it takes a about 10 minutes and there's no mention of it in the documentation.
#finished eight chunk


#ninth chunk
contour = rasterToPolygons(crowns, dissolve = TRUE)
#loading required namespace:rgeos
plot(chm, col = height.colors(50))
plot(contour, add = T)
#finished
