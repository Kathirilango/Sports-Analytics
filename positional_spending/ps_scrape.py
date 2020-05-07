from selenium import webdriver
from bs4 import BeautifulSoup
import pandas as pd
import sys, getopt
from datetime import date

OTC_OFFENSE_INDEX = 6
OTC_DEFENSE_INDEX = 11
CURRENT_YEAR 	    = date.today().year

# Scrape salary data from overthecap
def scrape_salary_data(driver, start_year, end_year):
  all_data = [[],[],[],[],[],[],[],[],[],[],[],[]]
  driver.get("https://overthecap.com/positional-spending/")
  content = driver.page_source
  soup = BeautifulSoup(content)
  for year in range(start_year, end_year+1):
    tab = soup.find('div', attrs = {'class': 'positional-spending-container ui-tabs-panel ui-corner-bottom ui-widget-content', 'id': 'y'+str(year)})
    for row in tab.findAll('tr', attrs = {'class': 'sortable'}):
      i = 0
      for item in row.findAll('td', attrs = {'class': 'sortable'}):
        all_data[i].append(float(item.text[1:].replace(',', '')) if i != 0 else (item.a.string+str(year)))
        i += 1
  return all_data

# Convert salaries to pct of team's spending
def get_percentages(otc_salary_data):
  for i in range(1, len(otc_salary_data)):
    for j in range (len(otc_salary_data[i])):
      total_cap = otc_salary_data[OTC_OFFENSE_INDEX][j]+otc_salary_data[OTC_DEFENSE_INDEX][j]
      if i != OTC_OFFENSE_INDEX and i != OTC_DEFENSE_INDEX:
        otc_salary_data[i][j] = 100 * otc_salary_data[i][j] / total_cap
  for i in range(1, len(otc_salary_data)):
    for j in range (len(otc_salary_data[i])):
      total_cap = otc_salary_data[OTC_OFFENSE_INDEX][j]+otc_salary_data[OTC_DEFENSE_INDEX][j]
      otc_salary_data[OTC_OFFENSE_INDEX][j] = 100*otc_salary_data[OTC_OFFENSE_INDEX][j] / total_cap
      otc_salary_data[OTC_DEFENSE_INDEX][j] = 100*otc_salary_data[OTC_DEFENSE_INDEX][j] / total_cap
  return otc_salary_data

# Scrape win/loss data from pro-football-reference
def scrape_records(driver, start_year, end_year):
  records = {}
  conferences = ['NFC', 'AFC']
  for year in range(start_year, end_year+1):
    driver.get("https://www.pro-football-reference.com/years/" + str(year) + "/index.htm")
    content = driver.page_source
    soup = BeautifulSoup(content)
    for conference in conferences:
      table = soup.find('table', attrs = {'class': 'sortable stats_table now_sortable', 'id': conference})
      for i in range(0, 20):
        if i % 5 != 0:
          row = table.find('tr', attrs = {'data-row': str(i)})
          team = row.find('a').string.split()[-1] + str(year)
          wins = int(row.find('td', attrs = {'data-stat': 'wins'}).text)
          records[team] = wins
  return records

def main(argv):
  driver = webdriver.Chrome("/Users/kathirilango/Documents/chromedriver")
  opts, _ = getopt.getopt(argv,"n",[])
  use_new_data = False
  for opt, _ in opts:
    if opt == '-n':
      print("Scraping salary data from " + str(CURRENT_YEAR) + " league season")
      use_new_data = True

  if use_new_data:
    new_data = scrape_salary_data(driver, start_year=CURRENT_YEAR, end_year=CURRENT_YEAR)
    new_pct_data = get_percentages(new_data)
    df_new = pd.DataFrame({'Name': new_pct_data[0], 'qb': new_pct_data[1], 'rb': new_pct_data[2], 'wr': new_pct_data[3], 'te': new_pct_data[4], 'ol': new_pct_data[5], 
                           'dl': new_pct_data[7], 'lb': new_pct_data[8], 's': new_pct_data[9], 'cb': new_pct_data[10], 
                           'off': new_pct_data[6], 'def': new_pct_data[11]})
    df_new.to_csv("new_data.csv", index=False, encoding='utf-8')
  else:
    all_data = scrape_salary_data(driver, start_year=2013, end_year=CURRENT_YEAR-1)
    pct_data = get_percentages(all_data)
    records = scrape_records(driver, start_year=2013, end_year=CURRENT_YEAR-1)
    num_wins = [records[n] for n in pct_data[0]]
    df = pd.DataFrame({'Name': pct_data[0], 'qb': pct_data[1], 'rb': pct_data[2], 'wr': pct_data[3], 'te': pct_data[4], 'ol': pct_data[5], 
                       'dl': pct_data[7], 'lb': pct_data[8], 's': pct_data[9], 'cb': pct_data[10], 
                       'off': pct_data[6], 'def': pct_data[11], 'wins': num_wins})
    df.to_csv('data.csv', index=False, encoding='utf-8')

if __name__ == "__main__":
  main(sys.argv[1:])