select * from airbnb_berlin


-- 1. What is the average Airbnb price in Berlin?
SELECT ROUND(AVG(price)::numeric, 2) AS berlin_avg_price
FROM airbnb_berlin;


-- 2. Which room type is the most common?
SELECT room_type, COUNT(*) AS number_of_listings
FROM airbnb_berlin
GROUP BY room_type
ORDER BY number_of_listings DESC;


-- 3. What is the average price by room type?
SELECT room_type, ROUND(AVG(price)::numeric, 2) AS avg_price
FROM airbnb_berlin
GROUP BY room_type
ORDER BY avg_price DESC;


-- 4. Which neighborhoods have the highest average prices?
SELECT neighbourhood, ROUND(AVG(price)::numeric, 2) AS avg_price
FROM airbnb_berlin
GROUP BY neighbourhood
ORDER BY avg_price DESC;


-- 5. Which neighborhoods have the most listings?
SELECT neighbourhood, COUNT(id) AS most_listings
FROM airbnb_berlin
GROUP BY neighbourhood
ORDER BY most_listings DESC;

-- 6. Which hosts own the most listings?
SELECT host_id, host_name, COUNT(id) as number_of_listings
FROM airbnb_berlin
GROUP BY host_id, host_name
ORDER BY number_of_listings DESC;


-- 7. Are multi-listing hosts more expensive than single-listing hosts?
SELECT host_type, ROUND(AVG(price)::numeric, 2) AS avg_price
FROM airbnb_berlin
GROUP BY host_type
ORDER BY avg_price DESC;

-- 8. Which room type has the highest average availability?
SELECT room_type, ROUND(AVG(availability_365)::numeric, 2) AS avg_availability
FROM airbnb_berlin
GROUP BY room_type
ORDER BY avg_availability DESC;

-- 9. Which neighborhoods generate the highest estimated revenue?
SELECT neighbourhood,
       ROUND(SUM(estimated_annual_revenue)::numeric, 2) AS total_estimated_revenue
FROM airbnb_berlin
GROUP BY neighbourhood
ORDER BY total_estimated_revenue DESC;

-- 10. How many listings are licensed vs unlicensed?
SELECT has_license,
       COUNT(*) AS number_of_listings
FROM airbnb_berlin
GROUP BY has_license
ORDER BY number_of_listings DESC;

-- 11. Which listings receive the highest number of reviews?
SELECT 
    CASE 
        WHEN has_license = TRUE THEN 'Licensed'
        ELSE 'Unlicensed'
    END AS license_status,
    COUNT(*) AS number_of_listings
FROM airbnb_berlin
GROUP BY license_status
ORDER BY number_of_listings DESC;


-- 12. Which neighborhoods have the highest review activity?
SELECT neighbourhood,
       SUM(number_of_reviews) AS total_reviews,
       ROUND(AVG(reviews_per_month)::numeric, 2) AS avg_reviews_per_month
FROM airbnb_berlin
GROUP BY neighbourhood
ORDER BY total_reviews DESC;
