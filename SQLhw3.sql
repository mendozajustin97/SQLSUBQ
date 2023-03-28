-- Question 1 List all customers who live in Texas (use JOINs)

SELECT *
FROM customer 
JOIN address 
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- Question 2 List all payments of more than $7.00 with the customer’s first and last name

SELECT c.first_name, c.last_name, p.amount
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
WHERE amount > 7.00;

-- Question 3 Show all customer names who have made over $175 in payments (use subqueries)

SELECT *
FROM customer
WHERE customer_id  in (
		SELECT customer_id
		FROM payment
		GROUP BY customer_id
		HAVING sum(amount) > 175
);

-- Question 4 List all customers that live in Argentina (use the city table)

SELECT *
FROM city;

SELECT c.first_name, c.last_name, a.district, ci.city, ca.country
FROM customer c
JOIN address a
ON c.address_id = a.address_id
JOIN city ci
ON a.city_id = ci.city_id
JOIN country ca
ON ci.country_id = ca.country_id
WHERE ca.country = 'Argentina';

-- Question 5 Show all the film categories with their count in descending order

SELECT c.category_id, c.name, count(*) AS num_movies_in_cat
FROM category c
JOIN film_category fc
ON fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY num_movies_in_cat DESC;

-- Question 6 What film had the most actors in it (show film info)?

SELECT film.film_id, film.title, count(*) AS num_actors
FROM film
JOIN film_actor 
ON film.film_id = film_actor.film_id 
JOIN actor 
ON actor.actor_id = film_actor.actor_id
GROUP BY film.film_id
ORDER BY num_actors DESC
LIMIT 1;

-- Question 7 Which actor has been in the least movies?

SELECT a.actor_id, a.first_name, a.last_name, count(*) AS nums_in_film
FROM actor a
JOIN film_actor fa
ON fa.actor_id = a.actor_id
JOIN film f 
ON fa.film_id = f.film_id 
GROUP BY a.actor_id
ORDER BY nums_in_film 
LIMIT 1;

-- Question 8 Which country has the most cities?

SELECT *
FROM country;

SELECT *
FROM city;

SELECT c.country_id, country, count(*) AS num_cities
FROM country c
JOIN city ct
ON c.country_id = ct.country_id
GROUP BY c.country_id
ORDER BY num_cities DESC 
LIMIT 3;


-- Question 9 List the actors who have been in between 20 and 25 films.

SELECT *
FROM actor;


SELECT a.actor_id, a.first_name, a.last_name, count(*)
FROM actor a
JOIN film_actor fa
ON fa.actor_id = a.actor_id
JOIN film f 
ON fa.film_id = f.film_id 
GROUP BY a.actor_id
HAVING COUNT(*) BETWEEN 20 AND 25
;
