server <- function(input, output, session) {
  
  #### Data ####
  
  output$contents <- renderDataTable({
    inFile <- input$file1
    
    if (exists('my_raw_data', envir=.GlobalEnv)){
      my_raw_data
    } else if(!is.null(inFile)){
      my_raw_data <<- read.csv(inFile$datapath)
      my_raw_data
      save.image()
    } else {
      NULL
    }
  })
  
  #### Analyse ####
  
  output$rawData <- renderPlotly({
    
    if(exists('my_raw_data', envir=.GlobalEnv)){
      my_raw_data %>%
        plot_ly(x = ~Date, type="candlestick",
                open = ~Open, close = ~Close,
                high = ~High, low = ~Low) 
    } else {
      NULL
    }
  })
  
  #### Cours ####
  
  output$pdfview <- renderUI({
      tags$iframe(style="height:580px; width:100%", src="pdf/1.SimVA_29Jan2019.pdf")
  })

  
}