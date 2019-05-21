# SQL JOINS

- [SQL Joins](https://www.w3schools.com/sql/sql_join.asp)

## Relational Data

SQL is a Relational Database. That means its a database structured to recognize relations among stored items of information. We so far have only used one table, but in SQL, we will almost always have multiple tables that have relationships with each other.

### Database Normalization

Normalization is the process of breaking down and organizing database tables that describe the relationships between them. We do this so that when we make changes it doesn't have to be painful! More information can be found [here](https://www.essentialsql.com/get-ready-to-learn-sql-database-normalization-explained-in-simple-english/) and [here](https://blog.udemy.com/normalization-in-database-with-example/).

## Relationships

In order to normalize your database, you have to think about the relationships between different data in your database.

What's the relationship between a person and a SSN? A person can only have one SSN, and a SSN is owned by one person. This is  an example of ONE-TO-ONE. 

Other examples -- Countries and Capital Cities. 

 

## One-to-One

```sql
CREATE TABLE "person" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL
);

CREATE TABLE "social_security" (
	"id" SERIAL PRIMARY KEY,
	"person_id" INT REFERENCES "person",
	"number" INT NOT NULL
);

INSERT INTO "person" ("name") VALUES ('Scott');
INSERT INTO "social_security" ("number", "person_id")
	VALUES (55555, 1);
	
-- Get social security number for person
SELECT * FROM "person"
JOIN "social_security" ON "person".id = "social_security".person_id
WHERE "person"."id" = 1;
```

## One-to-Many

What's the relationship between Owners and Pets? 
An owner can have many Pets, a pet can have only 1 owner. This is an example of ONE-TO-MANY. 

Other examples -- Students and cohorts.

```SQL
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
```

### Counting

SQL has some built in functionality, as well! Let's explore `count`;


```SQL

-- Count of all students
SELECT count(*) FROM "student";

-- Count of all students in Enhydra
SELECT count(*) FROM "student"
JOIN "cohort" ON "cohort".id = "student".cohort_id
WHERE "cohort".name = 'Enhydra';

```

Theres also a `SUM()` aggregate function -- it adds the selected fields together.

### Group By

When counting, sometimes we need to do more than count by itself. Say we want the names of the cohort and how many people are in each one. In order to handle the potential counting craziness, we need to tell SQL how to group our data together before it counts. 


```SQL

-- Group Cohorts by name and give the student count for all cohorts
SELECT "cohort".name, count(*) FROM "student"
JOIN "cohort" ON "cohort".id = "student".cohort_id
GROUP BY "cohort".name;

```

### Sorting

We can control the order of the results by adding ORDER BY and ASC or DESC. This will keep your results in a specific sorting order.

```SQL
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
```