source('global.R', encoding = 'UTF-8')

ui <- dashboardPagePlus(
    skin = "black",
    md = T,
    header = dashboardHeaderPlus(

        enable_rightsidebar = TRUE,
        rightSidebarIcon = "gears",

        title = includeHTML('www/html/logo.html'),

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
        use_waitress(),
        setShadow(class = "dropdown-menu"),
        tags$head(
            tags$script('
                  // Define function to set height of tabBox
                  setHeight = function() {
                    var window_height = $(window).height();
                    var header_height = $(".main-header").height();
                    var render_code_height = $(".tab-content").height();

                    var fluid_page_height = window_height - header_height + render_code_height - 250;

                    $(".render_code").height(fluid_page_height);
                  };

                  // Set input$box_height when the connection is established
                  $(document).on("shiny:connected", function(event) {
                    setHeight();
                  });

                  // Refresh the box height on every window resize event
                  $(window).on("resize", function(){
                    setHeight();
                  });

                '),
            tags$style('.nav.nav-tabs.nav-justified.control-sidebar-tabs{
                            background: #000000;
                       }')
        ),
        tabItems(
            tabItem(
                tabName = "df",
                fluidPage(
                    box(
                        width = 12,
                        height = 'auto',
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
                                h3("Via Yahoo Finance"),
                                fluidRow(
                                    style="align-items: start; margin: 0px;",
                                    column(
                                        3,
                                        offset = 1,
                                        pickerInput(
                                            inputId = "typeMarket",
                                            label = NULL,
                                            choices = c("Forex", "Indices", "Commodity"),
                                            selected = NULL
                                        )
                                    ),
                                    column(
                                        3,
                                        offset = 1,
                                        uiOutput("selectMarket")
                                    ),
                                    column(
                                        3,
                                        offset = 1,
                                        actionButton(
                                            "urlImport", 
                                            label = "Importation",
                                            style = "padding-bottom: 7px; margin: 35px 0 0 0;"
                                        )
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
                div(
                    class = "render_code", 
                    sidebarLayout(
                        sidebarPanel(
                            width = 3,
                            h2("Paramétrages"),
                            h3("Vous avez importez :"),
                            uiOutput('current_data'),
                            pickerInput(
                                inputId = "method",
                                label = h4("Méthode d'analyse"), 
                                choices = c("Monte-Carlo", "Historique", "Paramétrique"),
                                selected = NULL
                            ),
                            uiOutput("setting2"),
                            br()
                            # pickerInput(
                            #     inputId = "ml",
                            #     label = h4("Inclure du Machine Learning"), 
                            #     choices = c("Régression non Linéaire", 
                            #                 "Régression Linéaire", 
                            #                 "FFNN",
                            #                 "K-Means"
                            #                 ),
                            #     selected = NULL
                            # )
                        ),
                        mainPanel(
                            width = 9,
                            height = "auto",
                            box(
                                width = 12,
                                fluidRow(
                                    column(
                                        width = 6,
                                        withLoader(
                                            plotlyOutput('trainPlot', height = '500px'),
                                            type = "html",
                                            loader = "dnaspin"
                                        )
                                    ),
                                    column(
                                        width = 6,
                                        withLoader(
                                            plotlyOutput('testPlot',height = '500px'),
                                            type="html",
                                            loader="dnaspin")
                                    )
                                )
                            )
                        ),
                        position = "left",
                        fluid = TRUE
                    ),
                    fluidRow(
                        tabBox(
                            width = 12,
                            id = "tabset1", 
                            height = "250px",
                            tabPanel("R",
                                     uiOutput("r")
                            ),
                            tabPanel("Python", 
                                     uiOutput("python")
                            )
                        ) 
                    )
                )
            ),
            
            tabItem(
                tabName = "cr",
                fluidRow(
                    box(
                        height = "600px",
                        width = 12,
                        uiOutput("pdfview")
                    )
                )
            )
        )
    ),
    rightsidebar = rightSidebar(
        background = "dark",
        .items = {
            tagList(
                h3('Setting'),
                uiOutput("setting") 
            )
        }    
        # rightSidebarTabContent(
        #     id = "custum_setting",
        #     header = NULL,
        #     icon = NULL,
        #     title = "Setting",
        #     active = TRUE,
        #     uiOutput("setting")
        # )
        # rightSidebarTabContent(
        #     id = 2,
        #     title = "Tab 2",
        #     textInput("caption", "Caption", "Data Summary")
        # ),
        # rightSidebarTabContent(
        #     id = 3,
        #     title = "Tab 3",
        #     icon = "paint-brush",
        #     numericInput("obs", "Observations:", 10, min = 1, max = 100)
        # )
    ),
    title = "Simulation de valeurs d'actifs"
)

