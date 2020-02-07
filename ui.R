source('global.R', encoding = 'UTF-8')

ui <- dashboardPagePlus(
    skin = "black",
    md = T,
    header = dashboardHeaderPlus(
        title = "Simulation de valeurs d'actifs",
        titleWidth = "300px"
    ),
    sidebar = dashboardSidebar(
        collapsed = T,
        width = "300px",
        sidebarMenu(
            menuItem("Données", tabName = "df", icon = icon("fab fa-database")),
            menuItem("Analyse", tabName = "an", icon = icon("random")),
            menuItem("Cours", tabName = "cr", icon = icon("book-open"))
        )
    ),
    body = dashboardBody(
        
        setShadow(class = "dropdown-menu"),
        tabItems(
            tabItem(
                tabName = "df",
                fluidPage(
                    box(
                        width = 12,
                        height = '900px',
                        fluidRow(
                            box(
                                width = 12,
                                fileInput("file1", "Fichier csv",
                                          buttonLabel = "Importer",
                                          accept = c(
                                              "text/csv",
                                              "text/comma-separated-values",
                                              ".csv")
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
                                        plotlyOutput('thisPlot', height = '500px'),
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
                tabName = "an"
                
                
            ),
            
            tabItem(
                tabName = "cr",
                fluidRow(
                    box(
                        title = "Y'a un bug dans la matrice !",
                        height = "600px",
                        width = 12,
                        div(
                            style = "text-align: center; vertical-align: middle;",
                            img(style = "width: 80%", src = 'images/minions.jpg')
                        )
                        
                    )
                )
                
            )
        )
    ),
    title = "Simulation de valeurs d'actifs"
)

