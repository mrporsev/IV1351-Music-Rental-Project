INSERT INTO "soundgood_music_school_facility"("soundgood_music_school_facility_id", "zip_code", "street_name", "city_name")
VALUES('1', '16550', 'Kungsgatan', 'Stockholm');

--Person#1--
INSERT INTO "person"("age", "first_name", "last_name", "social_security_number", "email", "phone_number", "zip_code", "street_name", "city_name")
VALUES('19', 'Stefan', 'Larsson', '200107082596', 'hej@hejsan.com', '063-7786760', '16551', 'Duvbogatan', 'Stockholm');

INSERT INTO student (person_id)
VALUES ('1');

--Person#3--
INSERT INTO "person"("age", "first_name", "last_name", "social_security_number", "email", "phone_number", "zip_code", "street_name", "city_name")
VALUES('19', 'Sofia', 'Knutberg', '200107082596', 'hesanlojsanj@hejsan.com', '033-4686760', '16554', 'Bondegatan', 'Uppsala');

INSERT INTO student (person_id)
VALUES ('3');

--Parent#1--
INSERT INTO guardian ("first_name", "last_name", "age", "social_security_number", "email", "phone_number", "student_id")
VALUES ('Kalle', 'Von Anka', '53', '196807082346', 'kalle@hotmail.com', '012-3486760', '1');

--Parent#2--
INSERT INTO guardian ("first_name", "last_name", "age", "social_security_number", "email", "phone_number", "student_id")
VALUES ('Josefina', 'Peterstrom', '53', '196808045746', 'josefina@hotmail.com', '051-0086760', '2');

--Parent#3--
INSERT INTO guardian ("first_name", "last_name", "age", "social_security_number", "email", "phone_number", "student_id")
VALUES ('Hamid', 'Hamza', '53', '196812545700', 'hamid@hotmail.com', '014-1386760', '3');

--Administrator#1--
INSERT INTO "person"("age", "first_name", "last_name", "social_security_number", "email", "phone_number", "zip_code", "street_name", "city_name")
VALUES('53', 'Eva-Marie', 'Burman', '197204104983', 'burman@hejsan.com', '030-7000760', '16411', 'Hammardalen', 'Stockholm')

INSERT INTO "administrative_staff" ("administrative_staff_id", "role", "soundgood_music_school_facility_id", "person_id")
VALUES ('1', 'Admin', '1', '4');

--Instructor#1--
INSERT INTO "person"("age", "first_name", "last_name", "social_security_number", "email", "phone_number", "zip_code", "street_name", "city_name")
VALUES('53', 'Greta', 'Bjornsson', '197204019003', 'greta@hejsan.com', '066-8910760', '16421', 'Storvika', 'Malmo');

INSERT INTO "instructor" ("soundgood_music_school_facility_id", "person_id")
VALUES ('1', '5');

--Instructor#2--
INSERT INTO "person"("age", "first_name", "last_name", "social_security_number", "email", "phone_number", "zip_code", "street_name", "city_name")
VALUES('53', 'Younes', 'Rolfsson', '197205019403', 'hej123@hejsan.com', '033-2712560', '17554', 'Sunegatan', 'Stockholm');

INSERT INTO "instructor" ("soundgood_music_school_facility_id", "person_id")
VALUES ('1', '7');

--Instructor#3--
INSERT INTO "person"("age", "first_name", "last_name", "social_security_number", "email", "phone_number", "zip_code", "street_name", "city_name")
VALUES('53', 'Birger', 'Von Sicard', '197203019453', 'hej123123@hejsan.com', '011-2714560', '17524', 'Drottningsholmsvagen', 'Stockholm');

INSERT INTO "instructor" ("soundgood_music_school_facility_id", "person_id")
VALUES ('1', '8');



--Instruments--
INSERT INTO "instrument" ("type_of_instrument", "instrument_rental_per_month", "is_rented", "no_of_available_instruments")
VALUES ('Piano', '40', 'true', '3');

INSERT INTO "instrument" ("type_of_instrument", "instrument_rental_per_month", "is_rented", "no_of_available_instruments")
VALUES ('Saxophone', '20', 'false', '5');

INSERT INTO "instrument" ("type_of_instrument", "instrument_rental_per_month", "is_rented", "no_of_available_instruments")
VALUES ('Guitar', '15', 'true', '4');

INSERT INTO "instrument" ("type_of_instrument", "instrument_rental_per_month", "is_rented", "no_of_available_instruments")
VALUES ('Guitar', '15', 'true', '4');

INSERT INTO "instrument" ("type_of_instrument", "instrument_rental_per_month", "is_rented", "no_of_available_instruments")
VALUES ('Trumpet', '70', 'true', '10');

--Rental--
INSERT INTO "rental" ("student_id", "rental_start_date", "rental_end_date", "instrument_id")
VALUES ('3','2020-03-12', '2021-03-12', '3');

