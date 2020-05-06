from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn import metrics
import pandas as pd
import sys

# Run linear regression on dvoa data vs. wins
def linear_regression(df):
  X = df[['dvoa', 'o_dvoa', 'd_dvoa', 's_dvoa']]
  y = df['wins']
  X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)
  regressor = LinearRegression()
  regressor.fit(X_train, y_train)
  y_pred = regressor.predict(X_test)
  score = metrics.r2_score(y_test.to_list(), y_pred.tolist())
  print ("Regression Model r2 Score: " + str(score))
  return regressor

if __name__ == "__main__":
  print("Enter values in range [-100.0, 100.0]. Make sure Total = Offensive - Defensive + ST")
  total = float(input("Total DVOA: "))
  offense = float(input("Offensive DVOA: "))
  defense = float(input("Defensive DVOA: "))
  st = float(input("Special Teams DVOA: "))
  if (total != offense - defense + st):
    print ("Warning: Provided numbers are not realistic. Prediction may be flawed.")

  df = pd.read_csv("dvoa_data.csv")
  clf = linear_regression(df)
  test_df = pd.DataFrame({'dvoa': [total], 'o_dvoa': [offense], 'd_dvoa': [defense], 's_dvoa': [st]})
  pred = clf.predict(test_df)
  wins = int(round(pred.tolist()[0],0))
  wins = 0 if wins < 0 else wins
  wins = 16 if wins > 16 else wins
  print("PREDICTION: Team will win " + str(wins) + " games.")