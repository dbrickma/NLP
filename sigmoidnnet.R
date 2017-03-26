#Sigmoid Activation Function Hidden Layer Neural Net in R 
#Data--MINST via Andrew Ng's Stanford Machine Learning Course 
#Helpful Sources: 
#1) Andrew Ng's Coursera Lectures
#2) http://junma5.weebly.com/data-blog/build-your-own-neural-network-classifier-in-r
#3) https://www.r-bloggers.com/r-for-deep-learning-i-build-fully-connected-neural-network-from-scratch/
#4) http://www.holehouse.org/mlclass/

#Results: Summary--Decreasing the regularization term significantly sped up convergence for the sigmoid activation function nnet. With the new reg term the sigmoid nnet beat the nnet. 
#Results on Test Set; true class accuracy 

#nmod9 <- nnet4(trn.X, Y, step_size = 0.8, reg = 0.0001, h = 10, niteration=8000)
#table(ten.Y)
#ten.Y
#1   2   3   4   5   6   7   8   9  10 
#100 100 100 100 100 100 100 100 100 100 

#table(preds9)
#1   2   3   4   5   6   7   8   9  10 
#102 100 102  97 106 100 100 101  98  94 
# error9 <- (sum(abs(vp9 - y9)))/nrow(ten.Y)
#error9
#[1] 0.022
#accuracy: 97.8%

library(ade4)
library(sigmoid)
library(caTools)
set.seed(0)
D <- 400 
K <- 10 
N <- 4000
h <- 10
df1 <- as.data.frame(dfnn)
colnames(df1)[401] <- "y"
df1 <- df1[sample(1:nrow(df1)),]
spt <- sample.split(df1$y, SplitRatio = 0.8)
trn <- subset(df1, spt == T)
ten <- subset(df1, spt == F)
trn.X <- as.matrix(trn[,-401], nrow = 4000, ncol = 400)
trn.Y <- as.matrix(trn[, 401], nrow = 1000, ncol = 1)
ten.X <- as.matrix(ten[,-401], nrow = 1000, ncol = 400)
ten.Y <- as.matrix(ten[,401], nrow = 1000, ncol = 1)
y <- trn.Y
vy <- acm.disjonctif(as.data.frame(y))

Y <- as.matrix(vy) 
ten.X <- as.matrix(ten[,-401], nrow = 1000, ncol = 400)
ten.Y <- as.matrix(ten[,401], nrow = 1000, ncol = 1)
nnet4 <- function(X, Y, step_size = 0.5, reg = 0.001, h = 10, niteration){
  # get dim of input
  N <- nrow(X) # number of examples
  K <- ncol(Y) # number of classes
  D <- ncol(X) # dimensionality
  
  # initialize parameters randomly
  W <- 0.01 * matrix(rnorm(D*h), nrow = D)
  b <- matrix(0, nrow = 1, ncol = h)
  W2 <- 0.01 * matrix(rnorm(h*K), nrow = h)
  b2 <- matrix(0, nrow = 1, ncol = K)
  
  # gradient descent loop to update weight and bias
  for (i in 0:niteration){
    # hidden layer, Sigmoid activation
    hidden.layer <- sweep(X %*% W ,2, b, '+')
    hidden_layer <- sigmoid(hidden.layer)
    # class score
    scores <- sweep(hidden.layer %*% W2, 2, b2, '+')
    
    # compute and normalize class probabilities
    exp_scores <- exp(scores)
    probs <- exp_scores / rowSums(exp_scores)
    
    # compute the loss: sofmax and regularization
    corect_logprobs <- -log(probs)
    data_loss <- sum(corect_logprobs*Y)/N
    reg_loss <- 0.5*reg*sum(W*W) + 0.5*reg*sum(W2*W2)
    loss <- data_loss + reg_loss
    # check progress
    if (i%%1:niteration == 0 | i == niteration){
      print(paste("iteration", i,': loss', loss))}
    
    # compute the gradient on scores
    dscores <- probs-Y
    dscores <- dscores/N
    
    # backpropate the gradient to the parameters
    dW2 <- t(hidden_layer)%*%dscores
    db2 <- colSums(dscores)
    # next backprop into hidden layer
    dhidden <- dscores%*%t(W2)
    # backprop the ReLU non-linearity
    dhidden[hidden_layer <= 0] <- 0
    # finally into W,b
    dW <- t(X)%*%dhidden
    db <- colSums(dhidden)
    
    # add regularization gradient contribution
    dW2 <- dW2 + reg *W2
    dW <- dW + reg *W
    
    # update parameter 
    W <- W-step_size*dW
    b <- b-step_size*db
    W2 <- W2-step_size*dW2
    b2 <- b2-step_size*db2
  }
  return(list(W, b, W2, b2))
}
#Prediction function and model training
#Next, create a prediction function, which takes X (same col as training X but may have different rows) and layer parameters as input. The output is the column index of max score in each row. In this example, the output is simply the label of each class. Now we can print out the training accuracy.
nnetPred <- function(X, para = list()){
  W <- para[[1]]
  b <- para[[2]]
  W2 <- para[[3]]
  b2 <- para[[4]]
  
  N <- nrow(X)
  hidden.layer <- sweep(X %*% W ,2, b, '+')
  hidden_layer <- sigmoid(hidden.layer)
  # class score
  scores <- sweep(hidden.layer %*% W2, 2, b2, '+')
  predicted_class <- apply(scores, 1, which.max)
  
  return(predicted_class)  
}
