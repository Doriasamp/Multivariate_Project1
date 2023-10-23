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

################################

# part f
#Compute the sample covariance matrix and sample correlation matrix of the variables. Now, standardize the data. 
#Calculate the covariance matrix of the standardized variables. Did you find anything
#insightful? Round all the results up to two decimal places.

#converting data into dataframe and into matrix
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

#Interpretation: the correlation matrix indicates several variables (pctwhite, poverty, single) as being associated to murder

###############################

#part g
#Compute the generalized sample variance and inverse of the sample covariance matrix of the data.
#Round all the results up to three decimal places.

#calculate GSV --> >0, so S is invertible
GSV = det(S)
GSV

#inverse of sample covariance matrix
S.inv = round(solve(S), 3)
S.inv

#########################
#part h
#Perform the spectral decomposition of the of the covariance matrix of the data and obtain P and
#D matrices. Verify that P P′ = P′P = I. Compute P D P′. What relation you observed between the
#product product matrix and the original sample covariance matrix? Compute the determinant and inverse
#of the covariance matrix using spectral decomposition method. Check that the determinant you got here is
#identical to generalized sample variance you have in Question (g). Can you comment on the definiteness
#(positive, negative, semi) using any component of the decomposition? Report all the results rounding up
#to 2 decimal places.

#spectral decomposition
Eig.S = eigen(S)
EigVals.S = round(Eig.S$values, 2)
EigVals.S #getting the eigenvalues

#obtaining the eigenvector matrix (P)
P=round(Eig.S$vectors, 2)
P #creating matrix of normalized eigenvectors

#showing that P'P = PP' = I
round(P %*% t(P), 2) # equals the identity matrix -- correct!

#obtaining the lambda matrix (D)
D=diag(EigVals.S)
D

#compute the spectral decomposition matrix, PDP'
Cov.Spec.Decomp = round(P %*% D %*% t(P), 2)
Cov.Spec.Decomp
S #for comparison to the original sample covariance matrix

#relation b/w the "product matrix and the original sample covariance matrix":
  #The values of the original covariance matrix and the spectral decomposition matrix are very close!

#calculating determinant and inverse of covariance matrix using spectral decomposition
det.S.decomp = prod(EigVals.S) #calculating determinant based on eigenvalues
det.S.decomp #This value is almost the exact same as what we found in part g!

D.inv = round(diag(1/EigVals.S), 2) #calculating lambda inverse matrix (D inverse)
D.inv

S.inv.decomp = P %*% D.inv %*% t(P) #calculating inverse covariance matrix
S.inv.decomp

#Comment on the definiteness of the matrix:
  #A matrix is a PD matrix if all of its eigenvalues > 0. As seen in the beginning of part h, in calculating the eigenvalues,
  #we found eigenvalues of 536.70, 210.98, 43.62, 33.20, 4.09, and 0.97. All of these eigenvalues are greater than 1, so
  # we can assuredly say that the covariance matrix (S) is a positive definite (PD) matrix.

##########################

#part i
#Compute the inverse square root of the covariance matrix. Then, post multiply the `data matrix' by
#the inverse square root of the covariance matrix. Now, compute the covariance matrix of the scaled data.
#What do you expect to see from this? Round your results up to 2 decimal places.

#get the inverse square root of the covariance matrix (D^-1/2)
D.inv.sqrt = round(diag(sqrt(1/EigVals.S)),2)
D.inv.sqrt

#multiply the "data matrix" and inverse square root of the covariance matrix
scaled_matrix = round(crime_matrix %*% D.inv.sqrt, 2)

#compute covariance matrix of the scaled data (is "scaled data" what is in line 135?)
S.scaled = round(cov(scaled_matrix), 2)
S.scaled

#we would expect to see all values lower than or equal to 1? (correlation matrix?)

#############################

#part j
#Simulate a random sample of size equal to the number of variables you have in the data from normal
#distribution with corresponding sample means and variances. Use a seed 123 while simulating the sample.
#Consider this random sample a vector x. Report the sample. Using the fundamental definition, show that
#the sample covariance is a positive definite matrix, numerically.

#simulate and print the random sample
set.seed(123)
x_vec = rnorm(dim(crime_df)[2], mean=0, sd=1)
x_vec

#show S is a PD matrix (x' %*% S %*% x)
t(x_vec) %*% S %*% x_vec #616.6908 --> >0 implies that S is a PD matrix

############################################

#part k
#Perform the singular value decomposition on the data matrix. Which are the singular values and
#non-singular values from this decomposition. Obtain U, V, and Λ matrices. Only print Λ matrix. Report
#the dimensions of these matrices. Show that X = U D V′. Use p − 2 singular values to reconstruct the
#approximated data matrix. Understand that approximation would not be good if you removed important
#features (non-zero λ values - singular values) of the data. Here, p is the number of variables.
crime_mat=matrix(crime_matrix, nrow = 51, byrow=T)
crime_mat

#get eigenvalues and put into λ matrix
eigen_x = eigen(crime_mat)
eig_vals = eigen(crime_mat)$values
lambda_mat = diag(Eig.Vals)

#joey