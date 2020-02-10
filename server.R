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
  
  output$selectMarket <- renderUI({
    pickerInput(
      inputId = "urlName",
      label = NULL,
      choices = {if (input$typeMarket == "Forex"){
                    devisas
                 } else if (input$typeMarket == "Indices") {
                   `indices-mondiaux`
                 } else if (input$typeMarket == "Commodity") {
                   matierespremieres
                 }
        },
      selected = NULL
    )
  })
  
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
  
  
  output$setting2 <- renderUI({
    method <- input$method
    switch(method,
           "Historique"= { 
             tagList(
               pickerInput(
                 inputId = "method2",
                 label = h4("type de moyenne"), 
                 choices = c("uniforme", "Glissante"),
                 selected = NULL),
               
               actionButton("Run_analysis","Analyser")
             )})
    
  })
  
 
  observeEvent(input$Run_analysis,{
    .GlobalEnv$Resultas = new.env()
    
    method2 <- input$method2
    num_start <-input$num_start
    num_sample_train <- input$num_sample_train
    num_sample_test <- input$num_sample_test
    if(!is.null(my_raw_data) & 
       !is.null(num_start) & 
       !is.null(num_sample_train) & 
       !is.null(num_sample_test)){
      switch(method2,
            "uniforme" = {
               .GlobalEnv$Resultas$res <- Simu_Historique_unif(num_start,num_sample_train,num_sample_test)
               output$trainPlot <- renderPlotly({
                 
                 if(!is.null(.GlobalEnv$Resultas$res)){
                   data <- data.frame(.GlobalEnv$Resultas$res["vec_price_train"])
                   data %>% 
                     plot_ly(y=~vec_price_train,type="scatter", mode="lines")
                   
                 }
                 
               })
               
               output$testPlot <- renderPlotly({
                 
                 if(!is.null(.GlobalEnv$Resultas$res)){
                   data <- data.frame(.GlobalEnv$Resultas$res["vec_price_test"])
                   data %>% 
                     plot_ly(y=~vec_price_test,type="scatter", mode="lines")
                   
                 }
                 
               })
            },
            "Glissante" = {})
      
      
    }
    
    
  })
  
  output$setting <- renderUI({
    method <- input$method
    my_raw_data <- .GlobalEnv$my_raw_data
    if(!is.null(my_raw_data)){
      nb_value <- nrow(my_raw_data)
      switch(method,
             "Historique" = {
               tagList(
                 
                   numericInput("num_start","num_start",min = 1,max = nb_value,value=1),
                   numericInput("num_sample_train","num_sample_train",min = 1,max = nb_value,value=1),
                   numericInput("num_sample_test","num_sample_test",min = 1,max = nb_value,value=1)
                 
               )},
             "Monte-Carlo" = {NULL},
             "Paramétrique" = {NULL}
      )
    }
  })
  
 
  
  output$r <- renderUI({
    method <- input$method
    switch(method,
           "Historique" = {
             includeMarkdown('www/Rmd/histo.md')
           },
           "Monte-Carlo" = {NULL},
           "Paramétrique" = {NULL}
      )
  })
  
  
  
  #### Cours ####
  
  output$pdfview <- renderUI({
      tags$iframe(style="height:580px; width:100%", src="pdf/1.SimVA_29Jan2019.pdf")
  })


}
