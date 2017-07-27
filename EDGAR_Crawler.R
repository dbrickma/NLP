library(Rcrawler)
library(httr)
library(htmltidy)
#recreate the search html links for each potential fortune 500 company by CIK number
CIKSP$LNKS <- gsub(" ","",paste("https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=",CIKSP$CIK,"&type=&dateb=&owner=exclude&count=100", by = ''))

#Using first in list of Fortune 500 Companies as example 

url <- CIKSP$LNKS[1]

#grab html

furl <- url %>% read_html() %>%
  
  html_nodes('#documentsbutton') %>%
  
  html_attr('href')

#create full links for each of the document buttons

furl <- paste('http://www.sec.gov',furl,sep = '')
lnksf <- function(x){
  ffurl <- x %>% read_html() %>% 
    html_nodes('a')%>% 
    html_attr('href')
  return(furl)
  
}

#grab the nested links for each of the document buttons per company 

ffF1a <- sapply(furl,LinkScraper,"href",encod = 'UTF-8')
ffF1a <- unlist(ffF1a) 

#grab links with data only 

fffurl1 <- grep("/data/", ffF1a,value = TRUE)
#fffurl1 <- unlist(fffurl1)

#add the first part of the link address to the scraped links 
fffurl <- paste('http://www.sec.gov',fffurl1,sep = '')

#create functions to grab the content from the nested links per documents button 

#Get response object with httr package 
getfun <- function(x){
  get1 <- GET(x)
  return(get1)
}

#Clean the HTML with htmltidy package 

htmlcln <- function(y){
 res <- GET(y)
  cleaned <- tidy_html(content(res, as="text", encoding="UTF-8"),
                       list(TidyDocType="html5"))
  return(cleaned)
  
}

#clean extracted text
fun5 <- function(n){
  
  html1 <- n %>% html() %>% html_nodes('table') %>% html_text()
  html1 %>%
    str_replace_all(pattern = "\n", replacement = " ") %>%
    str_replace_all(pattern = "\t", replacement = " ") %>%  
    str_replace_all(pattern = "\\t", replacement = " ") %>%  
    str_replace_all(pattern = "[\\^]", replacement = " ") %>%
    str_replace_all(pattern = "\"", replacement = " ") %>%
    str_replace_all(pattern = "\\s+", replacement = " ") %>%
    str_replace_all(pattern = '\t\t', replacement = "") %>% 
    str_replace_all(pattern = '\n\t', replacement = "") %>% 
    
    
    iconv("latin1","ASCII","UTF-8") %>%  
    
    str_trim(side = "both")
  
  
  return(html1)
}

#clean again 

clnr1 <- function(x){
  f1 <- grep("[^[:alnum:] ]",x,value= TRUE) 
  f2 <-   gsub("\n",'',f1)  
  f3 <-   gsub("\r",'',f2) 
  return(f3)
}

#Putting all the functions together--the output is scraped text from filing documents per company of interest. 10 used for sample. 

tr1 <- sapply(fffurl[1:10],getfun)
tr2 <- sapply(tr1,htmlcln)
tr3 <- sapply(tr2,fun5)
tr4 <- sapply(tr3, clnr1)

