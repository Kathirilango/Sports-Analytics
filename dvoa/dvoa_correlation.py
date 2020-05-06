import seaborn as sns
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data = pd.read_csv("dvoa_data.csv")
data = data[['dvoa', 'o_dvoa', 'd_dvoa', 's_dvoa', 'wins']]
corr = data.corr()
mask = np.triu(np.ones_like(corr, dtype=np.bool))
ax = sns.heatmap(corr, annot = True, fmt='.1g', vmin=-1, vmax=1, center= 0, cmap= 'coolwarm', 
                 linewidths=1, linecolor='white', square=True, annot_kws={"size": 10},
                 xticklabels=['Total', 'OFF', 'DEF', 'ST', '# Wins'],
                 yticklabels=['Total', 'OFF', 'DEF', 'ST', '# Wins'])
bottom, top = ax.get_ylim()
ax.set_ylim(bottom + 0.5, top - 0.5)
ax.set_title('NFL DVOA Correlation Matrix: 1985-2019')
plt.show()