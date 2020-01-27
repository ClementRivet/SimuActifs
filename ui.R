library(plotly)
library(shinyWidgets)
library(shinydashboard)
library(shinydashboardPlus)
library(DT)
library(waiter)

ui <- dashboardPagePlus(
    skin = "black-light",
    md = T,
    header = dashboardHeaderPlus(
        title = "Simulation de valeurs d'actifs"
    ),
    sidebar = dashboardSidebar(
        collapsed = T,
        sidebarMenu(
            menuItem("Données", tabName = "df", icon = icon("fab fa-database")),
            menuItem("Analyse", tabName = "an", icon = icon("random")),
            menuItem("Cours", tabName = "cr", icon = icon("book-open"))
        )
    ),
    body = dashboardBody(
        tabItems(
            tabItem(
                tabName = "df",
                fluidRow(
                    box(
                        width = 12,
                        fileInput("file1", "Fichier csv",
                                  buttonLabel = "Importer",
                                  accept = c(
                                      "text/csv",
                                      "text/comma-separated-values",
                                      ".csv")
                        ),
                        br(),
                        dataTableOutput("contents")
                    )
                )
            ),
            
            tabItem(
                tabName = "an",
                plotlyOutput('thisPlot', height = '500px')
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

