#Travis Zalesky
#GIST 601B - Remote Sensing
#Final: Australian Wildfires Kangaroo Island
#11/28/2023

#Objectives: 
### 1. Showcase my remote sensing knowledge and skills.
### 2. Describe the impacts and recovery of the "Black Summer" fires on Kangaroo
###     Island, Australia. 
### 3. Use machine learning to classify land cover pre and post fire.
### 4. Calculate dNBR and describe long term recovery, 3 years post fire.

#Packages
library(terra)
#library(raster)

#Set WD
wd <- "C:/Users/travi/Documents/Education/UoA/GIST 601B/Labs/Aus Wildfire - Final"
setwd(wd)
#getwd() #check wd



###First Image -----
sub <- "Fire"
dir(paste(sub, "Data", sep = "/"))
tarFile <- list.files(paste(sub, "Data", sep = "/"), pattern = ".tar")

#untar(paste(sub, "Data", tarFile, sep = "/"), 
 #     exdir = paste(sub, "Data", sep = "/"))

dir(paste(sub, "Data", sep = "/"))

ls <- list.files(paste(sub, "Data", sep = "/"), pattern = "B\\d+.TIF")
ls

im1 <- rast(paste(sub, "Data", ls, sep = "/"))

plotRGB(im1, r = 4, g = 3, b = 2, stretch = "lin")

e <- ext(633959, 785100, -4050000, -3930811)
plotRGB(im1, r = 4, g = 3, b = 2, stretch = "lin")
plot(e, add = T)

im1_e <- crop(im1, e)

plotRGB(im1_e, r = 4, g = 3, b = 2, stretch = "lin")

writeRaster(im1_e, filename = paste(sub, "Data/20200109_Crop.tif", sep = "/"),
            overwrite = T)

png(paste(sub, "Output/True_Color1.png", sep = "/"), bg = 0)
plotRGB(im1_e, r = 4, g = 3, b = 2, stretch = "lin")
dev.off()

plotRGB(im1_e, r=8, g=3, b=2, stretch = "lin")
png(paste(sub, "Output/Thermal1.png", sep = "/"), bg = 0)
plotRGB(im1_e, r = 8, g = 3, b = 2, stretch = "lin")
dev.off()

plotRGB(im1_e, r = 8, g = 4, b = 3, stretch = "lin")
png(paste(sub, "Output/Thermal2.png", sep = "/"), bg = 0)
plotRGB(im1_e, r = 8, g = 4, b = 3, stretch = "lin")
dev.off()

###Initial Prefire -----
sub <- "Prefire1"

dir(paste(sub, "Data", sep = "/"))
tarFile <- list.files(paste(sub, "Data", sep = "/"), pattern = ".tar")

#untar(paste(sub, "Data", tarFile, sep = "/"), 
 #    exdir = paste(sub, "Data", sep = "/"))

dir(paste(sub, "Data", sep = "/"))

ls <- list.files(paste(sub, "Data", sep = "/"), pattern = "B\\d+.TIF")
ls

im3 <- rast(paste(sub, "Data", ls, sep = "/"))

plotRGB(im3, r = 4, g = 3, b = 2, smooth = T, stretch = "lin")

e <- ext(633959, 785100, -4000000, -3930811)
plotRGB(im2, r = 4, g = 3, b = 2, stretch = "lin")
plot(e, add = T)

im3_e <- crop(im3, e)

plotRGB(im3_e, r = 4, g = 3, b = 2, stretch = "lin")

writeRaster(im3_e, filename = paste(sub, "Data/20190223_Crop.tif", sep = "/"))

png(paste(sub, "Output/True_Color1.png", sep = "/"), bg = 0)
plotRGB(im3_e, r = 4, g = 3, b = 2, stretch = "lin")
dev.off()

plotRGB(im3_e, r=8, g=3, b=2, stretch = "lin")
png(paste(sub, "Output/Thermal1.png", sep = "/"), bg = 0)
plotRGB(im3_e, r = 8, g = 3, b = 2, stretch = "lin")
dev.off()

