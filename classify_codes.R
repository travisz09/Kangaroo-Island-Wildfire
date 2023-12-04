#Base code provided by Dr. Matthew Marcus as part of U. of AZ GIST class 601B - Remote Sensing.
##with some modifications by Travis Zalesky.

library(tidyverse)
library(caret)
validateMap = function(r, val, sampsize = 1000, class_col){
  #val = terra::vect(val)
  val = terra::vect(terra::subset(train_val[[1]], select = "Classname"))
  samp = terra::spatSample(val, size = sampsize , strata=class_col)
  x = as.data.frame(samp)
  valiSet2 <- terra::extract(r, samp)
  x$valisetVals = valiSet2[[2]]
  valiSet = x %>% select(class_col, valisetVals)
  colnames(valiSet) <- c("reference", "prediction")
  performance <- confusionMatrix(as.factor(valiSet[,"prediction"]), reference = as.factor(valiSet[,"reference"]))
  return(performance)
}

#' Cross-Validation Split for Spatial Data
#'
#' This function splits spatial data into training and validation datasets based on a specified attribute and proportion. The split is conducted on a per-class basis.
#'
#' @param dataset An sf object or a terra::vect spatial vector file. The function will convert terra::vect objects to sf format.
#' @param att The name of the column in the dataset that indicates the classes to be split. It should be a factor or character vector.
#' @param validprop A numeric value between 0 and 1 indicating the proportion of the data to be reserved for validation. The default value is 0.3, meaning 30% of the data will be used for validation and the remaining 70% for training.
#'
#' @return A list containing two elements:
#' \itemize{
#'   \item{validation}{An sf object with the validation dataset.}
#'   \item{calibration}{An sf object with the training dataset.}
#' }
#'
#' @examples
#' # Assuming 'landcover_data' is an sf object with a column 'landcover_type'
#' result <- crossvalidsp(dataset = landcover_data, att = "landcover_type", validprop = 0.25)
#' validation_data <- result$validation
#' training_data <- result$calibration
#'

#' @importFrom terra as.data.frame
#'
#' @note This function is designed to work with sf and terra::vect objects. It performs a stratified random split, ensuring that each class in the attribute is proportionally represented in both training and validation sets.
#'
#' @references
#' Pebesma, E., 2018. Simple Features for R: Standardized Support for Spatial Vector Data. The R Journal, 10(1), pp.439-446. \url{https://doi.org/10.32614/RJ-2018-009}
#'
#' Hijmans, R.J., 2020. terra: Spatial Data Analysis. R package version 0.5-10. \url{https://CRAN.R-project.org/package=terra}
#' @export
crossvalidsp <- function(dataset, att, validprop = 0.3) {
  
  # Input validation
  # if (!("sf" %in% class(dataset) || "SpatVector" %in% class(dataset))) {
  #   stop("Dataset must be an sf or terra::vect object")
  # }
  
  if (!is.numeric(validprop) || validprop < 0 || validprop > 1) {
    stop("validprop must be a numeric value between 0 and 1")
  }
  
  # Convert dataset to sf object if it is not
  if (class(dataset)[1] != "sf") {
    dataset <- sf::st_as_sf(dataset)
  }
  
  # Initialize lists for validation and calibration data
  validtot <- list()
  calibtot <- list()
  
  # Get unique values of the attribute
  uniqueclass <- unique(dataset[[att]])
  
  for (i in 1:length(uniqueclass)) {
    # Get rows where attribute is equal to the current unique value
    classrows <- which(dataset[[att]] == uniqueclass[i])
    classpoly <- dataset[classrows,]
    
    # Sample rows for validation set
    validrows <- sample(1:nrow(classpoly), round(nrow(classpoly) * validprop))
    validpoly <- classpoly[validrows,]
    calibpoly <- classpoly[-validrows,]
    
    # Append data to the lists
    validtot[[i]] <- validpoly
    calibtot[[i]] <- calibpoly
  }
  
  # Combine the lists into sf objects
  validtot <- do.call(rbind, validtot)
  calibtot <- do.call(rbind, calibtot)
  
  return(list(validation = validtot, calibration = calibtot))
}




getAccus <- function(test) {
  # Producers Accuracy
  producers <- as.data.frame(na.omit(test$byClass[,1]))
  names(producers) <- 'Producers'
  producers <- producers %>% 
    rownames_to_column(var = "Class") %>%
    mutate(Class = gsub("Class: ", "", Class),
           type = 'Producers',
           value = Producers) %>%
    select(Class, value, type)
  
  # Users Accuracy
  users <- as.data.frame(na.omit(test$byClass[,3])) # Note the change from 1 to 3 for Users accuracy
  names(users) <- 'users'
  users <- users %>% 
    rownames_to_column(var = "Class") %>%
    mutate(Class = gsub("Class: ", "", Class),
           type = 'users',
           value = users) %>%
    select(Class, value, type)
  # overall Accuracy
  overall <- cbind('overall', as.data.frame(test[["overall"]][1]), 'overall')
  names(overall) <- c('Class', 'value','type')
  # Combining the data
  accus <- rbind(producers, users,overall)
  accus <- accus %>% mutate(Accuracy=value*100)
  return(accus)
}
