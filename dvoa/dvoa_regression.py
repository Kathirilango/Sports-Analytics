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
	print ("Linear Regression r2 Score: " + str(score))
	return regressor

def main(argv):
	if len(argv) < 4:
		print("Invalid arguments.\nUsage: python3 regressor.py <dvoa> <offense_dvoa> <defense_dvoa> <st_dvoa>")
		exit(0)
	df = pd.read_csv("dvoa_data.csv")
	clf = linear_regression(df)
	test_df = pd.DataFrame({'dvoa': [float(argv[0])], 'o_dvoa': [float(argv[1])],
							'd_dvoa': [float(argv[2])], 's_dvoa': [float(argv[3])]})
	pred = clf.predict(test_df)
	print("Team will win " + str(int(round(pred.tolist()[0],0))) + " games.")

if __name__ == "__main__":
	main(sys.argv[1:])