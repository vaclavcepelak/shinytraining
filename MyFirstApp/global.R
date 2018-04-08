############################################################################
### My first Shiny app #####################################################
############################################################################


### global.R ##############################################################

library(dplyr)
library(foreign)
library(plotly)
library(shiny)

# read data from SPSS
shiny_data <- read.spss('./www/wvs1995_CZ_subset.sav', to.data.frame = TRUE,
                        use.missings = TRUE)

# select only relevant variables
selected_columns <- sapply(names(shiny_data), function(x) {
  # has some variable label
  if (attr(shiny_data, 'variable.labels')[x] == '') {
    return(FALSE)
  # is a factor variable
  } else if (!is.factor(shiny_data[[x]])) {
    return(FALSE)
  # has 2-10 levels
  } else {
    return(length(levels(shiny_data[[x]])) <= 10 & 
             length(levels(shiny_data[[x]])) >= 2)
  }
})

# df with variables and labels
variables <- data.frame(var = names(shiny_data)[selected_columns],
                        label = attr(shiny_data,
                                     'variable.labels')[selected_columns],
                        stringsAsFactors = FALSE)

# select relevant columns from shiny_data
shiny_data <- shiny_data[, selected_columns]
