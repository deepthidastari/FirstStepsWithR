#Install the ROBDC package if you are running this script for the first time or if you haven't already installed this package

install.packages("RODBC")
library(RODBC)

#Creating empty list and dataframe for storing results of T-test

resultvector <- list()
resultdataframe <- data.frame()

#Choosing the sample size
samplesize = 100

#Establishing connection to the database we want to connect to

channel <- odbcDriverConnect('driver={SQL Server};server=<server_name>;database=<database_name>;trusted_connection=true');

#Building the query for selecting values from the table_name

selectquery <- paste0("select Average_value1,Average_value2 from <table_name>")

#Running the built query and storing results returned by the query

result<- sqlQuery(channel,selectquery)

#preparing data for t-tests; leaving out any rows with NAs

nona_result <- na.omit(result)

#Creating the two populations on which we want to run the t-test

population_1_values<- c(nona_result$Average_value1)

population_2_values<- c(nona_result$Average_value2)

#Taking samples from the two populations to run the t-tests

sample_of_population_1_values = sample(population_1_values, samplesize, replace = TRUE)

sample_of_population_2_values = sample(population_2_values, samplesize, replace = TRUE)

#Running paired t-test on the two populations

ttestresult <- t.test(sample_of_population_2_values, sample_of_population_1_values, paired=TRUE, conf.level = 0.95)

#Storing results of the paired t-test

resultvector <- c(ttestresult$p.value,ttestresult$statistic,ttestresult$conf.int[1],ttestresult$conf.int[2])

print(resultvector)

#Closing the database connection
close(channel)
odbcClose(channel)
