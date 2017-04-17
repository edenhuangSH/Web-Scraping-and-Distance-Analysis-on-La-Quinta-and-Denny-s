[![wercker status](https://app.wercker.com/status/fba9cfd28fc2452c199f00227afb73b0/s/master "wercker status")](https://app.wercker.com/project/byKey/fba9cfd28fc2452c199f00227afb73b0)

source: http://www2.stat.duke.edu/~cr173/Sta523_Fa16/hw/hw4.html

## Background
This observation is a joke made famous by the late comedian Mitch Hedberg. Several years ago, John Reiser on his blog detailed an approach to assess how true this joke actually is by scraping location data for all US locations of La Quinta and Denny’s. Our goal for this project is to recreate this analysis within R and expand on both the data collection and analysis.

## Task 1 - Scraping La Quinta
The goal is to scrape this data from the hotel listings page which conveniently includes a list and links to every La Quinta in the USA, Mexico, and Canada. The scraped data set includes location name, address, phone number, fax number, latitude, longitude, hotel amenities and details such as internet availability, swimming pools, number of rooms, floors. This data collection is constructed in a reproducible fashion - all web pages being scraped would be cached locally and each analysis step self contained in a separate R script. We also create a Makefile that links our R scripts together.

## Task 2 - Scraping Denny’s
Scraping the Denny’s site is somewhat more complicated as it relies on a 3rd party service to display its locations. We fetch and parse the XML files that result from the API calls and combining their results in R. We also verify that these calls are sufficient to obtain all Denny’s locations. Again all web page or API result used are cached locally and all analyses self contained R scripts connected by a single Makefile.

## Task 3 - Distance Analysis
Using the results of previous scraping we then analyze the veracity of Hedberg’s claim. We use the Euclidean metrics to measure distance between two spatial locations on a sphere. 


