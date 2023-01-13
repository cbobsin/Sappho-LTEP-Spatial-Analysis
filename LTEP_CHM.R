# This code creates a canopy height model (CHM) based on 2015 aerial lidar
# from the Sol Duc near the Sappho LTEP site and determines tree height

# Last updated: November 1, 2022

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

##### loading tiff files and merging  ####

rast3<- raster("LTEP_file3.TIF")
rast4<- raster("LTEP_file4.TIF")
rast8<- raster("LTEP_file8.TIF")
rast9<- raster("LTEP_file9.TIF")
rast10<-raster("LTEP_file10.TIF")
rast11<- raster("LTEP_file11.TIF")


allrasters<- merge(rast3, rast4, rast8, rast9, rast10, rast11) 
# merging these into 1 raster file


# Reprojecting the one large raster :
st_crs(allrasters)
projection(allrasters)<- 2927
sf::st_crs(allrasters)$input

### reading in LTEP shapefile #####

setwd("/Volumes/GoogleDrive-106247680948153093879/My Drive/PhD/Sappho LTEP Paper/Sappho LTEP Analysis/LTEP_Lidar/datasetsA/solduc_2015/laz/shapefiles/EXU_MappingPolygons/")

# reading in shapefile with sf package 
shpfile<- readOGR(dsn=".", layer= "EXU_MappingPolygons")
plot(shpfile)
class(shpfile)
head(shpfile)


# reprojecting the shapefile
crs(shpfile)

shpfile<- spTransform(shpfile, crs(allrasters))  
# reprojecting shapefile based on the rasters projection


#### Subset the shapefile to remove control's and late seral units ######

# this includes the Doug fir and early seral units:

shpfile<- shpfile[shpfile@data$SppComp != "Control", ]
shpfile<- shpfile[shpfile@data$SppComp != "Late Seral", ]


#### early dataset: #####

# creating a dataset with only early seral units in the shapefile

early<- shpfile[shpfile@data$SppComp != "Douglas Fir", ]

plot(allrasters)
plot(early, add=T, col= "blue")

##### Douglas-fir dataset:  #####

# creating a dataset with only Doug-fir units in the shapefile

dougfir<- shpfile[shpfile@data$SppComp != "Pioneer", ]

plot(dougfir, add=T, col= "purple")


#### subsetting into individual DF EXU's #####

B1M1<-dougfir[dougfir@data$EXU == "1M1", ]
B1M2<-dougfir[dougfir@data$EXU == "1M2", ]
B1M3<-dougfir[dougfir@data$EXU == "1M3", ]

B2M1<-dougfir[dougfir@data$EXU == "2M1", ]
B2M2<-dougfir[dougfir@data$EXU == "2M2", ]
B2M3<-dougfir[dougfir@data$EXU == "2M3", ]

B3M1<-dougfir[dougfir@data$EXU == "3M1", ]
B3M2<-dougfir[dougfir@data$EXU == "3M2", ]
B3M3<-dougfir[dougfir@data$EXU == "3M3", ]

B4M1<-dougfir[dougfir@data$EXU == "4M1", ]
B4M2<-dougfir[dougfir@data$EXU == "4M2", ]
B4M3<-dougfir[dougfir@data$EXU == "4M3", ]

#### subsetting into individual Early Seral EXU's #####

# Block 1
B1E1<-early[early@data$EXU == "1E1", ]
B1E2<-early[early@data$EXU == "1E2", ]
B1E3<-early[early@data$EXU == "1E3", ]

# Block 2
B2E1<-early[early@data$EXU == "2E1", ]
B2E2<-early[early@data$EXU == "2E2", ]
B2E3<-early[early@data$EXU == "2E3", ]

# Block 3
B3E1<-early[early@data$EXU == "3E1", ]
B3E2<-early[early@data$EXU == "3E2", ]
B3E3<-early[early@data$EXU == "3E3", ]

# Block 4:
B4E1<-early[early@data$EXU == "4E1", ]
B4E2<-early[early@data$EXU == "4E2", ]
B4E3<-early[early@data$EXU == "4E3", ]

##### clipping raster to be only area of shapefiles for DF & early seral #####

# for both together:
r1<-crop(allrasters, shpfile)
rast_clip <-mask(r1, shpfile)


# for early seral units: 

r1<-crop(allrasters, early)
clip_early <-mask(r1, early)


# for the doug-fir units:

r2<-crop(allrasters, dougfir)
clip_dougfir <-mask(r2, dougfir)

# for just B2M2

r3<- crop(allrasters, B1M3)
clip_B1M3<- mask(r3, B1M3)

##### Cropping and masking by EXU #####

# Block 1
r1<- crop(allrasters, B1M1)
clip_B1M1<- mask(r1, B1M1)

r1<- crop(allrasters, B1M2)
clip_B1M2<- mask(r1, B1M2)

r1<- crop(allrasters, B1M3)
clip_B1M3<- mask(r1, B1M3)

# Block 2
r1<- crop(allrasters, B2M1)
clip_B2M1<- mask(r1, B2M1)

r1<- crop(allrasters, B2M2)
clip_B2M2<- mask(r1, B2M2)

r1<- crop(allrasters, B2M3)
clip_B2M3<- mask(r1, B2M3)

# Block 3:
r1<- crop(allrasters, B3M1)
clip_B3M1<- mask(r1, B3M1)

r1<- crop(allrasters, B3M2)
clip_B3M2<- mask(r1, B3M2)

