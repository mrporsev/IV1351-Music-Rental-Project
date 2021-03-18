CREATE TABLE "person"
(
    person_id              serial       NOT NULL,
    age                    VARCHAR(3),
    first_name             VARCHAR(500),
    last_name              VARCHAR(500),
    social_security_number VARCHAR(12)  NOT NULL,
    email                  VARCHAR(500) UNIQUE,
    phone_number           VARCHAR(13) UNIQUE,
    zip_code               VARCHAR(5)   NOT NULL,
    street_name            VARCHAR(500) NOT NULL,
    city_name              VARCHAR(500) NOT NULL,
    PRIMARY KEY ("person_id")
);

CREATE TABLE "student"
(
    student_id serial NOT NULL,
    person_id  INT    NOT NULL references person,
    PRIMARY KEY (student_id)
);

CREATE TABLE "soundgood_music_school_facility"
(
    soundgood_music_school_facility_id serial       NOT NULL,
    zip_code                           VARCHAR(5)   NOT NULL,
    street_name                        VARCHAR(500) NOT NULL,
    city_name                          VARCHAR(500) NOT NULL,
    PRIMARY KEY (soundgood_music_school_facility_id)
);

CREATE TABLE "guardian"
(
    guardian_id            serial       NOT NULL,
    first_name             VARCHAR(500) NOT NULL,
    last_name              VARCHAR(500) NOT NULL,
    age                    VARCHAR(3)   NOT NULL,
    social_security_number VARCHAR(12)  NOT NULL,
    email                  VARCHAR(500) UNIQUE,
    phone_number           VARCHAR(13) UNIQUE,
    student_id             INT          NOT NULL REFERENCES student ON DELETE CASCADE,
    PRIMARY KEY ("guardian_id")
);

CREATE TABLE "bill"
(
    bill_id            serial NOT NULL,
    student_id         INT    NOT NULL REFERENCES student ON DELETE CASCADE,
    sibling_discount   VARCHAR(500),
    total_price_rental VARCHAR(500),
    amount_of_lessons  VARCHAR(500),
    PRIMARY KEY (bill_id)
);

CREATE TABLE "instructor"
(
    instructor_id                      serial NOT NULL,
    soundgood_music_school_facility_id INT    NOT NULL REFERENCES soundgood_music_school_facility ON DELETE CASCADE,
    person_id                          INT    NOT NULL REFERENCES person ON DELETE CASCADE,
    PRIMARY KEY (instructor_id)
);

CREATE TABLE "administrative_staff"
(
    administrative_staff_id            serial NOT NULL,
    role                               VARCHAR(500),
    soundgood_music_school_facility_id INT    NOT NULL REFERENCES soundgood_music_school_facility ON DELETE CASCADE,
    person_id                          INT    NOT NULL REFERENCES person ON DELETE CASCADE,
    PRIMARY KEY (administrative_staff_id)
);

CREATE TABLE "instrument"
(
    instrument_id               serial       NOT NULL,
    type_of_instrument          VARCHAR(500) NOT NULL,
    instrument_rental_per_month VARCHAR(500),
    is_rented                   boolean      NOT NULL,
    no_of_available_instruments VARCHAR(500) NOT NULL,
    PRIMARY KEY (instrument_id)
);

CREATE TABLE "rental"
(
    rental_id         serial NOT NULL,
    student_id        INT    NOT NULL REFERENCES student ON DELETE CASCADE,
    rental_start_date VARCHAR(500),
    rental_end_date   VARCHAR(500),
    instrument_id     INT    NOT NULL REFERENCES instrument,
    PRIMARY KEY (rental_id)
);

CREATE TABLE "played_instrument"
(
    student_id         INT          NOT NULL REFERENCES student,
    type_of_instrument VARCHAR(500) NOT NULL,
    skill_level        VARCHAR(500),
    PRIMARY KEY (type_of_instrument, student_id)
);