plotRGB(im3_e, r = 8, g = 4, b = 3, stretch = "lin")
png(paste(sub, "Output/Thermal2.png", sep = "/"), bg = 0)
plotRGB(im3_e, r = 8, g = 4, b = 3, stretch = "lin")
dev.off()

### Clip Raster in ArcGIS Pro
im3_clip <- rast(paste(sub, "Data/20190223_Clip.tif", sep = "/"))
plotRGB(im3_clip, r = 4, g = 3, b = 2, stretch = "lin")

#Calculate Indices
##NBR = (NIR-SWIR2)/(NIR+SWIR2)
initNBR_pre <- (im3_clip[[5]]-im3_clip[[7]])/(im3_clip[[5]]+im3_clip[[7]])
plot(initNBR_pre, axes = F)

##NDVI = (NIR-Red)/(NIR+Red)
initNDVI_pre <- (im3_clip[[5]]-im3_clip[[4]])/(im3_clip[[5]]+im3_clip[[4]])
plot(initNDVI_pre, axes = F)

im3_clip <- c(im3_clip, initNBR_pre, initNDVI_pre)
names(im3_clip) <- c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B10", "NBR", "NDVI")

writeRaster(im3_clip, filename = paste(sub, "Data/20200210_ClipPlus.tif", sep = "/"))

###Initial Postfire -----
sub <- "Postfire1"

dir(paste(sub, "Data", sep = "/"))
tarFile <- list.files(paste(sub, "Data", sep = "/"), pattern = ".tar")

#untar(paste(sub, "Data", tarFile, sep = "/"), 
 #     exdir = paste(sub, "Data", sep = "/"))

dir(paste(sub, "Data", sep = "/"))

ls <- list.files(paste(sub, "Data", sep = "/"), pattern = "B\\d+.TIF")
ls

im2 <- rast(paste(sub, "Data", ls, sep = "/"))

plotRGB(im2, r = 4, g = 3, b = 2, smooth = T, stretch = "lin")

e <- ext(633959, 785100, -4000000, -3930811)
plotRGB(im2, r = 4, g = 3, b = 2, stretch = "lin")
plot(e, add = T)

im2_e <- crop(im2, e)

#Rescale bands 
#{start <- Sys.time()
#im2_e[[1]] <- im2_e[[1]]-im2_e[[1]]@pnt[["range_min"]]
#im2_e[[2]] <- im2_e[[2]]-im2_e[[2]]@pnt[["range_min"]]
#im2_e[[3]] <- im2_e[[3]]-im2_e[[3]]@pnt[["range_min"]]
#im2_e[[4]] <- im2_e[[4]]-im2_e[[4]]@pnt[["range_min"]]
#im2_e[[5]] <- im2_e[[5]]-im2_e[[5]]@pnt[["range_min"]]
#im2_e[[6]] <- im2_e[[6]]-im2_e[[6]]@pnt[["range_min"]]
#im2_e[[7]] <- im2_e[[7]]-im2_e[[7]]@pnt[["range_min"]]
#im2_e[[8]] <- im2_e[[8]]-im2_e[[8]]@pnt[["range_min"]]
#stop <- Sys.time()
#print(stop-start)} #End Rescale block

plotRGB(im2_e, r = 4, g = 3, b = 2, stretch = "lin")

writeRaster(im2_e, filename = paste(sub, "Data/20200210_Crop.tif", sep = "/"),
            overwrite = T)

png(paste(sub, "Output/True_Color1.png", sep = "/"), bg = 0)
plotRGB(im2_e, r = 4, g = 3, b = 2, stretch = "lin")
dev.off()


plotRGB(im2_e, r=8, g=3, b=2, stretch = "lin")
png(paste(sub, "Output/Thermal1.png", sep = "/"), bg = 0)
plotRGB(im2_e, r = 8, g = 3, b = 2, stretch = "lin")
dev.off()

