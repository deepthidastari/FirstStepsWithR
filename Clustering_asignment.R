#Importing the dataset
dataset = read.csv('Data.csv')

#Numeric variables only
data <- dataset[,c(2:11)]  

#Choosing the optimal value for K(the number of clusters) using the Elbow method
set.seed(123)

#Compute and plot wss for k = 2 to k = 15
k.max <- 10 # Maximal number of clusters
wss <- sapply(1:k.max,
              function(k){kmeans(data, k)$tot.withinss})
              
#Plotting the Elbow curve to visualize the optimal value for K              
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE,
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")

#Applying K-Means clustering algorithm 
km <- kmeans(data, center=5)
cluster <- km$cluster
varcluster <- cbind(dataset,cluster)
