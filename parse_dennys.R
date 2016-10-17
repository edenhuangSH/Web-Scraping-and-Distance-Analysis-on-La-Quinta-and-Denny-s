library(rvest)
library(stringr)
library(tibble)
library(dplyr)
library(methods)

files = dir("data/dennys", "xml", full.names = TRUE)
res = list()

# parse the dennys xml files and extract information
for(i in seq_along(files)) {

    file = files[i]
    page = read_html(file)
    # extract latitude information
    lat = page %>%
        html_nodes("latitude") %>%
        html_text()
    # extract longitude information
    long = page %>%
        html_nodes('longitude') %>%
        html_text()
    # extract state information
    state = page %>%
        html_nodes('state') %>%
        html_text()
    # store information in a list format
    res[[i]] = data_frame(
        state = state,
        lat   = as.numeric(lat),
        long  = as.numeric(long)
    )
}

dennys = bind_rows(res)
dennys = dennys %>% distinct()

dir.create("data/", showWarnings = FALSE)
save(dennys, file="data/dennys.Rdata")