plotRGB(im2_e, r = 8, g = 4, b = 3, stretch = "lin")
png(paste(sub, "Output/Thermal2.png", sep = "/"), bg = 0)
plotRGB(im2_e, r = 8, g = 4, b = 3, stretch = "lin")
dev.off()
### Clip Raster in ArcGIS Pro
im2_clip <- rast(paste(sub, "Data/20200210_Clip.tif", sep = "/"))
plotRGB(im2_clip, r = 4, g = 3, b = 2, stretch = "lin")

#Calculate Indicies
##NBR = (NIR-SWIR2)/(NIR+SWIR2)
initNBR_post <- (im2_clip[[5]]-im2_clip[[7]])/(im2_clip[[5]]+im2_clip[[7]])
plot(initNBR_post, axes = F)

##NDVI = (NIR-Red)/(NIR+Red)
initNDVI_post <- (im2_clip[[5]]-im2_clip[[4]])/(im2_clip[[5]]+im2_clip[[4]])
plot(initNDVI_post, axes = F)

im2_clip <- c(im2_clip, initNBR_post, initNDVI_post)
names(im2_clip) <- c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B10", "NBR", "NDVI")

writeRaster(im2_clip, filename = paste(sub, "Data/20200210_ClipPlus.tif", sep = "/"))

### Initial dNBR ----
initdNBR <- initNBR_pre - initNBR_post
plot(initdNBR, axes = F)

writeRaster(initdNBR, filename = "Postfire1/Output/dNBR.tif")

## Reclassify and calculate burn severity in ArcGIS Pro


###Extended Prefire -----
sub <- "Prefire2"

dir(paste(sub, "Data", sep = "/"))
tarFile <- list.files(paste(sub, "Data", sep = "/"), pattern = ".tar")

#untar(paste(sub, "Data", tarFile, sep = "/"), 
 #   exdir = paste(sub, "Data", sep = "/"))

dir(paste(sub, "Data", sep = "/"))

ls <- list.files(paste(sub, "Data", sep = "/"), pattern = "B\\d+.TIF")
ls

im4 <- rast(paste(sub, "Data", ls, sep = "/"))

plotRGB(im4, r = 4, g = 3, b = 2, stretch = "lin")

e <- ext(633959, 785100, -4000000, -3930811)
plotRGB(im4, r = 4, g = 3, b = 2, stretch = "lin")
plot(e, add = T)

im4_e <- crop(im4, e)

plotRGB(im4_e, r = 4, g = 3, b = 2, stretch = "lin")

writeRaster(im4_e, filename = paste(sub, "Data/20191208_Crop.tif", sep = "/"))

png(paste(sub, "Output/True_Color1.png", sep = "/"), bg = 0)
plotRGB(im4_e, r = 4, g = 3, b = 2, stretch = "lin")
dev.off()

plotRGB(im4_e, r=8, g=3, b=2, stretch = "lin")
png(paste(sub, "Output/Thermal1.png", sep = "/"), bg = 0)
plotRGB(im4_e, r = 8, g = 3, b = 2, stretch = "lin")
dev.off()

plotRGB(im4_e, r = 8, g = 4, b = 3, stretch = "lin")
png(paste(sub, "Output/Thermal2.png", sep = "/"), bg = 0)
plotRGB(im4_e, r = 8, g = 4, b = 3, stretch = "lin")
dev.off()
### Clip Raster in ArcGIS Pro
im4_clip <- rast(paste(sub, "Data/20191208_Clip.tif", sep = "/"))
plotRGB(im4_clip, r = 4, g = 3, b = 2, stretch = "lin")

#Calculate Indicies
##NBR = (NIR-SWIR2)/(NIR+SWIR2)
extNBR_pre <- (im4_clip[[5]]-im4_clip[[7]])/(im4_clip[[5]]+im4_clip[[7]])
plot(extNBR_pre, axes = F)

##NDVI = (NIR-Red)/(NIR+Red)
extNDVI_pre <- (im4_clip[[5]]-im4_clip[[4]])/(im4_clip[[5]]+im4_clip[[4]])
plot(extNDVI_pre, axes = F)

im4_clip <- c(im4_clip, extNBR_pre, extNDVI_pre)
names(im4_clip) <- c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B10", "NBR", "NDVI")

