######==load packages====######


library(rgl)
library(mapview)
library(rLiDAR)
library(raster)
library(sp)
library(dplyr)


###==set your working directory====#####

getwd()
setwd("/Volumes/GoogleDrive-106247680948153093879/My Drive/LTEP Central/WADNR (Sappho) LTEP/WADNR Trees/2021 Lidar Analysis/SapphoGIS/Sappho_plots_georeferencing/Canopy_Height_Models/")

#### Create an object that stores a vector of tif files ####
files_tif <- Sys.glob(paste0("B4E2Las.tif"))


#### As a function ####
tif_to_CHM<-function(filename_tif){
  
  chm <- raster(filename_tif) # Store the tif file as an object 'chm' 
  schm<-CHMsmoothing(chm, "mean", 5) # Store smoothed tif as an object 'schm'
  
  
  ## Set the fws, aka the dimension of the square window that looks for independent trees
  fws<-5 # dimension 5x5
  
  ## Set the min tree height
  minht<-8
  
  ## Make and view list of invd. trees detected
  treeList<-FindTreesCHM(schm, fws, minht)
  
  
  par(mar=c(1,1,1,1))
  plot(schm, mapview=FALSE, main="LiDAR-derived CHM")
  XY<-SpatialPoints(treeList[,1:2]) # Spatial points
  plot(XY, add=TRUE, mapview=FALSE, col="red")       # plotting tree location
  
  ## Write list of individual trees as a .csv
  phrase<-filename_tif
  phrase_cut<-strsplit(phrase,"/", fixed=TRUE)[[1]]
  phrase_cut_2<-strsplit(phrase_cut[7],".", fixed=TRUE)[[1]]
  phrase_cut_3<-phrase_cut_2[1]
  output_filename<-paste0(phrase_cut_3, "_CHM.csv")
  write.csv(treeList, output_filename) 
}


#### Space to work ####

for(i in 1:length(files_tif)){
  filename_tif<-files_tif[i]
  tif_to_CHM(filename_tif)
}


##### Notes ####

# B3E3 looks like it is including the trees from the late seral unit next door
# That needs to be redone before it can be included in the analysis
# This might be also true for B1E3

# There is no tiff file for B2E2--just a file for 1 TP


