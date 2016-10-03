# (1) A natural language processing python adventure. Replete with NLTK, Scikit-Learn, and gensim.  
# (2) Data cleaning, modeling, and visualization--total average inpatient charges. The dataset was downloaded in csv form from Kaggle. 
  
  Executive Summary (2) 
  
  The main tools used were pandas, matplotlib and scikit-learn. Cleaning the initial dataset took a few steps. 
  
  Step 1: Eliminate spaces in column strings
  Step 2: Eliminate dollar signs in row values
  Step 3: Convert object row values to floats
  Step 4: Encode targets for nominal values 
  
  I then saved the df as a csv and provided code to turn the document into an excel spreadsheet. 
  
  Next I eliminated exogenous variables and create X and y references for the ML models. To determine especially exogenous variables I   used a priorities analysis via a RandomforestRegressor model. Industry insight is also useful here to ballpark which variables are autocorrelated. 
  
  I then utilized RF and ADA models for the data. After tweaking the parameters a bit (estimators/max_features), I produced R^2 values of 92.5 (RFR) and 97.4(ADA). For non-linear data in a supervised learning context, RF models are very effective. 
  
  Further, I visualized the data in a few ways. 
  
  First, I plotted the y and y-hat values. This visualized the relative effectiveness of each model in relation to the test set. 
  
  Next, I plotted bar graphs for the overlapping test and predicted values for each model. For this I rounded to the nearest hundreth due to memory concerns. To generate these numbers, I simply for-looped over both lists of values for x=y. Here, x was the test set data, and y was the predicted value.  
  
  I also plotted par graphs for each model's R^2 value. 
  
  Finally, I plotted the log-ratio of predicted value divided by test value per value. I also plotted a line of log=1.00. This way, one can see how close each model came to an exact fit per value. This also showcases how much each model over or under-estimated values. For this step, I used lambda map functions to divide and log the relevant list information. 
  
  Overall, cleaning, modeling, and visualizing this kind of data was a fun challenge. It was also exciting to see the power of randomforests. 
  
  -DSB 
  
  
  