writeRaster(im4_clip, filename = paste(sub, "Data/20191208_ClipPlus.tif", sep = "/"))

###Extended Postfire -----
sub <- "Postfire2"

dir(paste(sub, "Data", sep = "/"))
tarFile <- list.files(paste(sub, "Data", sep = "/"), pattern = ".tar")

#untar(paste(sub, "Data", tarFile, sep = "/"), 
 #    exdir = paste(sub, "Data", sep = "/"))

dir(paste(sub, "Data", sep = "/"))

ls <- list.files(paste(sub, "Data", sep = "/"), pattern = "B\\d+.TIF")
ls

im5 <- rast(paste(sub, "Data", ls, sep = "/"))

plotRGB(im5, r = 4, g = 3, b = 2, stretch = "lin")

e <- ext(633959, 785100, -4000000, -3930811)
plotRGB(im5, r = 4, g = 3, b = 2, stretch = "lin")
plot(e, add = T)

im5_e <- crop(im5, e)

plotRGB(im5_e, r = 4, g = 3, b = 2, stretch = "lin")

writeRaster(im5_e, filename = paste(sub, "Data/20201226_Crop.tif", sep = "/"),
            overwrite = T)

png(paste(sub, "Output/True_Color1.png", sep = "/"), bg = 0)
plotRGB(im5_e, r = 4, g = 3, b = 2, stretch = "lin")
dev.off()


plotRGB(im5_e, r=8, g=3, b=2, stretch = "lin")
png(paste(sub, "Output/Thermal1.png", sep = "/"), bg = 0)
plotRGB(im5_e, r = 8, g = 3, b = 2, stretch = "lin")
dev.off()

plotRGB(im5_e, r = 8, g = 4, b = 3, stretch = "lin")
png(paste(sub, "Output/Thermal2.png", sep = "/"), bg = 0)
plotRGB(im5_e, r = 8, g = 4, b = 3, stretch = "lin")
dev.off()
### Clip Raster in ArcGIS Pro
im5_clip <- rast(paste(sub, "Data/20201226_Clip.tif", sep = "/"))
plotRGB(im5_clip, r = 4, g = 3, b = 2, stretch = "lin")

#Calculate Indicies
##NBR = (NIR-SWIR2)/(NIR+SWIR2)
extNBR_post <- (im5_clip[[5]]-im5_clip[[7]])/(im5_clip[[5]]+im5_clip[[7]])
plot(extNBR_post, axes = F)

##NDVI = (NIR-Red)/(NIR+Red)
extNDVI_post <- (im5_clip[[5]]-im5_clip[[4]])/(im5_clip[[5]]+im5_clip[[4]])
plot(extNDVI_post, axes = F)

im5_clip <- c(im5_clip, initNBR_post, initNDVI_post)
names(im5_clip) <- c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B10", "NBR", "NDVI")

writeRaster(im5_clip, filename = paste(sub, "Data/20200210_ClipPlus.tif", sep = "/"))

### Extended dNBR ----
extdNBR <- extNBR_pre - extNBR_post
plot(extdNBR, axes = F)


writeRaster(extdNBR, filename = "Postfire2/Output/dNBR.tif")

## Reclassify and calculate burn severity in ArcGIS Pro

### 2023 (5.42% land cloud cover) ----
sub <- "2023"

dir(paste(sub, "Data", sep = "/"))
tarFile <- list.files(paste(sub, "Data", sep = "/"), pattern = ".tar")

#untar(paste(sub, "Data", tarFile, sep = "/"), 
 #   exdir = paste(sub, "Data", sep = "/"))

dir(paste(sub, "Data", sep = "/"))

ls <- list.files(paste(sub, "Data", sep = "/"), pattern = "B\\d+.TIF")
ls

im6 <- rast(paste(sub, "Data", ls, sep = "/"))

plotRGB(im6, r = 4, g = 3, b = 2, stretch = "lin")

e <- ext(633959, 785100, -4000000, -3930811)
plotRGB(im6, r = 4, g = 3, b = 2, stretch = "lin")
plot(e, add = T)

im6_e <- crop(im6, e)

