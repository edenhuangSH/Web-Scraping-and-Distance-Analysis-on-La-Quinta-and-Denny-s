# function to query location service
#   zipcode = current address
#   radius = number of miles from current address to look
#   limit = maximum number of results returned
get_url = function(limit, zip_code, radius) {
  paste0(
    "https://hosted.where2getit.com/dennys/responsive/ajax?&xml_request=%3Crequest%3E%3Cappkey%3E6B962D40-03BA-11E5-BC31-9A51842CA48B%3C%2Fappkey%3E%3Cformdata+id%3D%22locatorsearch%22%3E%3Cdataview%3Estore_default%3C%2Fdataview%3E%3Climit%3E",
    limit,"%3C%2Flimit%3E%3Corder%3Erank%2C_distance%3C%2Forder%3E%3Cgeolocs%3E%3Cgeoloc%3E%3Caddressline%3E",
    zip_code,
    "%3C%2Faddressline%3E%3Clongitude%3E%3C%2Flongitude%3E%3Clatitude%3E%3C%2Flatitude%3E%3Ccountry%3EUS%3C%2Fcountry%3E%3C%2Fgeoloc%3E%3C%2Fgeolocs%3E%3Cstateonly%3E1%3C%2Fstateonly%3E%3Csearchradius%3E",
    radius,
    "%3C%2Fsearchradius%3E%3C%2Fformdata%3E%3C%2Frequest%3E"
  )
}

# Find locations in the US
# East   = get_url(limit=10000, zip_code=63101, radius=6000)  # St. Louis, MO
# West   = get_url(limit=10000, zip_code=80210, radius=6000)  # Denver, CO
# Alaska = get_url(limit=10000, zip_code=99701, radius=6000)  # Fairbanks, AK
# Hawaii = get_url(limit=10000, zip_code=96801, radius=6000)  # Honalulu, HI
# locals  = c(West, East, Alaska, Hawaii)
East   = get_url(limit=10000, zip_code=20001, radius=10000)  # Washington D.C
West   = get_url(limit=10000, zip_code=84101, radius=10000)  # SLC, UT
locals = c(East, West)

# create a data directory
dir.create("data/dennys",recursive = TRUE, showWarnings = FALSE)

# download xml files with locations
for (i in seq_along(locals)) {
    download.file(locals[i], dest=paste0('data/dennys/file',
                                         as.character(i),'.xml'))
}

