### Site Index Calculations for Sappho LTEP 

# Last updated: November 1, 2022

##### Load packages #####

library(dplyr)
library(tibble)
library(ggplot2)

##### data files #####

setwd("/Volumes/GoogleDrive-106247680948153093879/My Drive/PhD/Sappho LTEP Paper/Sappho LTEP Analysis/LTEP_Lidar/Tree Height csv files/")

# These files should have been generated from the LTEP_CHM.R script. They
# include the tree's XY coordinates and height. 

b1m1<- read.csv("LTEP_B1M1.csv")
b1m2<- read.csv("LTEP_B1M2.csv")
b1m3<- read.csv("LTEP_B1M3.csv")
b2m1<- read.csv("LTEP_B2M1.csv")
b2m2<- read.csv("LTEP_B2M2.csv")
b2m3<- read.csv("LTEP_B2M3.csv")

b3m1<- read.csv("LTEP_B3M1.csv")
b3m2<- read.csv("LTEP_B3M2.csv")
b3m3<- read.csv("LTEP_B3M3.csv")
b4m1<- read.csv("LTEP_B4M1.csv")
b4m2<- read.csv("LTEP_B4M2.csv")
b4m3<- read.csv("LTEP_B4M3.csv")

# early seral units
b1e1<- read.csv("LTEP_B1E1.csv")
b1e2<- read.csv("LTEP_B1E2.csv")
b1e3<- read.csv("LTEP_B1E3.csv")
b2e1<- read.csv("LTEP_B2E1.csv")
b2e2<- read.csv("LTEP_B2E2.csv")
b2e3<- read.csv("LTEP_B2E3.csv")

b3e1<- read.csv("LTEP_B3E1.csv")
b3e2<- read.csv("LTEP_B3E2.csv")
b3e3<- read.csv("LTEP_B3E3.csv")
b4e1<- read.csv("LTEP_B4E1.csv")
b4e2<- read.csv("LTEP_B4E2.csv")
b4e3<- read.csv("LTEP_B4E3.csv")

#### selecting top 20% of heights in doug-fir ####

B1M1_20<- b1m1 %>% slice_max(height, prop= 0.2)  # taking top 20%
B1M2_20<- b1m2 %>% slice_max(height, prop= 0.2)  
B1M3_20<- b1m3 %>% slice_max(height, prop= 0.2) 

B2M1_20<- b2m1 %>% slice_max(height, prop= 0.2)  
B2M2_20<- b2m2 %>% slice_max(height, prop= 0.2)  
B2M3_20<- b2m3 %>% slice_max(height, prop= 0.2) 

B3M1_20<- b3m1 %>% slice_max(height, prop= 0.2)  
B3M2_20<- b3m2 %>% slice_max(height, prop= 0.2)  
B3M3_20<- b3m3 %>% slice_max(height, prop= 0.2) 

B4M1_20<- b4m1 %>% slice_max(height, prop= 0.2)  
B4M2_20<- b4m2 %>% slice_max(height, prop= 0.2)  
B4M3_20<- b4m3 %>% slice_max(height, prop= 0.2)

####  selecting top 20% of heights in early seral #####

B1E1_20<- b1e1 %>% slice_max(height, prop= 0.2)  # taking top 20%
B1E2_20<- b1e2 %>% slice_max(height, prop= 0.2)  
B1E3_20<- b1e3 %>% slice_max(height, prop= 0.2)
B2E1_20<- b2e1 %>% slice_max(height, prop= 0.2)  
B2E2_20<- b2e2 %>% slice_max(height, prop= 0.2)  
B2E3_20<- b2e3 %>% slice_max(height, prop= 0.2)

B3E1_20<- b3e1 %>% slice_max(height, prop= 0.2)  
B3E2_20<- b3e2 %>% slice_max(height, prop= 0.2)  
B3E3_20<- b3e3 %>% slice_max(height, prop= 0.2) 
B4E1_20<- b4e1 %>% slice_max(height, prop= 0.2)  
B4E2_20<- b4e2 %>% slice_max(height, prop= 0.2)  
B4E3_20<- b4e3 %>% slice_max(height, prop= 0.2)

#### adding EXU column and selecting only height columns  ####

# Doug-fir units: 
B1M1_20<- B1M1_20 %>% select(height) %>% add_column(EXU = "B1M1") %>% add_column(Treat = "Douglas-fir")
B1M2_20<- B1M2_20 %>% select(height) %>% add_column(EXU = "B1M2") %>% add_column(Treat = "Douglas-fir")
B1M3_20<- B1M3_20 %>% select(height) %>% add_column(EXU = "B1M3") %>% add_column(Treat = "Douglas-fir")

B2M1_20<- B2M1_20 %>% select(height) %>% add_column(EXU = "B2M1") %>% add_column(Treat = "Douglas-fir")
B2M2_20<- B2M2_20 %>% select(height) %>% add_column(EXU = "B2M2") %>% add_column(Treat = "Douglas-fir")
B2M3_20<- B2M3_20 %>% select(height) %>% add_column(EXU = "B2M3") %>% add_column(Treat = "Douglas-fir")

