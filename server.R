server <- function(input, output, session) {
  
  #### Local Data ####
  
  my_raw_data <- reactive({
    inFile <- input$file1
    if (!is.null(inFile)){
      read.csv(inFile$datapath)
    } 
  })
  
  output$contents <- renderDataTable({
    my_raw_data()
  })
  
  output$rawData <- renderPlotly({
    if(!is.null(my_raw_data())){
      data <- my_raw_data()
      data %>%
        plot_ly(x = ~Date, type="candlestick",
                open = ~Open, close = ~Close,
                high = ~High, low = ~Low) 
    } else {
      NULL
    }
  })
  
  #### Data Yahoo ####
  
  observeEvent(input$urlImport, {
    urlName <- input$urlName
    .GlobalEnv$yahoo_data <- new.env()
    getSymbols(urlName, env = .GlobalEnv$yahoo_data , src = 'yahoo', verbose=TRUE)
    .GlobalEnv$my_raw_data <- data.frame(date=index(.GlobalEnv$yahoo_data[[paste0(urlName)]]), coredata(.GlobalEnv$yahoo_data[[paste0(urlName)]]))
    colnames(.GlobalEnv$my_raw_data) <- c("Date","Open","High","Low","Close","Volume","Adj Close")
    
    output$contents <- renderDataTable({
      .GlobalEnv$my_raw_data
    })
    
    output$rawData <- renderPlotly({
      .GlobalEnv$my_raw_data %>%
          plot_ly(x = ~Date, type="candlestick",
                  open = ~Open, close = ~Close,
                  high = ~High, low = ~Low) 
    })
    
  })
  
  
  
  
  
  
  
  #### Cours ####
  
  output$pdfview <- renderUI({
      tags$iframe(style="height:580px; width:100%", src="pdf/1.SimVA_29Jan2019.pdf")
  })

  
}