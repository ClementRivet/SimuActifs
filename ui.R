library(plotly)
library(shinyWidgets)
library(shinydashboard)
library(shinydashboardPlus)
library(DT)
#library(waiter)
library(shinycustomloader)

ui <- dashboardPagePlus(
    skin = "black-light",
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
        use_hostess(), # include dependencies
        hostess_loader("load", text_color = "black", center_page = TRUE),
        
        setShadow(class = "dropdown-menu"),
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
                withLoader(
                    plotlyOutput('thisPlot', height = '500px'),
                    type = "html",
                    loader = "dnaspin"
                )
                
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

