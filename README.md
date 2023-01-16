# Sappho-LTEP-Spatial-Analysis

This repository includes R script and files for the Sappho Long-term Ecosystem Productivity Study (LTEP) on the Olympic Peninsula, WA. It covers 1.) converting laz files to raster files; 2.) merging rasters; 3.) overlaying shapefiles of treatment areas; 4.) creating canopy height models of treatment areas; 5.) identifying trees; and 6.) deriving site index by analyzing the tallest 20% of trees. 

This repository contains three R scripts and several zipped files: 

LTEP_Sappho_Laz_to_tiff.R

This script takes downloaded laz files for the Sappho LTEP region and converts them to tiff files for use in this analysis. The tiff’s are saved to the working directory to be used in the next file. Note: laz files are too large to upload to github. If you need these files, email me and I can share them. I have already ran this code, generated tiff files, and uploaded them to this repository so you can still run the next two R scripts without these laz files. 

LTEP_CHM.R

This file loads the tiff files from the previous file and merges them into one large raster. A shapefile of the LTEP treatment area is inputted and overlaid on the raster file. This analysis only focuses on two treatment areas and removes the others from the shapefile. The raster is clipped to only include the treatment areas. The canopy height model (CHM) is created for these areas. Next, trees are detected in the CHM. Tree heights are determined for each unit and written into separate csv files for future analysis. 


<img width="673" alt="Screen Shot 2023-01-13 at 11 09 53 AM" src="https://user-images.githubusercontent.com/121460266/212399888-d61f5a8e-1b6a-4f22-a396-2e745c2204d2.png">


Site_Index_LTEP_Sappho.R

This script uses files generated in LTEP_CHM.R that include csv files of trees heights for each experimental unit. Then, the tallest 20% of trees are calculated. This is used to determine site index. 
![image](https://user-images.githubusercontent.com/121460266/212399844-468475ee-813a-4065-847c-1716ff62d836.png)

