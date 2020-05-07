from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn import metrics
import pandas as pd

# Convert data to 1 or 0 depending on if it is above/below average
def compare_averages(df):
  averages = []
  for i in range(1, df.shape[1]-1):
    average = sum(list(df[df.columns[i]]))*1.0/df.shape[0]
    averages.append(average)
    for j in range(df.shape[0]):
      df.at[j, df.columns[i]] = 1 if df[df.columns[i]][j] > average else 0
  return df

# Train and test decision tree
def decision_tree(df, divider, positions):
  df_class = compare_averages(df)
  for j in range(len(df_class['wins'])):
    df_class.at[j, 'wins'] = 1 if df_class['wins'][j] >= divider else 0
  X = df_class[positions]
  y = df_class['wins']
  X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.30, random_state=42)
  clf = DecisionTreeClassifier(random_state=1)
  clf = clf.fit(X_train,y_train)
  y_pred = clf.predict(X_test)
  print("Decision Tree Accuracy: "+ str(metrics.accuracy_score(y_test, y_pred)) + "\n")
  return clf

if __name__ == "__main__":
  divider = int(input("Enter win threshold for model (range [0,16]): "))
  if divider < 0 or divider > 16:
    print("Error. Invalid win divider.")
    exit(0)
  print("Tell model which positions to include (OFF = Offense, DEF = Defense). Enter Y or N.")
  all_positions = ['QB', 'RB', 'WR', 'TE', 'OL', 'DL', 'LB', 'S', 'CB', 'OFF', 'DEF']
  positions = []
  for position in all_positions:
    ans = input(position + "? ")
    if ans.lower() == 'y':
      positions.append(position.lower())

  if len(positions) == 0:
    print ("Error. Must include at least one position.")
    exit(0)
  print("Wins Divider = " + str(divider))
  print("Model classifying based on: " + str(positions))
  df = pd.read_csv("data.csv")
  clf = decision_tree(df, divider, positions)
  real_test = compare_averages(pd.read_csv("new_data.csv"))
  real_pred = clf.predict(real_test[positions])
  winners = [real_test['Name'][i][:-4] for i in range(32) if real_pred.tolist()[i]==1]
  losers = [real_test['Name'][i][:-4] for i in range(32) if real_pred.tolist()[i]==0]
  print(str(real_test['Name'][0][-4:]) + " Season Prediction:\n")
  print("At least " + str(divider) + " wins: " + str(winners)+"\n")
  print("Less than " + str(divider) + " wins: " + str(losers))