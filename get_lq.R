library(rvest)
library(dplyr)

# url for la quinta site
site = "http://www2.stat.duke.edu/~cr173/lq_test/www.lq.com/en/findandbook/"
url = paste0(site,"hotel-listings.html")

# extract individual hotel page urls
#go laquinta website, download all the information
#first get all of the hotels regardless of the location
#download all of the individual websites
page = read_html(url)
hotel_pages = page %>%
  html_nodes("#hotelListing .col-sm-12 a") %>%
  html_attr("href") %>%
  na.omit()#strip out the NA

# create directory
dir.create("data/lq",recursive = TRUE,showWarnings = FALSE)# create a directory
#showWarnings = don't show the warning
#give the path I want; data/lq

# download the hotel page for each lq location
for(hotel_page in hotel_pages) {
  hotel_url = paste0(site, hotel_page)
  download.file(url = hotel_url,
                destfile = file.path("data/lq", hotel_page),#destination file
                #need to put the destfile in the directory, use filepath function, add one /
                quiet = TRUE)
}

