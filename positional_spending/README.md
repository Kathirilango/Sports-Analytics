# Positional Spending Analysis
A model that determines a correct way for NFL teams to spend their money or proof that positional spending has nothing to do with winning in the NFL.

### Project Description
This project scrapes positional spending data from [Over The Cap](https://overthecap.com/positional-spending/) for every NFL team dating back to 2013 as well as win/loss data from [Pro Football Reference](https://www.pro-football-reference.com/years/2019/) and creates a decision tree classification model that predicts which teams in the current or upcoming NFL season will win at least a certain number of games (specified by the user).

### Usage
- Scrape file scrapes salary data from OTC and win/loss data from PFR and stores it into single CSV file. It accepts an option "-n" when run to determine if it should scrape past data or current/upcoming season data. Current season data will be stored in file "new_data.csv" and will (obviously) not contain win/loss results.
```
python3 ps_scrape.py [-n]
```
- Classification file creates decision tree model based on past data ("data.csv") and uses the model to predict whether this season's teams will win more or less than a specified number of games based on their spending (from "new_data.csv"). When running this program, user will be prompted to provide threshold for wins, and select which positions the model should factor into its learning.
- Correlation file plots correlation matrix of all positional spending data.

### Sources
All statistics courtesy of Over The Cap and Pro Football Reference.