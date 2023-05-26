WITH hotels AS (
  SELECT * FROM [2018]
  UNION 
  SELECT * FROM [2019]
  UNION 
  SELECT * FROM [2020]
)
-- Merging the tables
SELECT * FROM
  hotels
LEFT JOIN
  dbo.market_segment ON hotels.market_segment = dbo.market_segment.market_segment
LEFT JOIN
  dbo.meal_cost ON hotels.meal = dbo.meal_cost.meal;


-- whats the total revenue generated from the hotels
WITH hotels AS (
SELECT * FROM [2018]
UNION 
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - discount))), 2) AS revenue
FROM hotels
LEFT JOIN market_segment ON hotels.market_segment = market_segment.market_segment;


-- How has our hotel revenue trended over the years? Is it growing or declining?
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT
  arrival_date_year,
  hotel,
  ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - discount))), 2) AS revenue
FROM
  hotels
LEFT JOIN
  [market_segment] ON hotels.market_segment = [market_segment].market_segment
GROUP BY
  arrival_date_year,
  hotel
ORDER BY
  revenue DESC;


-- What is the revenue breakdown by hotel type? Are there any differences in revenue growth between the two hotel types?
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)
  
SELECT
  hotel,
  ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - Discount))), 2) AS revenue
FROM
  hotels
LEFT JOIN
  [market_segment] ON hotels.market_segment = [market_segment].market_segment
GROUP BY
  hotel;


-- What is each hotel type's average daily rate (ADR)?
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT hotel, ROUND(AVG(daily_rate), 2) AS Average_daily_rate
FROM hotels
GROUP BY hotel;


-- Identify any seasonal trends in hotel revenue, such as peak or low seasons?
WITH hotels AS (
  SELECT * FROM [2018]
  UNION 
  SELECT * FROM [2019]
  UNION 
  SELECT * FROM [2020]
)

SELECT 
	DATENAME(MONTH, reservation_status_date) AS reservation_month,
	ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - Discount))), 2) AS revenue
FROM
	hotels
LEFT JOIN 
	[market_segment] ON [market_segment].market_segment = hotels.market_segment
GROUP BY 
	DATENAME(MONTH, reservation_status_date)
ORDER BY
	revenue DESC;


-- What is the market segment distribution revenue
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT [market_segment].market_segment, 
	ROUND(SUM((Stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - discount))), 2) AS revenue
FROM hotels
LEFT JOIN 
	[market_segment] ON hotels.market_segment = [market_segment].market_segment
GROUP BY [market_segment].market_segment
ORDER BY revenue DESC;


