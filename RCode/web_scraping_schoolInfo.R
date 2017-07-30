### for School list search https://www.myschool.edu.au/SchoolSearch/GlobalSearch?term=200&count=50


library(httr)
library(rvest)
library(dplyr)

### request school a school page

res <- POST("https://www.myschool.edu.au/Home/GenericSearch",
            encode="form",
            user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36"),
            add_headers('Referer'="https://www.myschool.edu.au/Home/GenericSearch",'origin'="https://www.myschool.edu.au"),
            body=list(
             'SchoolNameGlobal'="Darlington Public School,Chippendale,NSW,2008",
              'SMCLID'="104379",
              'SMCLDisplayID'="",
              'Go.x'="21",
             'Go.y'="17",
              'Go'="Go"))


res_t <- content(res, as="text")
res_h <- paste0(unlist(strsplit(res_t, "\r\n"))[-1], sep="", collapse="\n")

css <- "#ctl00_ContentPlaceHolder1_defaultUC1_CurrencyMatrixAllCountries1_GridView1"

tab <- html(res_h) %>% 
  html_nodes(css) %>%
  html_table() 

tab[[1]]$COUNTRIESWORLDAMERICAEUROPEASIAAUSTRALIAAFRICA

glimpse(tab[[1]]