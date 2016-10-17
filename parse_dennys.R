library(rvest)
library(stringr)
library(tibble)
suppressMessages(library(dplyr))

files = dir("data/dennys/", "xml", full.names = TRUE)
res = list()

# parse the dennys xml files and extract information
for (i in seq_along(files)) {

    file = files[i]
    page = read_xml(file)
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
        lat   = lat,
        long  = long
    )
}

dennys = bind_rows(res)
dennys = dennys %>% distinct()

dir.create("data/",showWarnings = FALSE)
save(dennys,file="data/dennys.Rdata")
