######==load packages====######


library(rLiDAR)
library(raster)
library(sp)
library(dplyr)
library(lidR)
library(rgdal)
library(sf)


###==set your working directory====#####

getwd()
setwd("/Volumes/GoogleDrive-106247680948153093879/My Drive/PhD/Sappho LTEP Paper/Sappho LTEP Analysis/LTEP_Lidar/datasetsA/solduc_2015/laz")

#### Reading in and reprojecting laz files ####


# ** files are too large to upload to github. If you need the
# laz files, email me and I can share them. 

file<- readLAS("q48124a3403.laz")
# once done running through the code, rewrite this object named 'file'
# to add the next laz file. When creating a new object for each 
# laz file, there was an error saying 'vector memory exhausted (limit reached?)'
# Writing over each file fixed that issue.

# files that need to be added:
# q48124a3403
# q48124a3404
# q48124a3310
# q48124a3402
# q48124a3305
# q48124a3401

 # provides metadata on the projection
st_crs(file) 

epsg(file)
projection(file)<- 2927
sf::st_crs(file)$input

summary(file)

###====pulling up the laz file and making CHM===#####


lasNORM<-normalize_height(file, tin())  # normalizing by height

lasCHM=grid_canopy(lasNORM,0.5,dsmtin())

lasSmooth = focal(lasCHM, w=matrix(1,3,3),fun=max)


# *** make sure you change the filename each time you add a new file
# to ensure it's not writing over the last 'file' object. 

writeRaster(lasSmooth, filename='LTEP_file12.tif', overwrite=TRUE)
# will have to rename these files each time as you change the 
# input file you loaded in line 20

