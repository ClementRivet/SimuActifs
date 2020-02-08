library(plotly)
library(shinyWidgets)
library(shinydashboard)
library(shinydashboardPlus)
library(DT)
library(magrittr)
library(shinycustomloader)
library(rtsdata)


list_actifs <- c(CAC40 = "^FCHI", 
                 EURUSD = "EURUSD=X",
                 EURGBP = "EURGBP=X",
                 EURCHF = "EURCHF=X",
                 EURCAD = "EURCAD=X"
                )
source('R/functions.R', encoding = 'UTF-8')