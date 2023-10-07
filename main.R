# First thing you have to installing the following dependencies within library()
# and you only have to do this once
library(haven)
library(readr)
library(GGally)

# Part a
url = "https://stats.idre.ucla.edu/wp-content/uploads/2016/02/crime.sas7bdat"
crime_import = read_sas(url, NULL)
str(crime_import)
# part b
write.csv(crime_import, file = "crime_csv.csv", row.names = F)
write.table(crime_import, file = "crime_txt.txt", sep = "\t", row.names = F)
dir()
# part c
crime_numeric = read_csv("crime_csv.csv",
                         col_types = cols(sid = col_skip(),
                                          state = col_skip(),
                                          crime = col_skip()))

str(crime_numeric)
# part d
boxplot(crime_numeric, las = 2, col = rainbow(ncol(crime_numeric)))

# part e
ggpairs(crime_numeric)


