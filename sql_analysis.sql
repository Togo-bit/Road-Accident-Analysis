-- MySQL (Storage & Queries)
-- Road Accident Risk Analysis

-- 1)Road Type & Risk Insights
SELECT road_type, AVG(accident_risk) as avg_risk,
	AVG(num_reported_accidents) as avg_accidents
FROM road
GROUP BY road_type
ORDER BY avg_risk desc;

-- 2)Weather & Lighting Impact
SELECT weather, lighting, AVG(accident_risk) as avg_risk
FROM road
GROUP BY weather, lighting
ORDER BY avg_risk desc;

-- 3)Time-Based Risk Patterns
SELECT time_of_day, holiday, AVG(accident_risk) as avg_risk
FROM road
GROUP BY time_of_day, holiday
ORDER BY avg_risk desc;

-- 4)School Season & Holidays
SELECT school_season, holiday, AVG(accident_risk) as avg_risk
FROM road
GROUP BY school_season, holiday
ORDER BY avg_risk desc;

-- 5)Infrastructure Effectiveness
SELECT road_signs_present, public_road, AVG(accident_risk) as avg_risk
FROM road
GROUP BY road_signs_present, public_road
ORDER BY avg_risk desc;

-- 6)Rank Road Types by Accident Risk
SELECT road_type, AVG(accident_risk) as avg_risk,
RANK() OVER(ORDER BY AVG(accident_risk) desc) as rnk
FROM road
GROUP BY road_type;

-- 7)Running Total of Accidents by Road Type
SELECT road_type, id, num_reported_accidents,
SUM(num_reported_accidents) OVER(partition by road_type ORDER BY id) as total_accidents
FROM road;

-- 8)Moving Average Accident Risk
SELECT id, accident_risk,
AVG(accident_risk) OVER(ORDER BY id) as moving_average
FROM road;

-- 9)Compare Each Row to Road-Type Average
SELECT id, road_type, accident_risk,
accident_risk - AVG(accident_risk) OVER(partition by road_type) as deviation_from_average
FROM road;

-- 10)Identify Top 3 Riskiest Roads per Type
SELECT *
FROM(SELECT *,
RANK() OVER(partition by road_type ORDER BY accident_risk desc) as rnk
FROM road) as x
WHERE x.rnk <= 3;

-- 11)Lag Analysis – Previous Accident Comparison
SELECT id, accident_risk,
LAG(accident_risk) OVER(ORDER BY id) as previous_value,
accident_risk - LAG(accident_risk) OVER(ORDER BY id) as difference
FROM road;

-- 12)First & Worst Risk Per Road Type
SELECT id, road_type, accident_risk,
FIRST_VALUE(accident_risk) OVER(partition by road_type ORDER BY id) as first_recorded_value,
MAX(accident_risk) OVER(partition by road_type) as worst_risk
FROM road;

-- 13)Percentile-Based Risk Classification
SELECT id, accident_risk,
NTILE(4) OVER(ORDER BY accident_risk) as risk_quartile
FROM road;

SELECT * FROM road;