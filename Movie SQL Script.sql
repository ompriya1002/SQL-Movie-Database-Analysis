create database movies;
use movies;

-- 1. From the following table, write a SQL query to find the name and year of the movies. Return movie title, movie release year.
select mov_title,mov_year 
from movie;

-- 2. From the following table, write a SQL query to find when the movie 'American Beauty' released. Return movie release year.
select mov_title,mov_year 
from movie
where mov_title = "American Beauty" ;

-- 3. From the following table, write a SQL query to find the movie that was released in 1999. Return movie title.
select mov_title,mov_year 
from movie
where mov_year = 1999 ;

-- 4. From the following table, write a SQL query to find those movies, which were released before 1998. Return movie title.
select mov_title,mov_year 
from movie
where mov_year < 1998 ;

-- 5. From the following tables, write a SQL query to find the name of all reviewers and movies together in a single list.
select rev_name
from reviewer
union
select mov_title
from movie;

-- 6. From the following table, write a SQL query to find all reviewers who have rated seven or more stars to their rating. 
-- Return reviewer name.
SELECT reviewer.rev_name
FROM reviewer, rating
WHERE rating.rev_id = reviewer.rev_id
      AND rating.rev_stars >= 7 ;
      
-- 7. From the following tables, write a SQL query to find the movies without any rating. Return movie title.
select mov_title 
from movie
where mov_id not in (select mov_id from rating);

-- 8. From the following table, write a SQL query to find the movies with ID 905 or 907 or 917. Return movie title.
select mov_title
from movie
where mov_id in(905,907,917)

-- 9. From the following table, write a SQL query to find the movie titles that contain the word 'Boogie Nights'. 
-- Sort the result-set in ascending order by movie year. Return movie ID, movie title and movie release year.
select *
from movie
where mov_title like "%Boogie Nights%";

-- 10. From the following table, write a SQL query to find those actors with the first name 'Woody' and the last name 'Allen'. 
-- Return actor ID.
select * from actor
where act_fname = "Woody"
and act_lname = "Allen";

-- 11. From the following tables, write a SQL query to find the actors who played a role in the movie 'Annie Hall'. 
-- Return all the fields of actor table.
select*
from actor
where act_id in( select act_id
                 from movie_cast
                 where mov_id in(select mov_id from movie
								where mov_title = "Annie Hall") );

-- 12. From the following tables, write a SQL query to find the director of a film that cast a role in 'Eyes Wide Shut'. 
-- Return director first name, last name.
select * from director
where dir_id in (select dir_id from movie_direction where mov_id in 
	                                     (select mov_id from movie_cast where mov_id in  
                                                           (select mov_id from movie where mov_title = "Eyes Wide Shut")
                                                           )
                                                           );

-- 13. From the following table, write a SQL query to find those movies that have been released in countries other than the United Kingdom. 
-- Return movie title, movie year, movie time, and date of release, releasing country.
select * from movie
where mov_rel_country <> "UK";

-- 14. From the following tables, write a SQL query to find for movies whose reviewer is unknown. 
-- Return movie title, year, release date, director first name, last name, actor first name, last name.
SELECT a.mov_title, a.mov_year, a.mov_dt_rel, 
       c.dir_fname, c.dir_lname, f.act_fname, f.act_lname
FROM movie a
JOIN movie_direction b ON a.mov_id = b.mov_id
JOIN director c ON b.dir_id = c.dir_id
JOIN rating d ON a.mov_id = d.mov_id
JOIN reviewer e ON d.rev_id = e.rev_id
JOIN movie_cast g ON a.mov_id = g.mov_id
JOIN actor f ON g.act_id = f.act_id
WHERE e.rev_name IS NULL;

-- 15. From the following tables, write a SQL query to find those movies directed by the director whose first name is Woddy and 
-- last name is Allen. Return movie title.
select * from movie
where mov_id in (select mov_id from movie_direction 
where dir_id in (select dir_id 
               from director
			  where dir_fname = "Woody" and dir_lname = "Allen"));

-- 16. From the following tables, write a SQL query to determine those years in which there was at least one movie that received a rating 
-- of at least three stars.  Sort the result-set in ascending order by movie year. Return movie year.
SELECT DISTINCT mov_year 
FROM movie 
WHERE mov_id IN (  SELECT mov_id 
  FROM rating 
  WHERE rev_stars > 3
) 
ORDER BY mov_year;

-- 17. From the following table, write a SQL query to search for movies that do not have any ratings. Return movie title.
SELECT DISTINCT mov_title 
FROM movie 
WHERE mov_id IN (
  SELECT mov_id 
  FROM movie 
  WHERE mov_id NOT IN (
    SELECT mov_id 
    FROM Rating));