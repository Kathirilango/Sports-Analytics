# Clustering Modern NFL Receivers - [Read Article](https://www.bruinsportsanalytics.com/modernreceivers)
Over the last decade the traditional concept of X, Y, and Z receivers within an offense has become very diluted as spread offenses, extremely versatile tight ends, and 'jack of all trades' receivers have become fashionable. But there are still certain discernable tiers to modern receivers.

### Project Description
This project looks at advanced receiving stats from 2016 to 2019 from [NFL.com](https://nextgenstats.nfl.com/stats/receiving) and performs a [principal component analysis](https://www.sciencedirect.com/topics/medicine-and-dentistry/principal-component-analysis) on the data to narrow it down to a few numerical components that explain a certain amount of the variance in the data (ideally above 70%). Using this new component data, K-Means Clustering models are created with the number of clusters ranging from 1 to 20 and the [within cluster sum of squares](https://support.minitab.com/en-us/minitab/18/help-and-how-to/modeling-statistics/multivariate/how-to/cluster-k-means/interpret-the-results/all-statistics-and-graphs/#within-cluster-sum-of-squares) score is recorded for each run. Using the elbow method, the optimal number of clusters is determined and the final K-Means Clustering model is created. Based on this final clustering, patterns can be seen in the clusters and the tiers of current receivers can be better understood. See detailed results in results.txt. 

### Usage
Running the program will produce three plots:
- Number of Components vs. Cumulative Sum of Explained Variance
- Number of Clusters vs. WCSS Score
- Final Clustering of Receivers/Tight Ends based on Components

### Sources
All statistics courtesy of nextgenstats.nfl.com.