--played_instrument--
INSERT INTO "played_instrument" ("student_id", "type_of_instrument", "skill_level")
VALUES ('1', 'Piano', '3');
INSERT INTO "played_instrument" ("student_id", "type_of_instrument", "skill_level")
VALUES ('2', 'Saxophone', '1');
INSERT INTO "played_instrument" ("student_id", "type_of_instrument", "skill_level")
VALUES ('3', 'Trumpet', '2');

--teaching_area--
INSERT INTO "teaching_area" ("type_of_instrument", "instructor_id")
VALUES ('Piano', '1');

--prices--
INSERT INTO "prices" ("soundgood_music_school_facility_id", "specific_skill_levels", "specific_lesson", "day_of_week", "price")
VALUES ('1', 'beginner', 'individual lesson', 'monday', '100');

INSERT INTO "prices" ("soundgood_music_school_facility_id", "specific_skill_levels", "specific_lesson", "day_of_week", "price")
VALUES ('1', 'advanced', 'ensembles', 'saturday', '140');

INSERT INTO "prices" ("soundgood_music_school_facility_id", "specific_skill_levels", "specific_lesson", "day_of_week", "price")
VALUES ('1', 'intermediate', 'group lesson', 'friday', '240');

--appointment--
INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('individual lesson', '2021-04-20', '2021-04-20 12:02:10', '1', '1', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('individual lesson', '2021-03-11', '2021-03-11 12:02:10', '1', '1', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('individual lesson', '2021-03-16', '2021-03-16 12:02:10', '3', '1', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('individual lesson', '2021-03-15', '2021-03-15 12:02:10', '3', '1', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('individual lesson', '2021-03-13', '2021-03-13 12:02:10', '1', '1', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('individual lesson', '2021-03-12', '2021-03-12 12:02:10', '1', '1', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('individual lesson', '2021-04-21', '2021-04-21 12:02:10', '3', '1', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('individual lesson', '2021-05-21', '2021-05-21 12:02:10', '4', '1', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('group lesson', '2021-02-10', '2021-02-10 12:02:10', '1', '3', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('group lesson', '2021-03-18', '2021-03-18 12:02:10', '3', '3', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('group lesson', '2021-03-10', '2021-03-10 12:02:10', '3', '3', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('group lesson', '2021-03-14', '2021-03-14 12:02:10', '4', '3', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('ensemble', '2021-09-03', '2021-09-03 12:02:10', '1', '6', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('ensemble', '2021-09-04', '2021-09-04 12:02:10', '1', '6', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('ensemble', '2021-09-06', '2021-09-06 12:02:10', '1', '6', '1');

INSERT INTO "appointment" ("type_of_class", "date", "time", "instructor_id", "prices_id", "administrative_staff_id")
VALUES ('ensemble', '2021-03-19', '2021-09-19 12:02:10', '1', '6', '1');

--applications--
INSERT INTO "application" ("student_id", "administrative_staff_id", "played_instrument", "instrument_skill_level")
VALUES ('1', '1', 'piano', '3')

INSERT INTO "application" ("student_id", "administrative_staff_id", "played_instrument", "instrument_skill_level")
VALUES ('2', '1', 'saxophone', '3')

INSERT INTO "application" ("student_id", "administrative_staff_id", "played_instrument", "instrument_skill_level")
VALUES ('3', '1', 'trumpet', '3')


--ensembles--
INSERT INTO "ensembles" ("min_no_of_students", "max_no_of_students", "genre", "administrative_staff_id", "appointment_id")
VALUES ('5', '50', 'rocknroll', '1', '4');

INSERT INTO "ensembles" ("min_no_of_students", "max_no_of_students", "genre", "administrative_staff_id", "appointment_id")
VALUES ('5', '50', 'jazz', '1', '5');

INSERT INTO "group_lesson" ("min_no_of_students", "max_no_of_students", "instrument", "administrative_staff_id", "appointment_id")
VALUES ('2', '10', 'piano', '1', '3');

INSERT INTO "individual_lesson" ("type_of_instrument", "prices_id", "instructor_id", "administrative_staff_id", "student_id")
VALUES ('piano', '1', '1', '1', '1');

INSERT INTO "individual_lesson" ("type_of_instrument", "prices_id", "instructor_id", "administrative_staff_id", "student_id")
VALUES ('piano', '1', '1', '1', '2');

INSERT INTO "individual_lesson" ("type_of_instrument", "prices_id", "instructor_id", "administrative_staff_id", "student_id")
VALUES ('piano', '1', '1', '1', '3');

--student_bookings--
INSERT INTO "student_bookings" ("appointment_id", "student_id")
VALUES ('1', '1');
INSERT INTO "student_bookings" ("appointment_id", "student_id")
VALUES ('1', '2');
INSERT INTO "student_bookings" ("appointment_id", "student_id")
VALUES ('1', '3');
INSERT INTO "student_bookings" ("appointment_id", "student_id")
VALUES('9', '1');
INSERT INTO "student_bookings" ("appointment_id", "student_id")
VALUES('9', '2');
INSERT INTO "student_bookings" ("appointment_id", "student_id")
VALUES('9', '3');
