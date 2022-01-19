-- 1.How many copies of the film Hunchback Impossible exist in the inventory system?
select title, count(a.film_id) from film a
join inventory b on a.film_id = b.film_id
where title = 'Hunchback Impossible'
group by title;

-- 2.List all films whose length is longer than the average of all the films.
select * from film
where length > (select avg(length) from film);

-- 3.Use subqueries to display all actors who appear in the film Alone Trip.
select first_name, last_name from actor a
join film_actor b on a.actor_id = b.actor_id
join film c on b.film_id = c.film_id
where title = 'Alone Trip';


-- 4.Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

select title from category a
join film_category b on a.category_id = b.category_id
join film c on b.film_id = c.film_id
where name = 'Family';

-- 5.Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join,
-- you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
select first_name, last_name, email, country from customer a
join address b on a.address_id = b.address_id
join city c on b.city_id = c.city_id
join country d on c.country_id = d.country_id
where country = 'Canada'
order by customer_id;


select first_name, last_name, email from customer
where address_id in (
select address_id from address
where city_id in (
select city_id from city
where country_id in (
select country_id from country
where country = 'Canada')));


-- 6.Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films.
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

-- most prolific actor
select  actor_id from film_actor
group by actor_id
order by count(film_id) desc
limit 1;

-- final answer
select title from film a
join film_actor b on a.film_id = b.film_id
where actor_id = (select  actor_id from film_actor
group by actor_id
order by count(film_id) desc
limit 1);

-- 7.Films rented by most profitable customer. 
-- You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

-- most profitable customer
select customer_id from payment
group by customer_id
order by count(amount) desc
limit 1;

-- rented by most profitable customer
select title from rental a
join inventory b on a.inventory_id = b.inventory_id
join film c on b.film_id = c.film_id
where customer_id = (select customer_id from payment
group by customer_id
order by count(amount) desc
limit 1);

-- 8.Customers who spent more than the average payments.   more than the average of each customer spent? or average movie money?

-- more than avg payments
select customer_id , sum(amount) from payment
where amount > (select avg(amount) from payment
order by customer_id)
group by customer_id;

-- avg payments
select avg(amount) from payment
order by customer_id;
