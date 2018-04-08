############################################################################
### My first Shiny app #####################################################
############################################################################


### server.R ##############################################################

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  plot_table <- reactive({
    plot_table <- data.frame(table(shiny_data[[input$variable]]),
                             stringsAsFactors = FALSE)
    if (input$order == 'freq') {
      plot_table <- plot_table %>% dplyr::arrange(desc(Freq))
    } else if (input$order == 'alpha') {
      plot_table <- plot_table %>% dplyr::arrange(as.character(Var1))
    }
    plot_table$Var1 <- factor(plot_table$Var1, 
                              levels = rev(plot_table$Var1))
    
    return(plot_table)
  })
  
  output$question <- renderUI({
    ui_output <- h2(variables$label[variables$var == input$variable])
    return(ui_output)
  })
  
  output$plot <- renderPlotly({
    plot_ly(y = plot_table()$Var1, x = plot_table()$Freq, type = 'bar',
            orientation = 'h', height = 350) %>%
      layout(margin = list(l = 150))
  })
  
})
