# Predictive-model-for-AHG
The project is to predict churn by customers in a bicycle company
Solution Approach 
Define churn – Churn is defined as any customer who didn’t make any purchase within the last 8 months of Business transaction i.e. any customer whose maximum/last transaction date is less than 28/05/2013. 
Exploratory analysis to understand the profile of churners using their demographic, transactional and attitudinal data. 
As part of feature engineering, I used RFM analysis to create recency, frequency and monetary(lifetime value) attributes for each customer. Using the derived RFM variables or RFM Scores, I created a clustering model (unsupervised technique) using K means  to generate customer segments (clusters – use elbow method to select the best number of clusters). The cluster variable was used as part of my modelling and scoring variables.
Churn variable is my target variable for your modelling exercise
Used a single customer view i.e the final dataset had a single customer data per row no duplicates 
Followed the modelling phases including, statistical testing to test for multi collinearity and over fitting, investigate the distributions, Identify outliers, extreme values or spurious values, impute missing values where applicable, Carry out feature selection, partition the data into training, testing or validation or use cross validation technique, develop various models and select champion model
Deployed or scored model on an unseen dataset/hold out sample, this dataset must not be included in the model development phase.
Re validated my model before rolling out the main marketing campaign.


