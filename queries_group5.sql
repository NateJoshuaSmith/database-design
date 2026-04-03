-- ============================================
-- CPSC 332 - Project
-- File: queries_groupX.sql
--       (rename: replace X with your group number)
-- Group: Group 5
-- Members: Alexia Arroyo Tellez, Andrew Davalos,
--          Nathan Smith, Nithin Rajesh
-- Date: 4/1/2026
-- ============================================

-- ============================================
-- SECTION 1: DATABASE SETUP (DO NOT MODIFY)
-- ============================================
USE world_group5;                     -- Replace X with your group number


-- ============================================
-- SECTION 2: QUERIES (MODIFY THIS SECTION)
-- Table names used in queries must match exactly what you defined in create_tables_groupX.sql

-- Write 12 queries total:
--   - 4 JOIN queries       (Queries 1-4)
--   - 3 Subqueries         (Queries 5-7)
--   - 3 Aggregation queries(Queries 8-10)  must use GROUP BY; at least one must use HAVING
--   - 2 Ranking queries    (Queries 11-12) must use ORDER BY
--
-- Requirements & Self-Check:
--   - Valid MySQL syntax
--   - No trivial SELECT *
--   - Each query must have a one-line comment describing its purpose
--   - Use fully qualified column names in JOIN conditions (e.g., City.CountryCode)
--   - Each query counts toward only ONE category
--   - NO PIGGYBACKING: Do not copy a previous query, add an ORDER BY, and submit it twice.
--   - NO TRIVIAL QUERIES: Every query must answer a distinct, real-world analytical question.
--   - All queries must return at least one row using your inserted data
-- ============================================


-- ============================================
-- PART 1: JOIN QUERIES (4 queries)
-- Must involve two or more tables
-- At least one must be an OUTER JOIN (LEFT JOIN or RIGHT JOIN)

-- Query 1 (Category: JOIN): Show country name, continent, GDP and inflation rate for 2020
SELECT Country.Name, Country.Continent, Economic_Indicators.gdp_usd, Economic_Indicators.inflation_rate
FROM Economic_Indicators
JOIN Country ON Economic_Indicators.country_code = Country.Code
WHERE Economic_Indicators.year = 2020
ORDER BY Country.Continent;


-- Query 2 (Category: JOIN): Show country name, exports, imports and trade balance for 2020
SELECT Country.Name, Trade_Statistics.exports_usd, Trade_Statistics.imports_usd, Trade_Statistics.trade_balance
FROM Trade_Statistics
JOIN Country ON Trade_Statistics.country_code = Country.Code
WHERE Trade_Statistics.year = 2020;

-- Query 3 (Category: JOIN): Show country name, continent, labor participation rate and youth unemployment for 2020
SELECT Country.Name, Country.Continent, Labor_Force.labor_rate, Labor_Force.youth_unemp
FROM Labor_Force
JOIN Country ON Labor_Force.country_code = Country.Code
WHERE Labor_Force.year = 2020;


-- Query 4 (Category: JOIN - OUTER JOIN): Show all countries with or without economic data using LEFT JOIN
SELECT Country.Name, Country.Continent, Economic_Indicators.gdp_usd, Economic_Indicators.gdp_per_capita
FROM Country
LEFT JOIN Economic_Indicators ON Country.Code = Economic_Indicators.country_code
WHERE Country.Continent IN ('North America', 'South America', 'Europe', 'Asia', 'Africa', 'Oceania')
ORDER BY Country.Continent, Economic_Indicators.gdp_usd DESC;

-- ============================================
-- PART 2: SUBQUERIES (3 queries)
-- Must include at least one EXISTS or NOT EXISTS
-- Must include at least one IN, NOT IN, or correlated subquery

-- EXAMPLE (delete this before submitting):
-- Query 0: Find countries that are major tourist hubs (over 20 million visitors) using IN
-- SELECT Country.Name
-- FROM Country
-- WHERE Country.Code IN (
--     SELECT Tourism_Statistics.country_code
--     FROM Tourism_Statistics
--     WHERE Tourism_Statistics.visitors_mil > 20
-- );
-- ============================================

-- Query 5 (Category: SUBQUERIES - EXISTS): Find countries that have both economic indicator and trade statistics data
SELECT Country.Name, Country.Continent
FROM Country
WHERE EXISTS (
    SELECT 1
    FROM Economic_Indicators
    WHERE Economic_Indicators.country_code = Country.Code
)
AND EXISTS (
    SELECT 1
    FROM Trade_Statistics
    WHERE Trade_Statistics.country_code = Country.Code
);

-- Query 6 (Category: SUBQUERIES - IN): Find countries with a trade surplus in 2020
SELECT Country.Name, Country.Population, Country.Continent
FROM Country
WHERE Country.Code IN (
    SELECT Trade_Statistics.country_code
    FROM Trade_Statistics
    WHERE Trade_Statistics.trade_balance > 0
    AND Trade_Statistics.year = 2020
);

-- Query 7 (Category: SUBQUERIES - Correlated): Find countries with above average GDP per capita in 2020
SELECT Country.Name, Economic_Indicators.gdp_per_capita, Country.Continent
FROM Economic_Indicators
JOIN Country ON Economic_Indicators.country_code = Country.Code
WHERE Economic_Indicators.gdp_per_capita > (
    SELECT AVG(e2.gdp_per_capita)
    FROM Economic_Indicators e2
    WHERE e2.year = 2020
)
AND Economic_Indicators.year = 2020
ORDER BY Economic_Indicators.gdp_per_capita DESC;

-- ============================================
-- PART 3: AGGREGATION QUERIES (3 queries)
-- Must use GROUP BY; at least one must use HAVING

-- EXAMPLE (delete this before submitting):
-- Query 0: Show total tourism revenue by continent (only continents above 100 billion)
-- SELECT Country.Continent, SUM(Tourism_Statistics.revenue_billion) AS total_revenue
-- FROM Country
-- JOIN Tourism_Statistics ON Country.Code = Tourism_Statistics.country_code
-- GROUP BY Country.Continent
-- HAVING SUM(Tourism_Statistics.revenue_billion) > 100;
-- ============================================

-- Query 8 (Category: AGGREGATION QUERIES): [Describe your query here]


-- Query 9 (Category: AGGREGATION QUERIES): [Describe your query here]


-- Query 10 (Category: AGGREGATION QUERIES): [Describe your query here]


-- ============================================
-- PART 4: RANKING QUERIES (2 queries)
-- Must use ORDER BY; LIMIT is optional
-- Must involve at least two tables

-- EXAMPLE (delete this before submitting):
-- Query 0: Top 5 countries by number of tourist visitors
-- SELECT Country.Name, Tourism_Statistics.visitors_mil
-- FROM Country
-- JOIN Tourism_Statistics ON Country.Code = Tourism_Statistics.country_code
-- ORDER BY Tourism_Statistics.visitors_mil DESC
-- LIMIT 5;
-- ============================================

-- Query 11 (Category: RANKING QUERIES): [Describe your query here]


-- Query 12 (Category: RANKING QUERIES): [Describe your query here]