r1<- crop(allrasters, B3M3)
clip_B3M3<- mask(r1, B3M3)

# Block 4
r1<- crop(allrasters, B4M1)
clip_B4M1<- mask(r1, B4M1)

r1<- crop(allrasters, B4M2)
clip_B4M2<- mask(r1, B4M2)

r1<- crop(allrasters, B4M3)
clip_B4M3<- mask(r1, B4M3)

# Early Seral: 
# Block 1:

# Block 1
r1<- crop(allrasters, B1E1)
clip_B1E1<- mask(r1, B1E1)

r1<- crop(allrasters, B1E2)
clip_B1E2<- mask(r1, B1E2)

r1<- crop(allrasters, B1E3)
clip_B1E3<- mask(r1, B1E3)

# Block 2: 

r1<- crop(allrasters, B2E1)
clip_B2E1<- mask(r1, B2E1)

r1<- crop(allrasters, B2E2)
clip_B2E2<- mask(r1, B2E2)

r1<- crop(allrasters, B2E3)
clip_B2E3<- mask(r1, B2E3)

# Block 3:
r1<- crop(allrasters, B3E1)
clip_B3E1<- mask(r1, B3E1)

r1<- crop(allrasters, B3E2)
clip_B3E2<- mask(r1, B3E2)

r1<- crop(allrasters, B3E3)
clip_B3E3<- mask(r1, B3E3)

# Block 4:
r1<- crop(allrasters, B4E1)
clip_B4E1<- mask(r1, B4E1)

r1<- crop(allrasters, B4E2)
clip_B4E2<- mask(r1, B4E2)

r1<- crop(allrasters, B4E3)
clip_B4E3<- mask(r1, B4E3)



# cropmask <- function(raster, plot) {
#    crop(raster,plot) %>% mask(plot)
# }
# 
# clip_B4E2 <- cropmask(allrasters, B4E2)

##### creating function & loop for CHM smoothing and tree height detection ####

## this for loop isn't working yet-- move on to line 267 for next part

# plotloop<- function(data= shpfile@data){
#   for (i in shpfile@data$EXU){
#     exu_plots<-cropmask(allrasters, shpfile)
#     # r1<-crop(allrasters, shpfile)
#     # exu_plots<-mask(r1, shpfile)
#     schm<-CHMsmoothing(exu_plots, "mean", 5)
#     minht<-8
#     fws<-5 
#     treeList<-FindTreesCHM(schm, fws, minht)
#   }
# }

# still need to figure out how to write each individual unit to its own 
# csv file here

# write.csv(treeList,"LTEP_Earlys_treeheight.csv")


#### Smoothing of the clipped early seral raster file & setting parameters #####

schm<-CHMsmoothing(clip_early, "mean", 5)
minht<-8   # min tree height
fws<-5 # dimension 5x5

###==Make and view list of invd. trees detected====
treeList<-FindTreesCHM(schm, fws, minht)
summary(treeList)

###==Plot the indv. trees detected onto the CHM (optional, just for visual reassurance)====
par(mar=c(1,1,1,1))
plot(schm, main="LiDAR-derived CHM")
XY<-SpatialPoints(treeList[,1:2]) # Spatial points
plot(XY, add=TRUE, col="red", pch=4, cex=.5)        # plotting tree location

mean(treeList$height)

###==Write the indv. tree list, with heights included, as a .csv file====
write.csv(treeList,"LTEP_Earlys_treeheight.csv")



#### Smoothing of the clipped Doug-fir raster file #####

schm<-CHMsmoothing(clip_dougfir, "mean", 5)

###==Make and view list of invd. trees detected====
treeList<-FindTreesCHM(schm, fws, minht)
summary(treeList)

###==Plot the indv. trees detected onto the CHM (optional, just for visual reassurance)====
par(mar=c(1,1,1,1))
plot(schm, main="LiDAR-derived CHM")
XY<-SpatialPoints(treeList[,1:2]) # Spatial points
plot(XY, add=TRUE, col="lightblue",  pch=4, cex=.5)  # plotting tree location


###==Write the indv. tree list, with heights included, as a .csv file====
write.csv(treeList,"LTEP_Dougfir_treeheight.csv")

#### Smoothing of the clipped B1E1 raster file #####

#### EXU Smoothing and parameter setting #####
setwd("/Volumes/GoogleDrive-106247680948153093879/My Drive/PhD/Sappho LTEP Paper/Sappho LTEP Analysis/LTEP_Lidar/Tree Height csv files/")
minht<-8   # min tree height
fws<-5 # dimension 5x5


schm<-CHMsmoothing(clip_B1M1, "mean", 5)
treeList<-FindTreesCHM(schm, fws, minht)   # find individual trees
write.csv(treeList,"LTEP_B1M1.csv")   # write as csv

#### You'll need to change the schm code above each time to generate files for 
# the different units. For example, you could use the clip_B1M3 for the 
# next one. I decided to just have it write over itself instead of having
# 100 lines of the same code with different unit numbers. 

# error with B1E3 and with B2E2 but it seemed to run ok 

###==Plot the indv. trees detected onto the CHM (optional, just for visual reassurance)====
par(mar=c(1,1,1,1))
plot(schm, main="LiDAR-derived CHM")
XY<-SpatialPoints(treeList[,1:2]) # Spatial points
plot(XY, add=TRUE, col="red",  pch=4, cex=.5)  # plotting tree location