CREATE TABLE "teaching_area"
(
    type_of_instrument VARCHAR(500) NOT NULL,
    instructor_id      INT          NOT NULL REFERENCES instructor ON DELETE CASCADE,
    PRIMARY KEY (instructor_id, type_of_instrument)

);

CREATE TABLE "prices"
(
    prices_id                          serial       NOT NULL,
    soundgood_music_school_facility_id INT          NOT NULL REFERENCES soundgood_music_school_facility ON DELETE CASCADE,
    specific_skill_levels              VARCHAR(500) UNIQUE,
    specific_lesson                    VARCHAR(500) UNIQUE,
    day_of_week                        VARCHAR(500) UNIQUE,
    price                              VARCHAR(500) NOT NULL,
    PRIMARY KEY (prices_id)
);

CREATE TABLE "appointment"
(
    appointment_id          serial NOT NULL,
    type_of_class           VARCHAR(500),
    date                    DATE   NOT NULL UNIQUE,
    time                    TIMESTAMP(10) UNIQUE,
    instructor_id           INT    NOT NULL REFERENCES instructor ON DELETE CASCADE,
    prices_id               INT    NOT NULL REFERENCES prices,
    administrative_staff_id INT    NOT NULL REFERENCES administrative_staff,
    PRIMARY KEY (appointment_id)
);

CREATE TABLE "ensembles"
(
    ensembles_id            serial       NOT NULL,
    min_no_of_students      VARCHAR(500) NOT NULL,
    max_no_of_students      VARCHAR(500) NOT NULL,
    genre                   VARCHAR(500) NOT NULL,
    administrative_staff_id INT REFERENCES administrative_staff,
    appointment_id          INT          NOT NULL REFERENCES appointment ON DELETE CASCADE,
    PRIMARY KEY (ensembles_id)
);

CREATE TABLE "group_lesson"
(
    group_lesson_id         serial       NOT NULL,
    min_no_of_students      VARCHAR(500) NOT NULL,
    max_no_of_students      VARCHAR(500) NOT NULL,
    instrument              VARCHAR(500),
    administrative_staff_id INT REFERENCES administrative_staff,
    appointment_id          INT          NOT NULL REFERENCES appointment ON DELETE CASCADE,
    PRIMARY KEY (group_lesson_id)
);

CREATE TABLE "individual_lesson"
(
    individual_lesson_id    serial       NOT NULL,
    type_of_instrument      VARCHAR(500) NOT NULL,
    prices_id               INT REFERENCES prices,
    instructor_id           INT          NOT NULL REFERENCES instructor ON DELETE CASCADE,
    administrative_staff_id INT REFERENCES administrative_staff,
    student_id              INT          NOT NULL REFERENCES student ON DELETE CASCADE,
    PRIMARY KEY (individual_lesson_id)
);

CREATE TABLE "application"
(
    application_id          serial NOT NULL,
    student_ID              INT    NOT NULL REFERENCES student,
    administrative_staff_id INT    NOT NULL REFERENCES administrative_staff ON DELETE CASCADE,
    played_instrument       VARCHAR(500),
    instrument_skill_level  VARCHAR(500),
    PRIMARY KEY (application_id)
);

CREATE TABLE "audition"
(
    audition_id             serial      NOT NULL,
    student_id              INT         NOT NULL REFERENCES student ON DELETE CASCADE,
    administrative_staff_id INT         NOT NULL REFERENCES administrative_staff ON DELETE CASCADE,
    date                    DATE        NOT NULL UNIQUE,
    grade                   VARCHAR(10) NOT NULL,
    PRIMARY KEY (audition_id)
);

CREATE TABLE "student_bookings"
(
    "appointment_id" INT NOT NULL REFERENCES "appointment" ON DELETE CASCADE,
    "student_id"     INT NOT NULL REFERENCES "student" ON DELETE CASCADE,
    PRIMARY KEY ("appointment_id", "student_id")
);
