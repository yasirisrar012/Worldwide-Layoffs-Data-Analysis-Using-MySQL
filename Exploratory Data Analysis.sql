-- Exploratory Data Analysis
-- Here we are just going to explore the data and find trends or patterns or anything interesting like outliers
-- Normally when you start the EDA process you have some idea of what we're looking for
-- with this info we are just going to look around and see what we find !

SELECT * FROM layoffs_stagging2;

-- Easy Queries

-- The maximum layoffs took place at which company ? 
SELECT *
FROM layoffs_stagging2
WHERE total_laid_off = 
(SELECT MAX(total_laid_off) FROM layoffs_stagging2);

-- Look at percentage to see how big these layoffs were
SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM layoffs_stagging2
WHERE percentage_laid_off IS NOT NULL;

-- Which companies had 1 which is basically 100 percent of the company laid off ?
SELECT * 
FROM layoffs_stagging2
WHERE percentage_laid_off = 1;

-- If we order by funds_raised_millions we can see how big some of these companies were
SELECT * 
FROM layoffs_stagging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Medium Queries

-- Top 5 companies with the biggest single layoff
SELECT company, total_laid_off
FROM layoffs_stagging2
ORDER BY 2 DESC
LIMIT 5;

-- Top 10 Companies with the most total layoffs
SELECT company, SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

-- Total layoffs by location
SELECT location, SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

-- When did the first and last layoff took place reported ?
SELECT MIN(date), MAX(date)
FROM layoffs_stagging2;

-- Total layoffs by country, date, industry and stage
SELECT country, SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY YEAR(date)
ORDER BY 1 ASC;

SELECT industry, SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY stage
ORDER BY 2 DESC;

-- Advanced Queries

-- Earlier we looked at companies with the most layoffs. Now let's look at that per year.

WITH Company_Year AS
(
SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
FROM layoffs_stagging2
GROUP BY company, YEAR(date)
),
Company_Year_Rank AS
(
SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;

-- Rolling total of layoffs per month
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_stagging2
GROUP BY dates
ORDER BY dates ASC;

-- Now use it in a CTE so we can query off of it
WITH DATE_CTE AS
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_stagging2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) AS rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;