-- Question 1: Find the top 10 countries with most customers
SELECT  
	D.country,
    COUNT(customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.customer_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
GROUP BY D.country
ORDER BY customer_count DESC
LIMIT 10;

-- Question 2: Find the top 10 cities within the top 10 countries: 

SELECT  
	D.country,
	C.city,
    COUNT(customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.customer_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
WHERE D.country_id IN (
    SELECT D.country_id
    FROM customer A
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
    GROUP BY D.country_id
    ORDER BY COUNT(A.customer_id) DESC
    LIMIT 10
)
GROUP BY D.country, C.city
ORDER BY customer_count DESC
LIMIT 10;

-- Question 3: Find the top 5 customers from top 10 cities who paid highest 
-- amount to Rockbuster

SELECT 
    B.customer_id,
    B.first_name,
    B.last_name,
    E.country,
    D.city,
    SUM(A.amount) AS total_payment
FROM payment A
INNER JOIN customer B ON A.customer_id = B.customer_id
INNER JOIN address C ON B.address_id = C.address_id
INNER JOIN city D ON C.city_id = D.city_id
INNER JOIN country E ON D.country_id = E.country_id
WHERE (E.country, D.city) IN (
    SELECT 
        D.country, 
        C.city
    FROM customer A
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
WHERE D.country IN (
        SELECT D.country
        FROM customer A
        INNER JOIN address B ON A.address_id = B.address_id
        INNER JOIN city C ON B.city_id = C.city_id
        INNER JOIN country D ON C.country_id = D.country_id
        GROUP BY D.country
        ORDER BY COUNT(A.customer_id) DESC
        LIMIT 10
    )
    GROUP BY D.country, C.city
    ORDER BY COUNT(A.customer_id) DESC
    LIMIT 10
)
GROUP BY B.customer_id, B.first_name, B.last_name, D.city, E.country
ORDER BY total_payment DESC
LIMIT 5;
 
