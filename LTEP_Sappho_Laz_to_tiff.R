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

file<- readLAS("q48124a3310.laz")  
# after you run through the script, change this
# to the next laz file you want to read in

st_crs(file)   # provides metadata on the projection

epsg(file)
projection(file)<- 2927
sf::st_crs(file)$input

summary(file)

###====pulling up the laz file and making CHM===#####


lasNORM<-normalize_height(file, tin())  # normalizing by height

lasCHM=grid_canopy(lasNORM,0.5,dsmtin())

lasSmooth = focal(lasCHM, w=matrix(1,3,3),fun=max)

writeRaster(lasSmooth, filename='LTEP_file12.tif', overwrite=TRUE)

