source('global.R', encoding = 'UTF-8')

ui <- dashboardPagePlus(
    skin = "black",
    md = T,
    header = dashboardHeaderPlus(
        title = tagList(
            tags$span(
                class = "logo-mini", 
                HTML('<style type="text/css">
                                .roundedImage{
                                    overflow:hidden;
                                    -webkit-border-radius:50px;
                                    -moz-border-radius:50px;
                                    border-radius:50px;
                                    width:100%;
                                    height:100%;
                                }
                             </style>
                             <div class="roundedImage">
                               <center><img src="images/mask.png" width="100%"/></center>
                             </div>')
            ),
            tags$span(class = "logo-lg", "Simulation de valeurs d'actifs")
        ),
        titleWidth = "300px"
    ),
    sidebar = dashboardSidebar(
        collapsed = T,
        width = "300px",
        sidebarMenu(
            menuItem("Données", tabName = "df", icon = icon("fab fa-database")),
            menuItem("Analyse", tabName = "an", icon = icon("random")),
            menuItem("Cours", tabName = "cr", newtab = F, icon = icon("book-open"))
        )
    ),
    body = dashboardBody(
        tags$head(
            tags$link(rel = "icon", type = "image/x-icon", href = "images/mask.ico")
        ),
        setShadow(class = "dropdown-menu"),
        tabItems(
            tabItem(
                tabName = "df",
                fluidRow(
                    box(
                        width = 12,
                        height = 'auto',
                        fluidRow(
                            box(
                                width = 12,
                                fileInput("file1", h3("Fichier csv"),
                                          buttonLabel = "Import Local",
                                          accept = c(
                                              "text/csv",
                                              "text/comma-separated-values",
                                              ".csv")
                                ),
                                br(),
                                h3("Via Yahoo Finance"),
                                fluidRow(
                                    column(
                                      width = 3,
                                      pickerInput(
                                          inputId = "urlName",
                                          choices = c(CAC40 = "^FCHI", 
                                                      EURUSD = "EURUSD=X"
                                                    ),
                                          selected = NULL
                                      )
                                    ),
                                    column(
                                      width = 3,
                                      actionButton("urlImport", label = "Importation")
                                    )
                                )
                            ),
                            tabBox(
                                width = 12,
                                height = "600px",
                                
                                tabPanel(
                                    "Data frame",
                                    width = 12,
                                    dataTableOutput("contents")
                                ),
                                tabPanel(
                                    "Graphique",
                                    width = 12,
                                    heigth = 'auto',
                                    withLoader(
                                        plotlyOutput('rawData', height = '500px'),
                                        type = "html",
                                        loader = "dnaspin"
                                    )
                                ) 
                            )
                        )  
                    ) 
                )
            ),
            
            tabItem(
                tabName = "an",
                
                sidebarLayout(
                    sidebarPanel(
                        width = 3,
                        h2("Paramétrages"),
                        pickerInput(
                            inputId = "method",
                            label = h4("Méthode analyse"), 
                            choices = c("Monte-Carlo", "Historique", "Paramétrique"),
                            selected = NULL
                        ),
                        br(),
                        pickerInput(
                            inputId = "ml",
                            label = h4("Inclure du Machine Learnig"), 
                            choices = c("Régression non Linéaire", 
                                        "Régression Linéaire", 
                                        "FFNN",
                                        "K-Means"
                                        ),
                            selected = NULL
                        ),
                        br(),
                        pickerInput(
                            inputId = "lang",
                            label = h4("Langage de programmation"), 
                            choices = c("R", 
                                        "Python"
                                        ),
                            selected = NULL
                        )
                        
                    ),
                    mainPanel(
                      width = 9,
                      box(
                          width = 12,
                          fluidRow(
                              withLoader(
                                  plotlyOutput('toPlot', height = '500px'),
                                  type = "html",
                                  loader = "dnaspin"
                              )
                          ),
                          fluidRow(
                              
                          )  
                      )
                    ), 
                    position = "left",
                    fluid = TRUE
                )
            ),
            
            tabItem(
                tabName = "cr",
                # fluidRow(
                #     box(
                #         title = "Y'a un bug dans la matrice !",
                #         height = "600px",
                #         width = 12,
                #         div(
                #             style = "text-align: center; vertical-align: middle;",
                #             img(style = "width: 80%", src = 'images/minions.jpg')
                #         )
                #         
                #     )
                # )
                fluidRow(
                    box(
                        height = "600px",
                        width = 12,
                        uiOutput("pdfview"),
                        #tags$iframe(style="height:600px; width:100%", src="http://localhost/ressources/pdf/1.SimVA_29Jan2019.pdf")
                    )
                )
            )
        )
    ),
    title = "Simulation de valeurs d'actifs"
)

