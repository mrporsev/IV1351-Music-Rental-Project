--Task1
--Shows the number of instruments rented per month during a specified year--
SELECT COUNT(*) AS amount_of_rentals, SUBSTRING(rental_start_date, 6, 2) AS month
FROM rental AS r
WHERE SUBSTRING(r.rental_start_date, 1, 4) = '2020'
GROUP BY month;

--Retrieves total number of rented instruments just one number--
SELECT COUNT(*) AS total_rented_instruments
FROM rental;

--rented instruments of each type--
SELECT i.type_of_instrument, COUNT(i.type_of_instrument) AS quantity_rented
FROM rental AS r, instrument AS i
WHERE r.instrument_id = i.instrument_id
GROUP BY i.type_of_instrument
ORDER BY quantity_rented;

--Task 2
--retrieve the average number of rentals per month during the entire year, instead of the total for each month.--
SELECT ROUND(CAST(COUNT(*) AS decimal)/12, 2) AS average_rentals_per_month, 2020 AS YEAR
FROM rental as r
WHERE SUBSTRING(r.rental_start_date, 1,4) = '2020';

--Task3
--Retrieves the number of lessons given per month during a specified year.--
SELECT COUNT(*) AS number_of_lessons, date_part('month', a.date) AS month
FROM appointment AS a
WHERE date_part('year', a.date) = '2021'
GROUP BY date_part('month', a.date);

--Retrieves the total number of lessons given during a specified year--
SELECT COUNT(*) AS number_of_lessons, '2021' AS year
FROM appointment AS a
WHERE date_part('year', a.date) = '2021';

--Retrieves the total number of lessons given during a specified year for individual lessons, ensembles and group lessons--
SELECT COUNT(type_of_class) AS number_of_lessons, type_of_class, '2021' AS year
FROM appointment AS a
WHERE date_part('year', a.date) = '2021'
GROUP BY a.type_of_class;

--Task 4
--The same as above, but retrieve the average number of lessons per month during the entire year, instead of the total for each month.--
SELECT ROUND(CAST(COUNT(*) AS decimal)/12, 2) AS average_number_of_lessons, '2021' AS year
FROM appointment AS a
WHERE date_part('year', a.date) = '2021';

--Task 5
--List all instructors who has given more than a specific number of lessons (independent of type) during the current month.
SELECT p.first_name, p.last_name, p.age, p.social_security_number, current_month.number_of_lessons FROM person as p, 
(
SELECT matching.person_id, COUNT(matching.person_id) AS number_of_lessons
FROM (
SELECT i.person_id, i.instructor_id, a.date
FROM instructor AS i, appointment as a
WHERE i.instructor_id = a.instructor_id
) AS matching
WHERE date_part('year', matching.date) = '2021' AND date_part('month', matching.date) = '3'
GROUP BY matching.person_id
) AS current_month
WHERE current_month.number_of_lessons > 2 AND current_month.person_id = p.person_id
ORDER BY current_month.number_of_lessons DESC;

--Also list the three instructors having given most lessons during the last month, sorted by number of given lessons.
 SELECT p.first_name, p.last_name, p.age, p.social_security_number, current_month.number_of_lessons FROM person as p, 
(
SELECT matching.person_id, COUNT(matching.person_id) AS number_of_lessons
FROM (
SELECT i.person_id, i.instructor_id, a.date
FROM instructor AS i, appointment as a
WHERE i.instructor_id = a.instructor_id
) AS matching
WHERE date_part('year', matching.date) = '2021' AND date_part('month', matching.date) = '3'
GROUP BY matching.person_id
) AS current_month
WHERE current_month.number_of_lessons > 2 AND current_month.person_id = p.person_id
ORDER BY current_month.number_of_lessons DESC
LIMIT 3;

--Task 6
--List all ensembles held during the next week, sorted by music genre and weekday
SELECT e.genre, a.date, EXTRACT(DOW FROM a.date) as weekday
FROM appointment AS a, ensembles AS e
WHERE a.appointment_id = e.appointment_id AND a.date > current_date
AND a.date = NOW()::DATE-EXTRACT(DOW FROM NOW())::INTEGER+8

--For each ensemble tell whether it's full booked, has 1-2 seats left or has more seats left.
CREATE MATERIALIZED VIEW bookings_left AS
SELECT DISTINCT a.type_of_class, a.date, CAST(e.max_no_of_students AS INT) - result.seats_taken AS seats_left
FROM appointment AS a, ensembles AS e, (
SELECT COUNT(student_id) as seats_taken, a.appointment_id
FROM student_bookings AS sb
RIGHT JOIN appointment AS a
ON sb.appointment_id = a.appointment_id
GROUP BY a.appointment_id
) AS result
WHERE a.appointment_id = result.appointment_id AND a.type_of_class = 'ensemble';

--Task 7
--List the three instruments with the lowest monthly rental fee. 
SELECT i.type_of_instrument, i.instrument_rental_per_month
FROM instrument AS i
ORDER BY i.instrument_rental_per_month ASC
LIMIT 3;

--For each instrument tell whether it is rented or available to rent.
SELECT i.type_of_instrument, i.instrument_rental_per_month, i.is_rented 
FROM instrument AS i
ORDER BY i.instrument_rental_per_month ASC;

--Also tell when the next group lesson for each listed instrument is scheduled.
SELECT DISTINCT ON (g.instrument) instrument, a.date, g.group_lesson_id
FROM appointment AS a, group_lesson AS g
WHERE a.appointment_id = g.appointment_id
AND a.date >= current_date
ORDER BY g.instrument, a.date ASC;