plotRGB(im6_e, r = 4, g = 3, b = 2, stretch = "lin")

writeRaster(im6_e, filename = paste(sub, "Data/20231008_Crop.tif", sep = "/"),
            overwrite = T)

png(paste(sub, "Output/True_Color1.png", sep = "/"), bg = 0)
plotRGB(im6_e, r = 4, g = 3, b = 2, stretch = "lin")
dev.off()


plotRGB(im6_e, r=8, g=3, b=2, stretch = "lin")
png(paste(sub, "Output/Thermal1.png", sep = "/"), bg = 0)
plotRGB(im6_e, r = 8, g = 3, b = 2, stretch = "lin")
dev.off()

plotRGB(im6_e, r = 8, g = 4, b = 3, stretch = "lin")
png(paste(sub, "Output/Thermal2.png", sep = "/"), bg = 0)
plotRGB(im6_e, r = 8, g = 4, b = 3, stretch = "lin")
dev.off()
### Clip Raster in ArcGIS Pro
im6_clip <- rast(paste(sub, "Data/20231008_Clip.tif", sep = "/"))
plotRGB(im6_clip, r = 4, g = 3, b = 2, stretch = "lin")

#Calculate Indicies
##NBR = (NIR-SWIR2)/(NIR+SWIR2)
extNBR_2023 <- (im6_clip[[5]]-im6_clip[[7]])/(im6_clip[[5]]+im6_clip[[7]])
plot(extNBR_2023, axes = F)

##NDVI = (NIR-Red)/(NIR+Red)
extNDVI_2023 <- (im6_clip[[5]]-im6_clip[[4]])/(im6_clip[[5]]+im6_clip[[4]])
plot(extNDVI_2023, axes = F)

im6_clip <- c(im6_clip, initNBR_post, initNDVI_post)
names(im6_clip) <- c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B10", "NBR", "NDVI")

writeRaster(im6_clip, filename = paste(sub, "Data/20231008_ClipPlus.tif", sep = "/"))

### 2023 dNBR ----
extdNBR_2023 <- extNBR_pre - extNBR_2023
plot(extdNBR_2023, axes = F)


writeRaster(extdNBR_2023, filename = "2023/Output/dNBR.tif")

## Reclassify and calculate burn severity in ArcGIS Pro

###MOD13Q1 -----
library(tidyverse)
library(lubridate)
library(zoo)

sub <- "MOD13Q1"
ls <- list.files(path = sub, pattern = ".csv")

df <- read.csv(paste(sub, ls, sep = "/"))%>%
  select('date', "min", "max", "sum", "range", "mean", "variance", 
         "standard_deviation", "tot_pixels")%>%
  mutate(date = as.Date(mdy(date)),
         across(2:9, function(x) as.numeric(as.character(x))))%>%
  filter(if_any(everything(), ~ !is.na(.)))%>%
  mutate(mean48 = rollmean(mean, 3, fill = NA),
         dayNum = as.numeric(date - min(date)))

source("C:/Users/travi/Documents/My Code/R Tutorial and Conventions/ggplot theme/ggplot theme.R")

ggplot(subset(df, date >= ymd("2012-01-01")), aes(date, mean48))+
  #stat_smooth(col = "black", se = F, fullrange=TRUE, linewidth = 0.7)+
  geom_vline(xintercept = mdy("12/20/2019"), col = "red", linewidth = 1)+
  geom_line(linewidth = 1)+
  labs(title = "MODIS/Terra Vegetation Indices",
       subtitle = "Kangaroo Island",
       y = "48 Day Mean MOD13Q1")
ggsave(filename = "MOD13Q1/MOD13Q1_48Day.png")

prefireMax <- max(subset(df, date > ymd("2012-01-01") & date <= ymd("2019-12-01"))$mean48, na.rm = T)
prefireMin <- min(subset(df, date > ymd("2012-01-01") & date <= ymd("2019-12-01"))$mean48, na.rm = T)
prefireMean <- mean(subset(df, date > ymd("2012-01-01") & date <= ymd("2019-12-01"))$mean48, na.rm = T)
fireMin <- min(subset(df, date >= ymd("2019-12-01"))$mean48, na.rm = T)
postfireMax <- max(subset(df, date >= ymd("2019-12-01"))$mean48, na.rm = T)
min(subset(df, year(date) == "2023")$mean48, na.rm = T)

