# Worldwide Layoffs Data Cleaning and Exploratory Data Analysis Using MySQL
## Project Overview:
Welcome to my analysis of Worldwide layoffs, focusing on workforce reduction across different industries due to global economic crisis. This project was created out of a desire to navigate and understand the worst hit industries and stages affected due to economic crisis more effectively. The data sourced from Kaggle which provides a foundation for my analysis, containing detailed information on companies, industries, locations, total laid off, percentage laid off, date and fund raised. Through a series of SQL queries, I explore key questions such as the layoffs by industry, company, location, countries and the date of layoffs such as when did the first and last layoff happened.

## Tools I Used:
For my deep dive into the data analyst job market, I harnessed the power of several key tools:
1) **SQL (Structured Query Language)**: The backbone of my analysis, allowing me to clean and analyze the data and find critical insights. 
2) **MySQL Workbench CE**: The Relational Database Management System, I used to run my SQL queries which let me easily perform data cleaning and exploratory data analysis.
3) **GitHub**: Essential for sharing my SQL code and analysis, ensuring collaboration and project tracking.

## Data Cleaning:
The data cleaning process included following steps:
1) Remove duplicates
2) Standardize the data
3) Null or Blank Values
4) Remove any columns

## Exploratory Data Analysis:
Each SQL query for this project aimed at investigating specific aspects of layoffs. Each SQL query are classified into 3 categories:
1) Easy Queries:
a) The maximum layoffs took place at which company ?
b) Look at percentage to see how big these layoffs were.
c) Which companies had 1 which is basically 100 percent of the company laid off ?
d) If we order by ‘funds_raised_millions’ we can see how big some of these companies were.

2) Medium Queries:
a) Top 5 companies with the biggest single layoff.
b) Top 10 companies with the most total layoffs.
c) Total layoffs by location.
d) When did the first and last layoff took place reported ?
e) Total layoffs by country, date, industry and stage.

3) Advanced Queries:
a) Earlier we looked at companies with the most layoffs. Now let's look at that per year.
b) Rolling total of layoffs per month.

## The Analysis and Insights:
1) The first layoff took place on 11th March 2020 and this was the day when WHO officially declared Covid-19 (SARS-CoV-2 Virus) as a global pandemic and the entire world was locked in their homes to avoid the spread of virus infection.
2) The last layoff was reported on 6th March 2023 and during this period of time, the US economy was under recession post 2007-2009 and global tech giants like Amazon, Google, Meta, Microsoft, Salesforce, etc. focussed on reducing their workforce and freeze the hirings of new candidates.
3) The worst hit industries included consumer, retail, transportation and finance.
4) The top 5 countries where most of people lost their jobs included United States, India, Netherlands, Sweden and Brazil.
5) The total number of job cuts increased rapidly from 2020 (80998) to 2023 (125677).