B3M1_20<- B3M1_20 %>% select(height) %>% add_column(EXU = "B3M1") %>% add_column(Treat = "Douglas-fir")
B3M2_20<- B3M2_20 %>% select(height) %>% add_column(EXU = "B3M2") %>% add_column(Treat = "Douglas-fir")
B3M3_20<- B3M3_20 %>% select(height) %>% add_column(EXU = "B3M3") %>% add_column(Treat = "Douglas-fir")

B4M1_20<- B4M1_20 %>% select(height) %>% add_column(EXU = "B4M1") %>% add_column(Treat = "Douglas-fir")
B4M2_20<- B4M2_20 %>% select(height) %>% add_column(EXU = "B4M2") %>% add_column(Treat = "Douglas-fir")
B4M3_20<- B4M3_20 %>% select(height) %>% add_column(EXU = "B4M3") %>% add_column(Treat = "Douglas-fir")

# Early seral units:

B1E1_20<- B1E1_20 %>% select(height) %>% add_column(EXU = "B1E1") %>% add_column(Treat = "Early Seral")
B1E2_20<- B1E2_20 %>% select(height) %>% add_column(EXU = "B1E2") %>% add_column(Treat = "Early Seral")
B1E3_20<- B1E3_20 %>% select(height) %>% add_column(EXU = "B1E3") %>% add_column(Treat = "Early Seral")

B2E1_20<- B2E1_20 %>% select(height) %>% add_column(EXU = "B2E1") %>% add_column(Treat = "Early Seral")
B2E2_20<- B2E2_20 %>% select(height) %>% add_column(EXU = "B2E2") %>% add_column(Treat = "Early Seral")
B2E3_20<- B2E3_20 %>% select(height) %>% add_column(EXU = "B2E3") %>% add_column(Treat = "Early Seral")

B3E1_20<- B3E1_20 %>% select(height) %>% add_column(EXU = "B3E1") %>% add_column(Treat = "Early Seral")
B3E2_20<- B3E2_20 %>% select(height) %>% add_column(EXU = "B3E2") %>% add_column(Treat = "Early Seral")
B3E3_20<- B3E3_20 %>% select(height) %>% add_column(EXU = "B3E3") %>% add_column(Treat = "Early Seral")

B4E1_20<- B4E1_20 %>% select(height) %>% add_column(EXU = "B4E1") %>% add_column(Treat = "Early Seral")
B4E2_20<- B4E2_20 %>% select(height) %>% add_column(EXU = "B4E2") %>% add_column(Treat = "Early Seral")
B4E3_20<- B4E3_20 %>% select(height) %>% add_column(EXU = "B4E3") %>% add_column(Treat = "Early Seral")

##### Turning this into one dataset ####

df<- rbind(B1M1_20, B1M2_20, B1M3_20, B2M1_20, B2M2_20, B2M3_20,
           B3M1_20, B3M2_20, B3M3_20, B4M1_20, B4M2_20, B4M3_20)

es<- rbind(B1E1_20, B1E2_20, B1E3_20, B2E1_20, B2E2_20, B2E3_20,
           B3E1_20, B3E2_20, B3E3_20, B4E1_20, B4E2_20, B4E3_20)

LTEP<- rbind(df, es)

##### data exploration #####

tapply(LTEP$height, LTEP$Treat, FUN=range)
tapply(LTEP$height, LTEP$Treat, FUN=mean)

ggplot(data= LTEP, aes(y= height, x= Treat, fill= Treat))+ 
  geom_boxplot()

#### calculating mean tree heights ####

treeht<-tapply(LTEP$height, LTEP$EXU, FUN=mean)
as.data.frame(treeht)

#### importing new dataset w/ SI values #####

setwd("/Volumes/GoogleDrive-106247680948153093879/My Drive/PhD/Sappho LTEP Paper/Sappho LTEP Analysis/CSV files/")
SI<- read.csv("SI_values.csv")

ggplot(data= SI, aes( x= Mean_TreeHt, y= SI))+ 
  geom_point()

tapply(SI$SI, SI$Treat, FUN=mean)
range(SI$SI)

summary(lm(SI$SI~ SI$Treat))

#### Read in alder csv  #####

setwd( "/Volumes/GoogleDrive-106247680948153093879/My Drive/PhD/Sappho LTEP Paper/Sappho LTEP Analysis/CSV files")
alder<- read_csv("Alder.csv")
# dataset with both the early and mid seral alder data 
# with 5m buffers. 

#### merging alder + SI data files #####

alder_SI<-merge(alder, SI, by.x= "Unit", by.y= "ExpUnit")

summary(lm(alder_SI$SI~ alder_SI$PERCENT_ALDER))
# this is significant but R2= 0.12

summary(lm(SI$SI~ SI$Treat + SI$Wood))
# not significant 




