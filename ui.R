library(plotly)
library(shinyWidgets)
library(shinydashboard)
library(shinydashboardPlus)
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
            menuItem("Analyse", tabName = "an", icon = icon("random"))
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
                                  accept = c(
                                      "text/csv",
                                      "text/comma-separated-values,text/plain",
                                      ".csv")
                        ),
                        br(),
                        tableOutput("contents")
                    )
                )
            ),
            
            tabItem(
                tabName = "an",
                
            )
        )
    ),
    title = "Simulation de valeurs d'actifs"
)

