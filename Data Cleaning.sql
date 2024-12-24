-- Create database and import dataset
CREATE DATABASE world_layoffs;
USE world_layoffs;

-- Data Cleaning
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 4. Remove any columns

-- Creating a copy of raw data 
CREATE TABLE layoffs_stagging
LIKE layoffs;

SELECT * FROM layoffs_stagging;

INSERT layoffs_stagging
SELECT * 
FROM layoffs;

-- 1. Remove Duplicates

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage,
country, funds_raised_millions) AS row_num
FROM layoffs_stagging
)
SELECT * FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE `layoffs_stagging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_stagging2;

INSERT INTO layoffs_stagging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage,
country, funds_raised_millions) AS row_num
FROM layoffs_stagging;

SELECT * FROM layoffs_stagging2
WHERE row_num > 1;

DELETE FROM layoffs_stagging2
WHERE row_num > 1;

-- 2. Standardize the Data

SELECT company, TRIM(company)
FROM layoffs_stagging2;

UPDATE layoffs_stagging2
SET company = TRIM(company);

SELECT *
FROM layoffs_stagging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_stagging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoffs_stagging2
ORDER BY 1;

SELECT *
FROM layoffs_stagging2
WHERE country LIKE 'United States%'
ORDER BY 1;

UPDATE layoffs_stagging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_stagging2;

UPDATE layoffs_stagging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_stagging2
MODIFY COLUMN `date` DATE;

SELECT * FROM layoffs_stagging2;

-- 3. Null Values or blank values

SELECT * FROM layoffs_stagging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * FROM layoffs_stagging2
WHERE industry IS NULL
OR industry = '';

SELECT * FROM layoffs_stagging2
WHERE company IN ('Airbnb',"Bally's Interactive",'Carvana','Juul');

UPDATE layoffs_stagging2
SET industry = 'Travel'
WHERE company = 'Airbnb';

UPDATE layoffs_stagging2
SET industry = 'Transportation'
WHERE company = 'Carvana';

UPDATE layoffs_stagging2
SET industry = 'Consumer'
WHERE company = 'Juul';

SELECT * FROM layoffs_stagging2;

-- 4. Remove any columns

DELETE FROM layoffs_stagging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_stagging2
DROP COLUMN row_num;