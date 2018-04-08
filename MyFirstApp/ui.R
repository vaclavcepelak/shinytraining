############################################################################
### My first Shiny app #####################################################
############################################################################


### ui.R ##################################################################

library(shiny)

# Define UI for application
shinyUI(fluidPage(
  # Title of the app
  titlePanel("My first app"), 
  
  # Define the sidebar layout
  sidebarLayout(
    
    sidebarPanel(
      # add select box
      selectInput('variable', label = 'Select variable: ',
                  choices = variables$var),
      # add radio button
      radioButtons('order', label = 'Ordering options: ',
                   choiceNames = c('None', 'Sort by frequency', 
                                   'Sort alphabetically'),
                   choiceValues = c('none', 'freq', 'alpha'),
                   selected = 'none'),
      tags$img(src = 'Ipsos-logo.jpg', align = "center", 
               height = 50, width = 50),
      tags$h4('Created by ', tags$b('Ipsos'))
    ),
    
    mainPanel(
      # variable label as HTML
      uiOutput('question'),
      # plot
      plotlyOutput('plot')
    )
  )
))
