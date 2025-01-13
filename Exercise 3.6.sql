-- Fetching the column names for easier view:
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer'

-- Question 1: For film table

SELECT film_id,
title,
description,
release_year,
language_id,
rental_duration,
rental_rate,
length,
replacement_cost,
rating,
last_update,
special_features,
fulltext
FROM film
GROUP BY 
film_id,
title,
description,
release_year,
language_id,
rental_duration,
rental_rate,
length,
replacement_cost,
rating,
last_update,
special_features,
fulltext
HAVING COUNT(*) > 1;

-- Question 1: For customers table

SELECT 
customer_id,
store_id,
first_name,
last_name,
email,
address_id,
activebool,
create_date,
last_update,
active
FROM customer
GROUP BY
customer_id,
store_id,
first_name,
last_name,
email,
address_id,
activebool,
create_date,
last_update,
active
HAVING COUNT(*) > 1;

-- Text answer for checking duplicate data:
/* If there are duplicate data, it is advised to retain them in the database. However, for the data analysis one
can remove them in the view mode and perform the analysis. The second option which is not recommended is to delete
the duplicate records*/

-- Question 1: Checking for NULL - film table

SELECT *
FROM film
WHERE film_id IS NULL OR 
title IS NULL OR
description IS NULL OR
release_year IS NULL OR
language_id IS NULL OR
rental_duration IS NULL OR
rental_rate IS NULL OR
length IS NULL OR
replacement_cost IS NULL OR
rating IS NULL OR
last_update IS NULL OR
special_features IS NULL OR
fulltext IS NULL;

-- Question 2: Checking for NULL - customer table

SELECT *
FROM customer
WHERE customer_id IS NULL OR
store_id IS NULL OR
first_name IS NULL OR
last_name IS NULL OR
email IS NULL OR
address_id IS NULL OR
activebool IS NULL OR
create_date IS NULL OR
last_update IS NULL OR
active IS NULL;

-- Text answer for NULL data:

/* It is advised to ignore the columns that has a lot of missing values for the data analysis. If the data is missing
at random places for the numeric data, it is advised to impute the values with Average value*/

--- Question 1: Non-uniform data: Film table

SELECT DISTINCT film_id
title,
description,
release_year,
language_id,
rental_duration,
rental_rate,
length,
replacement_cost,
rating,
last_update,
special_features,
fulltext
FROM film

--- Question 1: Non-uniform data: customer table

SELECT DISTINCT
customer_id,
store_id,
first_name,
last_name,
email,
address_id,
activebool,
create_date,
last_update,
active
FROM customer

-- Text answer for non-uniform data:
/* Check the for distinct values to understand the categories that are present in the columns. If there are discrepencies, update the 
column with appropriate values using SET and WHERE function*/

--- Question 2.1: Summarizing your data - film table

SELECT 
AVG(release_year) AS average_release_year,
MIN(release_year) AS minimum_release_year,
MAX(release_year) AS maximum_release_year,
AVG(rental_duration) AS average_rental_duration,
MIN(rental_duration) AS minimum_rental_duration,
MAX(rental_duration) AS maximum_rental_duration,
AVG(rental_rate) AS average_rental_rate,
MIN(rental_rate) AS minimum_rental_rate,
MAX(rental_rate) AS maximum_rental_rate,
AVG(length) AS average_length,
MIN(length) AS minimum_length,
MAX(length) AS maximum_length,
AVG(replacement_cost) AS average_replacement_cost,
MIN(replacement_cost) AS minimum_replacement_cost,
MAX(replacement_cost) AS maximum_replacement_cost
FROM film

--- Question 2.1: Summarizing your data - customer table

/* Since, it is a dimension table, there are no measures to perform summary statistics */

--- Question 2.2: MODE For film table

SELECT 
MODE () WITHIN GROUP (ORDER BY language_id) AS modal_language_id,
MODE () WITHIN GROUP (ORDER BY rating) AS modal_rating
FROM film

--- Question 2.2: MODE For customer table

SELECT 
MODE () WITHIN GROUP (ORDER BY store_id) AS modal_store_id,
MODE () WITHIN GROUP (ORDER BY activebool) AS modal_activebool, /* allows us to check whether we have more active or inactive */
MODE () WITHIN GROUP (ORDER BY create_date) AS modal_create_date,
MODE () WITHIN GROUP (ORDER BY active) AS modal_active /* allows us to check whether we have more active or inactive */
FROM customer


