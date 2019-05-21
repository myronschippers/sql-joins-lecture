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





