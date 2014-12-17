complete <- function(directory, id = 1:332) {
    
    directory <- as.character(directory)
    xpath = getwd()
    directory <- paste(c(xpath, '/', directory, '/'), collapse = "")
    csv_files <- list.files(directory, full.names = TRUE)
    
    nobs <- NULL
    for (i in id) {
        xnobs <- sum(complete.cases(read.csv(csv_files[i])))
        nobs <- c(nobs, xnobs)
    }

    data.frame(id, nobs)
}