library(rvest)

# url for la quinta site
site = "http://www2.stat.duke.edu/~cr173/lq_test/www.lq.com/en/findandbook/"
url = paste0(site,"hotel-listings.html")

# extract individual hotel page urls
page = read_html(url)
hotel_pages = page %>%
  html_nodes("#hotelListing .col-sm-12 a") %>%
  html_attr("href") %>%
  na.omit()

# create directory
dir.create("data/lq",recursive = TRUE,showWarnings = FALSE)

# download the hotel page for each lq location
for(hotel_page in hotel_pages) {
  hotel_url = paste0(site, hotel_page)
  download.file(url = hotel_url,
                destfile = file.path("data/lq",hotel_page),
                quiet = TRUE)
}
