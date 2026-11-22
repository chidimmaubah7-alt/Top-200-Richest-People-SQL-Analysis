-- 1. Retrieve the 20 richest billionaires. 
SELECT name, age,rank,country,industry, networth_billion
FROM Top200RichestPersonintheWorld
ORDER BY rank
LIMIT 20;

-- 2. Identify the five youngest billionaires. 
SELECT name,age,rank,networth_billion
FROM Top200RichestPersonintheWorld
ORDER BY age ASC
LIMIT 5;

-- 3. Calculate the average age and average net worth. 
SELECT AVG(age) AS Average_age,
       AVG(networth_billion) AS Average_net_worth
FROM Top200RichestPersonintheWorld;

-- 4. Identify the five most represented countries. 
SELECT country, COUNT(*) AS billionaire_count
FROM Top200RichestPersonintheWorld
GROUP BY country
ORDER BY billionaire_count DESC
LIMIT 5;

-- 5. Calculate the combined net worth of billionaires from each country. 
SELECT country, SUM(networth_billion) AS Combined_net_worth_per_country
FROM Top200RichestPersonintheWorld
GROUP BY country
ORDER BY Combined_net_worth_per_country;

-- 6. Identify the five industries with the highest number of billionaires. 
SELECT industry,
COUNT(*) AS Total_No_of_Billionaires
FROM Top200RichestPersonintheWorld
GROUP BY industry
ORDER BY Total_No_of_Billionaires DESC
LIMIT 5;

-- 7. Find countries with at least five billionaires. 
SELECT country,
COUNT(*) AS Total_No_of_Billionaires
FROM Top200RichestPersonintheWorld
GROUP BY country
HAVING COUNT(*) >= 5
ORDER BY Total_No_of_Billionaires DESC;

-- 8. Calculate the total wealth of billionaires younger than 50. 
SELECT SUM(networth_billion) AS Total_wealth_of_Billionaires_below_50
FROM Top200RichestPersonintheWorld
WHERE age < 50;

-- 9. Identify billionaires whose net worth exceeds the overall average net worth. 
SELECT name, 
       networth_billion
FROM Top200RichestPersonintheWorld
WHERE networth_billion > 
      (SELECT AVG(networth_billion) 
       FROM Top200RichestPersonintheWorld)
ORDER BY networth_billion DESC;

-- 10. Identify the industry with the highest average net worth
SELECT industry, AVG(networth_billion) AS Average_net_worth
FROM Top200RichestPersonintheWorld
GROUP BY industry
ORDER BY Average_net_worth DESC
LIMIT 1;

-- 11. Identify the five youngest billionaires with the highest net worth
SELECT name, age, networth_billion
FROM (SELECT name, age, networth_billion
FROM Top200RichestPersonintheWorld
ORDER BY age
LIMIT 5) AS Youngest
ORDER BY networth_billion DESC;

-- 12. Identify the industry with the youngest billionaire
SELECT name,age,industry
FROM Top200RichestPersonintheWorld
WHERE age = (SELECT MIN(age)
             FROM Top200RichestPersonintheWorld);
             
-- 13. Identify countries with the oldest billionaires
SELECT name, age, country
FROM Top200RichestPersonintheWorld
WHERE age = (SELECT MAX(age)
             FROM Top200RichestPersonintheWorld);
             
-- 14. Identify countries with the youngest billionaires
SELECT name,age,country
FROM Top200RichestPersonintheWorld
WHERE age = (SELECT MIN(age)
             FROM Top200RichestPersonintheWorld);

-- 15. Identify industries that dominate each country
SELECT country, industry, billionaire_count
FROM (
   SELECT country, industry, COUNT(*) AS billionaire_count
   FROM Top200RichestPersonintheWorld
   GROUP BY country, industry
) AS industry_counts
WHERE billionaire_count = (
  SELECT MAX(billionaire_count)
  FROM (
     SELECT country, industry, COUNT(*) AS billionaire_count
     FROM Top200RichestPersonintheWorld
     GROUP BY country, industry
   ) AS country_industry_counts
   WHERE country_industry_counts.country =
 industry_counts.country
 );
                   
-- 16. How many billionaires have a net worth above $50 billion? 
SELECT COUNT(*) AS Number_of_Billionaires
FROM Top200RichestPersonintheWorld
WHERE networth_billion > 50;

-- 17. What percentage of the dataset is made up of billionaires younger than 50? 
SELECT 
    COUNT(CASE WHEN age < 50 THEN 1 END)* 
100.0
    / COUNT(*) AS Percentage_below_50
FROM Top200RichestPersonintheWorld;

-- 18. Who has a net worth between $50 billion and $100 billion? 
SELECT age,
       name,
       networth_billion,
       rank,
       country
FROM Top200RichestPersonintheWorld
WHERE networth_billion BETWEEN 50 AND 100
ORDER BY networth_billion DESC;

-- 19. What is the total wealth of billionaires aged below 50? 
SELECT SUM(networth_billion) AS Total_wealth_of_billionaires
FROM Top200RichestPersonintheWorld
WHERE age < 50;

-- 20. Which country has the highest number of billionaires below age 40? 
SELECT country, COUNT(*) AS Total_Billionaires
FROM Top200RichestPersonintheWorld
WHERE age < 40
GROUP BY country
ORDER BY Total_Billionaires DESC
LIMIT 1;

-- 21. Which industry contributes the most to the combined wealth of the top 200? 
SELECT industry, SUM(networth_billion) AS Total_Net_Worth
FROM Top200RichestPersonintheWorld
GROUP BY industry
ORDER BY Total_Net_Worth DESC
LIMIT 1;

-- 22. What is the difference between the richest and poorest billionaire in the dataset? 
SELECT MAX(networth_billion) AS Richest_Net_Worth,
       MIN(networth_billion) AS Poorest_Net_Worth,
       MAX(networth_billion) - MIN(networth_billion) AS Wealth_difference
FROM Top200RichestPersonintheWorld;

-- 23. What is the average net worth of billionaires aged above 70? 
SELECT AVG(networth_billion) AS Average_net_worth_above_70
FROM Top200RichestPersonintheWorld
WHERE age > 70;

-- 24. Which billionaires belong to industries with more than 10 representatives?
SELECT name, industry,
FROM Top200RichestPersonintheWorld
WHERE industry IN (
    SELECT industry
FROM Top200RichestPersonintheWorld
GROUP BY industry
HAVING COUNT(*) > 10
);