server <- function(input, output) {
  
  #### Data ####
  
  output$contents <- renderDataTable({
    inFile <- input$file1
    
    if (is.null(inFile) || exists('this_df', envir=.GlobalEnv)){
      this_df
    } else {
      this_df <<- read.csv(inFile$datapath)
      this_df
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