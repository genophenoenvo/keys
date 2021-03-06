library(lidR)
chm_final<- raster("/home/rstudio/dav-anon/iplant/commons/community_released/aes/srer/suas/2019/ecostate_mapping/products/Sept/15_g2/15_g2_CHM.tif")
set_lidr_threads(16)
plot(chm_final)
tree_tops = find_trees(chm_final, lmf(ws=5, hmin = 2), uniqueness = "incremental")
plot(tree_tops)
plot(chm_final, col = height.colors(50))
sp::plot(tree_tops, add = T)
class(chm_final)

verbose(data_out = TRUE, data_in = FALSE, info = FALSE,
        ssl = FALSE)
