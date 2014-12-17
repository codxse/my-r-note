pollutantmean <- function(directory, pollutant, id = 1:332) {
    
    directory <- as.character(directory)
    pollutant <- as.character(pollutant)
    xpath = getwd()
    directory <- paste(c(xpath, '/', directory, '/'), collapse = "")
    csv_files <- list.files(directory, full.names = TRUE)
    
    for (i in id) {
        data <- rbind(read.csv(csv_files[i]))
    }
    
    data_subset <- data[[pollutant]]
    means <- mean(data_subset, na.rm = TRUE)
    means
}