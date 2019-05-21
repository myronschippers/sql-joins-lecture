CREATE TABLE "cohort" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(25),
	"start_date" DATE
);

CREATE TABLE "student" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50),
	"cohort_id" INT REFERENCES "cohort"
);

INSERT INTO "cohort" ("name", "start_date")
VALUES ('Enhydra', '4/15/2019'),
('Isurus', '7/29/2019');

INSERT INTO "student" ("name", "cohort_id")
VALUES ('Austin', 1),
('Devon', 1),
('Cory', 1),
('Isaac', 1),
('Konou', 1);

INSERT INTO "student" ("name", "cohort_id")
VALUES ('James', 2),
('Ellen', 2);

-- Select all cohorts, but not students
SELECT * FROM "cohort";

-- Select all students, but no cohort
SELECT * FROM "student";

-- Select everyone and their cohort
SELECT * FROM "student"
JOIN "cohort" ON "cohort".id = "student".cohort_id;

-- Count of all students
SELECT count(*) FROM "student";

-- Count of all students in Enhydra
SELECT count(*) FROM "student"
JOIN "cohort" ON "cohort".id = "student".cohort_id
WHERE "cohort".name = 'Enhydra';

-- Group Cohorts by name and give the student count for all cohorts
SELECT "cohort".name, count(*) FROM "student"
JOIN "cohort" ON "cohort".id = "student".cohort_id
GROUP BY "cohort".name;

-- Order Students By Name in Descending Order
SELECT * FROM "student"
JOIN "cohort" ON "cohort".id = "student"."cohort_id"
WHERE "cohort".name = 'Enhydra'
ORDER BY "student".name DESC;

-- Order Students By Name in Descending Order but only the first 2
SELECT * FROM "student"
JOIN "cohort" ON "cohort".id = "student"."cohort_id"
WHERE "cohort".name = 'Enhydra'
ORDER BY "student".name DESC LIMIT 2;

-- Order Students By Name in Ascending Order but only the first 2
SELECT * FROM "student"
JOIN "cohort" ON "cohort".id = "student"."cohort_id"
WHERE "cohort".name = 'Enhydra'
ORDER BY "student".name ASC LIMIT 2;






