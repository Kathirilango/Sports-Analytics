from selenium import webdriver
from bs4 import BeautifulSoup
import pandas as pd
import sys, getopt

#Football Outsiders irrelevant column indices based on year
NO_LAST_YEARS 	= ([1985, 1987, 1988, 1989, 1991], [0,3,6,8,10])
MID_YEARS 		  = ([1986, 1990, 2019]+list(range(1992, 2018)), [0,3,4,7,9,11])
WEIGHTED_YEARS 	= ([2018], [0,3,4,5,8,10,12])

#Scrape data from footballoutsiders
def scrape_dvoa_data(driver):
  columns = [[],[],[],[],[],[]]
  for year in range(1985, 2020):
    driver.get("https://www.footballoutsiders.com/stats/nfl/team-efficiency/" + str(year))
    content = driver.page_source
    soup = BeautifulSoup(content)
    table = soup.find('table', attrs = {'border': 2})
    body = table.find('tbody')
    for row in body.findAll('tr'):
      i = 0
      j = 0
      for cell in row.findAll('td'):
        if cell.find('b') != None:
          break
        if not (((year in NO_LAST_YEARS[0])and (i in NO_LAST_YEARS[1])) or
                ((year in MID_YEARS[0])and (i in MID_YEARS[1])) or
                ((year in WEIGHTED_YEARS[0]) and (i in WEIGHTED_YEARS[1]))):
          columns[j].append(cell.text)
          j += 1
        i += 1
  return columns

#Convert strings to numerical values in data
def clean_data(columns):
  for i in range(len(columns)):
    for j in range(len(columns[i])):
      if '%' in columns[i][j]:
        columns[i][j] = float(columns[i][j][:-1])
      elif '-' in columns[i][j]:
        columns[i][j] = float(columns[i][j].split('-')[0])
  return columns

if __name__ == "__main__":
  driver = webdriver.Chrome("/*****/chromedriver")
  cols =  scrape_dvoa_data(driver)
  cols = clean_data(cols)
  df = pd.DataFrame({'name': cols[0], 'dvoa':cols[1], 'wins': cols[2], 'o_dvoa': cols[3], 'd_dvoa': cols[4], 's_dvoa': cols[5]})
  df.to_csv('dvoa_data.csv', index=False, encoding='utf-8')
