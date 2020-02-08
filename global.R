library(plotly)
library(shinyWidgets)
library(shinydashboard)
library(shinydashboardPlus)
library(DT)
library(magrittr)
library(shinycustomloader)
library(rtsdata)
# library(rvest)
# 
# 
# yahoo_table <- read_html('https://fr.finance.yahoo.com/indices-mondiaux') %>%
#   html_node("table") %>%
#   html_table()



list_forex <- c("EUR/USD" = "EURUSD=X",
                "EUR/GBP" = "EURGBP=X",
                "EUR/CHF" = "EURCHF=X",
                "EUR/CAD" = "EURCAD=X",
                "EUR/CNY" = "EURCNY=X",
                "EUR/JPY" = "EURJPY=X",
                "EUR/SEK" = "EURSEK=X",
                "EUR/HUF" = "EURHUF=X",
                "GBP/USD" = "GBPUSD=X",
                "GBP/CNY" = "GBPCNY=X",
                "GBP/JPY" = "GBPJPY=X",
                "USD/CHF" = "CHF=X",
                "USD/CAD" = "CAD=X",
                "USD/CNY" = "CNY=X",
                "USD/HKD" = "USDHKD=X",
                "USD/SGD" = "USDSGD=X",
                "USD/INR" = "USDINR=X",
                "USD/MXN" = "USDMXN=X",
                "USD/PHP" = "USDPHP=X",
                "USD/IDR" = "USDIDR=X",
                "USD/THB" = "USDTHB=X", 
                "USD/MYR" = "USDMYR=X",
                "USD/ZAR" = "USDZAR=X",
                "USD/RUB" = "USDRUB=X",
                "USD/JPY" = "JPY=X",
                "AUD/USD" = "AUDUSD=X",
                "AUD/JPY" = "AUDJPY=X",
                "NZD/USD" = "NZDUSD=X")

list_indices <- c(CAC40 = "^FCHI")

list_commodity <- c("Gold future" = "GC=F", 
                    "Silver Mar 20" = "SI=F", 
                    "Copper Mar 20" = "HG=F", 
                    "Pétrole WTI" = "CL=F", 
                    "Brent Crude Oil Last Day Financ" = "BZ=F",
                    "Natural Gas Mar 20" = "NG=F", 
                    "Corn Mar 20" = "C=F",
                    "Oats Mar 20" = "O=F",
                    "KC HRW Wheat Futures,Mar-2020,C" = "KW=F",
                    "Rough Rice May 20" = "RR=F",              
                    "Soybeans Mar 20" = "S=F",
                    "Feeder Cattle Mar 20" = "FC=F",
                    "Lean Hogs Feb 20" = "LH=F",
                    "Live Cattle Apr 20" = "LC=F",
                    "Cocoa May 20" = "CC=F",                   
                    "Coffee Mar 20" = "KC=F",
                    "Cotton Mar 20" = "CT=F",
                    "Lumber Mar 20" = "LB=F",
                    "Orange Juice Mar 20" = "OJ=F",
                    "Sugar #11 May 20" = "SB=F")

source('R/functions.R', encoding = 'UTF-8')

        


                    
