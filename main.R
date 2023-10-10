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
crime_numeric
str(crime_numeric) #51x6 matrix

# part d
boxplot(crime_numeric, las = 2, col = rainbow(ncol(crime_numeric)))

# part e
ggpairs(crime_numeric)

# part f
#Compute the sample covariance matrix and sample correlation matrix of the variables. Now, standardize the data. 
#Calculate the covariance matrix of the standardized variables. Did you find anything
#insightful? Round all the results up to two decimal places.
crime_df = data.frame(crime_numeric)
crime_matrix = data.matrix(crime_df)
crime_matrix #matrix to use for creating covariance and correlation matrices
#sample covariance matrix
S = round(cov(crime_matrix), 2)
S
#sample correlation matrix
R = round(cor(crime_matrix), 2)
R
#standardized data matrix
std.crime_mat = scale(crime_matrix)
#standardized sample covariance matrix
S.std = round(cov(std.crime_mat), 2)
S.std #matches R, which is correct!
#Interpretation:
