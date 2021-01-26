use sakila;

-- Get all pairs of actors that worked together.

select f.title, sub1.actor_id, sub2.actor_id
from film_actor as sub1
cross join film_actor as sub2
	on sub1.film_id = sub2.film_id
    and sub1.actor_id <> sub2.actor_id
join film f
on f.film_id = sub1.film_id;

-- Get all pairs of customers that have rented the same film more than 3 times.

select count(f1.title) as n_movies,
	c1.customer_id as customer_1, c1.first_name, c1.last_name,
	c2.customer_id as customer_2, c2.first_name, c2.last_name
from sakila.customer as c1
	join sakila.rental as r1 on c1.customer_id = r1.customer_id
	join sakila.inventory as i1 on r1.inventory_id=i1.inventory_id
	join sakila.film as f1 on i1.film_id=f1.film_id
    #going the path backwards to find customer with the same rented movies
    join sakila.inventory as i2 on i2.film_id=f1.film_id
    join sakila.rental as r2 on i2.inventory_id =r2.inventory_id
    join sakila.customer as c2 on r2.customer_id=c2.customer_id
#using greater than to drop duplicates
where c1.customer_id >c2.customer_id
group by c1.customer_id, c1.first_name, c1.last_name, c2.customer_id, c2.first_name, c2.last_name
Having n_movies>3
order by n_movies desc;


-- Get all possible pairs of actors and films.
select * from (select distinct actor_id from actor) as sub1
cross join (select distinct film_id from film) as sub2;