### dNBR reclass figures -----
colors <- c("darkgreen", "green", "gold3", "tomato", "red", "red4")

initdNBR_reclass <- rast("Postfire1/Data/InitdNBR.tif")
png("Postfire1/Output/dNBR Reclass.png", width = 1500, height = 660)
plot(initdNBR_reclass, col = colors, axes = F, legend = "topright", 
     background = "#A1CDEF",
     plg=list( # parameters for drawing legend
       title.cex = 2, # Legend title size
       cex = 2 # Legend text size
     ),
     mar=c(1,0,5,0), 
     main = "Initial dNBR", cex.main = 5)

dev.off()
png("Postfire1/Output/dNBR Reclass Alt.png", width = 1500, height = 660)
plot(initdNBR_reclass, col = colors, axes = F, legend = NA, 
     background = "#A1CDEF", mar=c(1,0,5,0), 
     main = "Initial dNBR", cex.main = 5)
dev.off()


extdNBR_reclass <- rast("Postfire2/Data/ExtdNBR.tif")
png("Postfire2/Output/dNBR Reclass.png", width = 1500, height = 660)
plot(extdNBR_reclass, col = colors, axes = F, legend = "topright", 
     background = "#A1CDEF", 
     plg=list( # parameters for drawing legend
       title = "dNBR",
       title.cex = 2, # Legend title size
       cex = 2 # Legend text size
     ),
     mar=c(1,0,5,0),
     main = "Initial dNBR", cex.main = 5)
dev.off()
png("Postfire2/Output/dNBR Reclass Alt.png", width = 1500, height = 660)
plot(extdNBR_reclass, col = colors, axes = F, legend = NA, 
     background = "#A1CDEF", mar=c(1,0,5,0),
     main = "Initial dNBR", cex.main = 5)
dev.off()

dNBR2023_reclass <- rast("2023/Data/2023dNBR_Reclass.tif")
png("2023/Output/dNBR Reclass.png", width = 1500, height = 660)
plot(dNBR2023_reclass, col = colors, axes = F, legend = "topright", 
     background = "#A1CDEF", 
     plg=list( # parameters for drawing legend
       title = "dNBR",
       title.cex = 2, # Legend title size
       cex = 2 # Legend text size
       ),
     mar=c(1,0,5,0), #mar=c(bottom, left, top, right)
     main = "Initial dNBR", cex.main = 5)
dev.off()
png("2023/Output/dNBR Reclass Alt.png", width = 1500, height = 660)
plot(dNBR2023_reclass, col = colors, axes = F, legend = NA, 
     background = "#A1CDEF", mar=c(1,0,5,0), 
     main = "Initial dNBR", cex.main = 5)
dev.off()


{start <- Sys.time()
  png("Reclass Comp.png", width = 3000, height = 1320)
par(mfrow = c(2,2))
plot(initdNBR_reclass, col = colors, axes = F, legend = NA, 
     background = "#A1CDEF", mar=c(1,2,5,1), #mar=c(bottom, left, top, right)
     main = "Initial dNBR", cex.main = 7)
plot(extdNBR_reclass, col = colors, axes = F, legend = NA, 
     background = "#A1CDEF", mar=c(1,1,5,2),#mar=c(bottom, left, top, right)
     main = "Extended dNBR", cex.main = 7)
plot(dNBR2023_reclass, col = colors, axes = F, #legend = "right", 
     background = "#A1CDEF", mar=c(2,2,5,1),#mar=c(bottom, left, top, right)
     plg=list( # parameters for drawing legend
       cex = 8 # Legend text size
     ),
     main = "Long Term Recovery", cex.main = 7)
dev.off()
stop <- Sys.time()
print(stop-start)}

### RF classification ----------
library(sf)
library(randomForest)
library(beepr)

