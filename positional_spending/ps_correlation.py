import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

LABELS = ['QB', 'RB', 'WR', 'TE', 'OL', 'DL', 'LB', 'S', 'CB', 'OFF', 'DEF', 'WINS']

data = pd.read_csv("data.csv")
corr = data.corr()
sns.set(font_scale=0.6)
ax = sns.heatmap(corr, annot = True, fmt='.1g', vmin=-1, vmax=1, center= 0, cmap= 'coolwarm', 
                 linewidths=1, linecolor='white', square=True, annot_kws={"size": 7},
                 xticklabels= LABELS, yticklabels=LABELS)
bottom, top = ax.get_ylim()
ax.set_ylim(bottom + 0.5, top - 0.5)
ax.set_title('NFL Positional Spending Correlation Matrix: 2013-2019')
plt.show()