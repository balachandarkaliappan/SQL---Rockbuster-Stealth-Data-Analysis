-- Which movies contributed the most/least to revenue gain?

/* most revenue gained */

SELECT film.title, 
	SUM(payment.amount) AS total_customer_payment
	SUM(rental_duration) AS total_duration,
	SUM(rental_rate) AS total_rent_rate,
	SUM(film.rental_rate * film.rental_duration) AS total_revenue
FROM payment
INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY total_customer_payment DESC
LIMIT 10;

/* least revenue gained */

SELECT film.title, 
	SUM(payment.amount) AS total_customer_payment,
	SUM(rental_duration) AS total_duration,
	SUM(film.rental_rate * film.rental_duration) AS total_revenue
FROM payment
INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY total_revenue ASC
LIMIT 10;

-- Total revenue of films

SELECT film.title, 
	SUM(payment.amount) AS total_customer_payment,
	SUM(rental_duration) AS total_duration,
	SUM(film.rental_rate * film.rental_duration) AS total_revenue
FROM payment
INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY total_revenue DESC;

-- What was the average rental duration for all videos?

SELECT 
	ROUND(AVG(rental_duration),2),
	ROUND(AVG(rental_rate), 2),
	ROUND(MAX(rental_duration),2),
	ROUND(MAX(rental_rate), 2),
	ROUND(MIN(rental_duration),2),
	ROUND(MIN(rental_rate), 2)
FROM film

-- Which countries are Rockbuster customers based in?
-- Where are customers with a high lifetime value based?
-- Do sales figures vary between geographic regions?

SELECT 
	country.country,
	SUM(payment.amount) AS total_payment,
	COUNT(customer.customer_id) AS total_customer_count
	FROM payment
    INNER JOIN customer ON payment.customer_id = customer.customer_id
	INNER JOIN address ON customer.address_id = address.address_id
	INNER JOIN city ON address.city_id = city.city_id
	INNER JOIN country ON city.country_id = country.country_id
GROUP BY country
	ORDER BY total_payment DESC;


SELECT 
	film.film_id,
	film.title,
	film.rating,
	COUNT(inventory.inventory_id) AS rental_times,
	film.rental_rate,
	film.rental_duration,
	COUNT(inventory.inventory_id) * film.rental_rate * film.rental_duration AS revenue
FROM rental
	INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
	INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.film_id, film.title, film.rating
ORDER BY revenue DESC;
