-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off) as laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY laid_off DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT stage, ROUND(AVG(percentage_laid_off), 2) as laid_off
FROM layoffs_staging2
GROUP BY stage
ORDER BY laid_off DESC;

--

WITH Rolling_Total AS
(
	SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_off
	FROM layoffs_staging2
	WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
	GROUP BY `MONTH`
	ORDER BY 1 ASC
)
SELECT `MONTH`, total_off, SUM(total_off) OVER(ORDER BY `MONTH`) as rolling_total
FROM Rolling_Total;


WITH Company_Year ( company, years, total_laid_off ) AS
(
	SELECT company, YEAR(`date`), SUM(total_laid_off)
	FROM layoffs_staging2
	GROUP BY company, YEAR(`date`) 
	ORDER BY SUM(total_laid_off) DESC
), 
Company_Year_Rank AS
(
	SELECT *, 
	DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) as Ranking
	FROM Company_Year
	WHERE years IS NOT NULL AND total_laid_off IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;




