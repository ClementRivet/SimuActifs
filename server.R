server <- function(input, output) {
  
  #### Data ####
  
  output$contents <- renderDataTable({
    inFile <- input$file1
    
    if (is.null(inFile) || exists('this_df', envir=.GlobalEnv)){
      my_raw_data
    } else {
      my_raw_data <<- read.csv(inFile$datapath)
      my_raw_data
      save.image()
    }
  })
  
  #### Analyse ####
  
  output$thisPlot <- renderPlotly({
    
    if(exists('this_df', envir=.GlobalEnv)){
      this_df %>%
        plot_ly(x = ~Date, type="candlestick",
                open = ~Open, close = ~Close,
                high = ~High, low = ~Low) 
    } else {
      NULL
    }
  })
  
}