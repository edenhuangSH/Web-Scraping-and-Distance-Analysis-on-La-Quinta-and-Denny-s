library(rvest)
library(stringr)
library(tibble)
library(dplyr)
library(methods)

files = dir("data/lq", "html", full.names = TRUE)
res = list()

# parse the lq html files and extract information
for(i in seq_along(files)) {

    file = files[i]
    page = read_html(file)
    # extract address info
    hotel_info = page %>%
        html_nodes(".hotelDetailsBasicInfoTitle p") %>%
        html_text() %>%
        str_split("\n") %>%
        .[[1]] %>%
        str_trim() %>%
        .[. != ""]
    # extract number of rooms
    n_rooms = page %>%
        html_nodes(".hotelFeatureList li:nth-child(2)") %>%
        html_text() %>%
        str_trim() %>%
        str_replace("Rooms: ", "") %>%
        as.integer()
    # Google link includes latitude first then longitude
    lat_long = page %>%
        html_nodes(".minimap") %>%
        html_attr("src") %>%
        str_match("\\|(-?[0-9]{1,2}\\.[0-9]+),(-?[0-9]{1,3}\\.[0-9]+)&")
    
    
    
    
    
    
    # store infomation in list structure
    res[[i]] = data_frame(
        address = paste(hotel_info[1:2],collapse="\n"),
        phone = hotel_info[3] %>% str_replace("Phone: ", ""),
        fax   = hotel_info[4] %>% str_replace("Fax: ", ""),
        n_rooms = as.numeric(n_rooms),
        lat   = as.numeric(lat_long[,2]),
        long  = as.numeric(lat_long[,3])
  )
}

hotels = bind_rows(res)

dir.create("data/",showWarnings = FALSE)
save(hotels, file="data/lq.Rdata")
