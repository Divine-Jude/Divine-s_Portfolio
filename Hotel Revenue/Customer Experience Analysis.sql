WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)
-- MERGE TABLES
SELECT * FROM hotels
LEFT JOIN 
	[market_segment] ON hotels.market_segment = [market_segment].market_segment
LEFT JOIN 
	[meal_cost] ON hotels.meal = [meal_cost].meal;


-- calculates the total number of nights stayed by guest
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT
	SUM(stays_in_week_nights ) + SUM(stays_in_weekend_nights) AS Total_nights
FROM hotels;


-- calculate the number of bookings for each arrival year from the combined data of 2018, 2019, and 2020
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT
	arrival_date_year,
	COUNT(*) AS Number_of_booking
FROM hotels
GROUP BY arrival_date_year
ORDER BY Number_of_booking DESC;



-- Does the customers require a car parking space? (0 — No, 1 — Yes)
WITH hotels AS (
  SELECT * FROM [2018]
  UNION 
  SELECT * FROM [2019]
  UNION 
  SELECT * FROM [2020]
)

SELECT CASE WHEN required_car_parking_spaces = 0 THEN 'No'
         ELSE 'Yes'
       END AS required_car_parking,
       COUNT(*) AS count
FROM hotels
GROUP BY CASE WHEN required_car_parking_spaces = 0 THEN 'No'
           ELSE 'Yes'
         END
ORDER BY count DESC;


-- What are the most preferred types of meal plans by guests
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT hotels.meal, 
	COUNT(*) AS meal_count
FROM hotels
LEFT JOIN [meal_cost] ON hotels.meal = [meal_cost].meal
GROUP BY hotels.meal
ORDER BY meal_count DESC;


-- calculates the number of bookings for each reserved room type
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT reserved_room_type, 
	COUNT(*) AS room_count
FROM hotels
GROUP BY reserved_room_type
ORDER BY room_count DESC;
