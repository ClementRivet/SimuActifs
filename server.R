server <- function(input, output) {
  
  #### Data ####
  
  output$contents <- renderDataTable({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    this_df <<- read.csv(inFile$datapath)
    this_df
  })
  
  #### Analyse ####
  
  output$thisPlot <- renderPlotly({
    this_df %>%
      plot_ly(x = ~Date, type="candlestick",
              open = ~Open, close = ~Close,
              high = ~High, low = ~Low)
  })
  
}