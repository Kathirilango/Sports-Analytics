# DVOA Analysis
In the most simple terms, Defense-adjusted Value Over Average is a football efficiency metric that compares the situational success of a given play to league-average results in that situation. A far more detailed description can be found [here](https://www.footballoutsiders.com/info/methods).

### Project Description
This project scrapes DVOA data from the 1985 NFL season to the most recent season from [Football Outsiders](https://www.footballoutsiders.com/stats/nfl/team-efficiency/2019) and creates a regression model that predicts the number of regular season games a team will win based on its team DVOA numbers. Essentially, the model will determine the number of games that a team deserves to win in a season based *purely* on the statistical quality of its situational football. 

### Usage
- Scrape file scrapes DVOA data and stores in CSV file in same directory.
- Regression file creates and trains regression model, then predicts a team's wins based on its numbers. Give program total, offensive, defensive, and special teams DVOA when prompted.
- Correlation file plots correlation matrix of all DVOA data.

### Sources
All statistics courtesy of Football Outsiders.