train <- vect(paste("Postfire1/Data",
                    list.files(path = "Postfire1/Data", pattern = ".shp"), sep ="/"))
im <- rast(paste("Postfire1/Data",
                 list.files(path = "Postfire1/Data", pattern = "ClipPlus.tif"), sep ="/"))
initdNBR <- rast(paste("Postfire1/Data",
                       list.files(path = "Postfire1/Data", pattern = "dNBR.tif$"), sep ="/"))

initdNBR <- project(initdNBR, im)
im <- c(im, initdNBR)
names(im)
names(im)[11] <- "dNBR"

plotRGB(im, r=4,g=3,b=2, stretch='lin')
plot(train, add = TRUE, col = "red")

train <- project(train, im)

# partition the training data into training and validation
source("C:/Users/travi/Documents/Education/UoA/GIST 601B/Labs/Lab 10/classify_codes.R")
train_val <- crossvalidsp(train, att = "Classname")

## run a random forest classification using the partitioned training data
# Extract predictor values based on the geometry of the training data
extracted_values <- terra::extract(im, train_val[[2]])

training_data <- as.data.frame(train_val[[2]])

training_data$ID <- 1:nrow(as.data.frame(training_data))  # inserts column of integers, needed for matching in next step

# Match class names to integers in new DF
extracted_values$Classname <- training_data$Classname[match(extracted_values$ID, training_data$ID)]

# Ensure the class column is formatted as a factor
extracted_values$Classname <- as.factor(extracted_values$Classname)
extracted_values <- extracted_values[-1]

# run the random forest
{start <- Sys.time()
  rf <- randomForest(formula = Classname ~ ., data = extracted_values, 
                     ntree = 1000, na.action = na.omit,
                     importance = TRUE, type = "classification")
  stop <- Sys.time()
  print(stop-start)
  beep("mario")}

# Use the random forest to generate a raster with the predict function
{start <- Sys.time()
  classification <- terra::predict(object = im, model = rf, type = "class", 
                                   na.rm = TRUE)
  stop <- Sys.time()
  print(stop-start)
  beep("mario")}

col <- c("grey10", "darkred", "olivedrab", "khaki", "ghostwhite", "plum", "blue2")
plot(classification, col = col, axes = F, main = "Random Forest Classification")

png(filename = "Postfire1/Output/RF_Classification.png", 
    width = 1500, height = 660)
plot(classification, col = col, axes = F, legend = "topright",
     main = "Random Forest Classification", cex.main = 5,
     plg=list( # parameters for drawing legend
       title.cex = 2, # Legend title size
       cex = 2 # Legend text size
     ),
     mar=c(1,0,5,0),
     background = "#A1CDEF",)
dev.off()
### Here you should reset the working directory to wherever you want to save your map
#dir.create("Images")
#writeRaster(classification, filename = "Images/Classification1.tif", datatype = "INT1U")

# validate the map
val <- validateMap(classification, val = train_val[[1]], sampsize = 1000, class_col = "Classname")
val

accs <- getAccus(val)

## plot your accuracy
df <- accs%>%
  dplyr::filter(Class != "overall")%>%# drop overall
  mutate(Class = replace(Class, Class == "Pasture/Agriculture", "Pasture/ Agriculture"))

vals <- c("#00CC00", "#377EB8") # green and blue codes
labs <- c("Producer's Accuracy","User's Accuracy" )

#Set plotting theme
source("C:/Users/travi/Documents/My code/R Tutorial and Conventions/ggplot theme/ggplot Theme.R")

accPlot <- ggplot(df, aes(x = Class, y = Accuracy, fill = factor(type))) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  scale_x_discrete("Classes") +
  scale_y_continuous("Accuracy %") +
  scale_fill_manual(values = vals,
                    labels = function(x) str_wrap(labs, width = 10)) +
  ggtitle("Random Forest Classification Accuracy")+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10))+
  theme(axis.text.x = element_text(angle = 65, hjust = 1, vjust = 1), 
        legend.title = element_blank())
print(accPlot)
ggsave(accPlot, path = "Postfire1/Output", filename = "accPlot.png", height = 6, width = 9)



