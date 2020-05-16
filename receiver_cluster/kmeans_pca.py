import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from mpl_toolkits.mplot3d import Axes3D
from sklearn.cluster import KMeans

EXPLAINED_VARIANCE = 0.7
NUM_CLUSTERS       = 3 # Elbow method on WCSS graph

def plot_2d(data, title, xlab, ylab):
  plt.figure(figsize = (10, 8))
  plt.plot(range(1,len(data)+1), data, marker = 'o', linestyle = '--')
  plt.title(title, fontsize=24)
  plt.xlabel(xlab, fontsize=20)
  plt.ylabel(ylab, fontsize=20)
  plt.show()

def run_pca(df):
  scaler = StandardScaler()
  numerical_data = scaler.fit_transform(df.drop('Year', axis=1).drop('NAME', axis=1).drop('TEAM', axis=1).drop('POS', axis=1))

  # Perform Principal Component Analysis on dataframe and narrow number of components down to
  # fewest components that explain at least 70% of the variance in the data
  pca = PCA()
  pca.fit(numerical_data)
  evr = pca.explained_variance_ratio_
  valid_num_components = [i+1 for i in range(len(evr.cumsum())) if evr.cumsum()[i] >= EXPLAINED_VARIANCE]
  num_components = valid_num_components[0]
  pca = PCA(n_components=num_components)
  pca.fit(numerical_data)
  component_data = pca.transform(numerical_data)

  # Graph cumulative sum of explained variance by components in decreasing order
  plot_2d(evr.cumsum(), 'Explained Variance by Components', 'Number of Components', 'Cumulative Explained Variance')

  return component_data

def test_kmeans_wcss(data):
  wcss = []
  for i in range(1, 21):
    kmeans_pca = KMeans(n_clusters=i, init = "k-means++", random_state=42)
    kmeans_pca.fit(component_data)
    wcss.append(kmeans_pca.inertia_)

  # Graph WCSS scores vs number of clusters
  plot_2d(wcss, 'K-Means with PCA clustering', '# Clusters', 'WCSS', )

def run_kmeans(num_clusters, data):
  # Choose NUM_CLUSTERS based on elbow method on WCSS graph
  kmeans_pca = KMeans(n_clusters=NUM_CLUSTERS, init='k-means++', random_state=42)
  kmeans_pca.fit(component_data)

  # Add component and cluster data to dataframe and store in new csv
  final_data = pd.concat([df.reset_index(drop=True), pd.DataFrame(component_data)], axis=1)
  final_data.columns.values[-3:] = ['Component1', 'Component2', 'Component3']
  final_data['Segment K-means PCA'] = kmeans_pca.labels_
  final_data['Segment'] = final_data['Segment K-means PCA'].map({0: 'first', 1: 'second', 2: 'third'})

  # Graph final clustering
  colormap = np.array(['r', 'g', 'b'])
  segments = ['first', 'second', 'third']
  fig = plt.figure()
  ax = fig.gca(projection='3d')
  plt_arr = []
  for i in range(3):
    new_df = final_data[final_data.values == segments[i]]
    plt_arr.append(ax.scatter(new_df['Component1'], new_df['Component2'], new_df['Component3'], c = colormap[i]))
  ax.view_init(azim=20)
  fig.set_facecolor('white')
  ax.set_facecolor('white') 
  plt.title('NFL Receiver/Tight End Clustering: 2016-2019')
  ax.set_xlabel('Component 1')
  ax.set_ylabel('Component 2')
  ax.set_zlabel('Component 3')
  plt.legend(plt_arr, ['Cluster 1', 'Cluster 2', 'Cluster 3'], prop={'size': 10})
  for axis in [ax.xaxis, ax.yaxis, ax.zaxis]:
    axis.label.set_color('black')
  for axis in [ax.w_xaxis, ax.w_yaxis, ax.w_zaxis]:
    axis.line.set_color('black')
  plt.show()

  return final_data

if __name__ == "__main__":
  df = pd.read_csv("adv_receiver_data.csv")
  print("Running principal component analysis...")
  component_data = run_pca(df)
  print("Collecting data to determine optimal number of clusters...")
  test_kmeans_wcss(component_data)
  print("Running K-Means Clustering Algo...")
  final_data = run_kmeans(3, component_data)
  final_data.sort_values(by=['Segment K-means PCA']).to_csv("clustered_data.csv", index=False, encoding='utf-8')