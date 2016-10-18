#look at the directory, find all the html file there, read them
# dir("data/lq", "html") #patern to look for, html
library(rvest)
library(stringr)
library(tibble)
library(dplyr)
library(methods)

files = dir("data/lq", "html", full.names = TRUE)# create a file
res = list()#save result as a list

# parse the lq html files and extract information
for(i in seq_along(files)) {
  
  file = files[i]
  page = read_html(file)
  # extract address info
  hotel_info = page %>%
    html_nodes(".hotelDetailsBasicInfoTitle p") %>%
    html_text() %>% #to do some text processing, \n is new line
    str_split("\n") %>%#what is vector you wanna split, and what is the value...
    .[[1]] %>% #get rid of list
    str_trim() %>%
    .[. != ""]#some of them is empty line, get rid of them, not equal to space
  # extract number of rooms
  
  location_name = page %>%
    html_nodes("h1") %>%
    html_text() 
  
  n_rooms = page %>%
    html_nodes(".hotelFeatureList li:nth-child(2)") %>%
    html_text() %>%
    str_trim() %>%
    str_replace("Rooms: ", "") %>%
    as.integer()
  
  n_floors =  page %>%
    html_nodes(".hotelFeatureList li:nth-child(1)") %>%
    html_text() %>%
    str_trim() %>%
    str_replace("Floors:", "") %>%
    as.integer()
  
  Amenity_and_service = page %>%
    html_nodes(".section:nth-child(2) .pptab_contentL li , .section:nth-child(1) .pptab_contentL li") %>%
    html_text() %>%
    str_trim() %>%
    as.vector()
  Swimming_Pool = str_detect(Amenity_and_service,"Swimming Pool") %>%
    any()
  Internet_Access = str_detect(Amenity_and_service,"Internet Access") %>%
    any()
  
  #.section:nth-child(1) li:nth-child(4)
  
  # Google link includes latitude first then longitude
  lat_long = page %>%
    html_nodes(".minimap") %>%
    html_attr("src") %>%
    str_match("\\|(-?[0-9]{1,2}\\.[0-9]+),(-?[0-9]{1,3}\\.[0-9]+)&")
  # store infomation in list structure
  res[[i]] = data_frame(
    location_name = location_name,
    address = paste(hotel_info[1:2],collapse="\n"),
    phone = hotel_info[3] %>% str_replace("Phone: ", ""),
    fax   = hotel_info[4] %>% str_replace("Fax: ", ""),
    n_rooms = n_rooms,
    lat   = as.numeric(lat_long[,2]),
    long  = as.numeric(lat_long[,3]),
    n_floors = n_floors,
    Swimming_Pool = Swimming_Pool,
    Internet_Access = Internet_Access
    #Amenity_and_service = c(Amenity_and_service)
    #internet availability, 
    #internet availability, swimming pools, number of rooms, floors
  )
}

#give a list, dataframes, willbind them all together
hotels = bind_rows(res)

dir.create("data/",showWarnings = FALSE)
save(hotels, file="data/lq.Rdata")

