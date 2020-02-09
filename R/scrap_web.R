library(rvest)

yahoo <- new.env()

url <- "https://fr.finance.yahoo.com/"
pages <- c('indices-mondiaux', 'devisas', "matierespremieres") #'crypto-monnaies', 


lapply(pages, function(i){
  current_page <- read_html(paste0(url, i))
  
  this_page <- current_page  %>%
    html_node("table") %>%
    html_table()
  
  
  yahoo[[toString(i)]] <- this_page
  
  .GlobalEnv[[toString(i)]] <- c(yahoo[[toString(i)]]$Symbole)
  names(.GlobalEnv[[toString(i)]]) <- yahoo[[toString(i)]]$Nom
})




