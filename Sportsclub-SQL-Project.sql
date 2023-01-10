DROP DATABASE IF EXISTS sportsclub;
CREATE DATABASE IF NOT EXISTS sportsclub;
USE sportsclub;

-- creating tables 

CREATE TABLE IF NOT EXISTS Trainers
(
	id 			INT AUTO_INCREMENT PRIMARY KEY,
	flName 		VARCHAR(40) NOT NULL,
	category 	CHAR(1),
					CHECK (category = 'A' OR category = 'B' OR category = 'C' OR category = 'D' OR category = 'E' OR NULL),
	rate 		INT
);

CREATE TABLE IF NOT EXISTS Sportsmen
(
	id 			INT AUTO_INCREMENT PRIMARY KEY,
	flName 		VARCHAR(40) NOT NULL,
	birthDate 	DATE NOT NULL, 
	sex 		CHAR(1) NOT NULL DEFAULT 'm',
					CHECK (sex = 'm' OR sex = 'f'),
	category 	CHAR(1),
					CHECK (category = 'A' OR category = 'B' OR category = 'C' OR category = 'D' OR category = 'E' OR NULL),
	trainer 	INT NOT NULL,	
	rate 		INT,
	scholarship INT DEFAULT 0, 
	address 	VARCHAR(40) NOT NULL,
	mobile 		VARCHAR(13) NULL,  
	homephone 	VARCHAR(7) NULL,
	UNIQUE (mobile, homephone), 
    CONSTRAINT sportsmen_trainer_fk
    FOREIGN KEY (trainer) REFERENCES Trainers(id)
);

CREATE TABLE IF NOT EXISTS Competition
(
	id 		 INT AUTO_INCREMENT PRIMARY KEY,
	comptype VARCHAR(40), 
	location VARCHAR(40),
	compdate DATE,
	agelimit INT 
);

CREATE TABLE IF NOT EXISTS Participation
(
	id 			INT AUTO_INCREMENT PRIMARY KEY,
	competition INT,	
	sportsman 	INT,	
	result 		INT,
	place 		INT,
	FOREIGN KEY (sportsman) REFERENCES Sportsmen(id),
	FOREIGN KEY (competition) REFERENCES Competition(id)	
);

-- Fill in the database tables using the INSERT command.

INSERT INTO Trainers (flName, category, rate) VALUES 
	('Violet Elle Woods', 'B', 2100), 
	('Max Dean Bailey', 'A', 2300),
	('Lola Jane Keith', 'A', 2350),
	('Savannah Marie Mathews', 'A', 2399), 
	('Lena Kiana Maddox', 'B', 2050),
	('Luke James Hooper', 'B', 2000);

INSERT INTO Sportsmen (flName, birthDate, sex, category, trainer, rate, scholarship, address, mobile, homephone) VALUES
	('Dominick Tom Jameson', '1996-10-22', 'm', 'D', 1, 1700, 1500, '3125 Kessla Way', '+380661558796', '7485139'),
	('Steven Jack Ball', '1997-05-13', 'm', 'C', 2, 1900, 1600, '68878 Fadel Route', '+380957892548', '7190077'),
	('Ross Max Booth', '1998-03-02', 'm', 'E', 5, 1500, 0, '992 Lempi Creek', NULL, NULL),
	('Richard Frank Jones', '1989-01-07', 'm', 'D', 4, 1600, 0, '33 Crestview Road', '+380509801433', '7095240'),
	('Kathleen Anne Hamilton', '1999-05-29', 'f', 'E', 6, 1550, 1400, '31 Holly Road', '+380675207119', NULL),
	('Susan Jane Morris', '2000-10-31', 'm', 'D', 6, 1650, 1800, '28 Settlement Avenue', NULL, '7196483'),
	('Kimberly Maria Perez', '1998-09-07', 'f', 'C', 3, 1800, 1900, '32 Willamette Avenue', '+380507890049', '7198825'),
	('Melissa Kira Pittman', '1994-03-13', 'f', 'C', 2, 1900, 1450, '17 Claremont Avenue', '+380665430876', NULL),
	('Richard Thomas Anderson', '1996-11-28', 'm', 'C', 3, 1999, 2000, '21 Croix Trail', '+380958763144', NULL),
	('Samantha Beth Hamilton', '1997-10-07', 'f', 'D', 1, 1690, 1900, '6 Huntington Drive', '+380665974439', '7775412'),
	('Vincent Justin Maxwell', '1996-07-19', 'm', 'E', 4, 1550, 0, '19 Marthas Lane', '+380677885109', NULL),
	('Rebecca Lauren Williams', '2001-09-09', 'f', 'E', 2, 1520, 0, '16 Peace Way', '+380997859920', '7198923'),
	('Alexis Tara Larsen', '1990-04-26', 'f', 'B', 4, 2000, 2600, '21 Huntington Drive', '+380665478810', '7145409'),
	('David Michael Harrison', '1999-08-02', 'm', 'E', 2, 1430, 1150, '16 Crestview Road', NULL, NULL); 

INSERT INTO Competition (comptype, location, compdate, agelimit) VALUES 
	('International', '24 Patricia Terrace', '2021-11-22', 18),
	('National', '24 Patricia Terrace', '2022-09-15', 30),
	('Regional', '17 Lake Street', '2022-06-01', 25),
	('Local', '4 Pine Avenue', '2022-02-13', 21);

INSERT INTO Participation (competition, sportsman, result, place) VALUES 
	(1, 1, 300, 1),
	(1, 2, 100, NULL),
	(1, 3, 270, 2),
	(1, 4, 50, 10),
	(2, 5, 200, 2),
	(2, 6, 330, 1),
	(2, 7, 100, 3),
	(3, 8, 150, 2),
	(3, 9, 200, 1),
	(4, 10, 70, NULL);

SELECT * FROM Trainers;
SELECT * FROM Sportsmen;
SELECT * FROM Competition;
SELECT * FROM Participation;

-- examples of using the ALTER TABLE command
ALTER TABLE Competition ADD starttime DATETIME;
SELECT * FROM Competition;
DESCRIBE Competition;

ALTER TABLE Competition MODIFY COLUMN starttime TIME;
SELECT * FROM Competition;
DESCRIBE Competition;

ALTER TABLE Competition DROP COLUMN starttime;
SELECT * FROM Competition;

ALTER TABLE Competition ADD CONSTRAINT chk_agelimit CHECK(agelimit > 0 AND agelimit < 100);
SELECT * FROM Competition;
INSERT INTO Competition (comptype, location, compdate, agelimit) 
VALUES ('International', '11 Laura Street', '2021-10-30', 180);
SELECT * FROM Competition;

ALTER TABLE Competition DROP CONSTRAINT chk_agelimit;
INSERT INTO Competition (comptype, location, compdate, agelimit) 
VALUES ('International', '11 Laura Street', '2021-10-30', 180);
SELECT * FROM Competition;

UPDATE Competition SET agelimit = 18 WHERE agelimit > 100;
SELECT * FROM Competition;

UPDATE Sportsmen SET scholarship = scholarship + 500;
SELECT * FROM Sportsmen;

SELECT * FROM Participation;
DELETE FROM Participation WHERE result < 200;
SELECT * FROM Participation;


SELECT DISTINCT category FROM Trainers;

SELECT * FROM Competition WHERE agelimit IN (18, 30);
SELECT * FROM Sportsmen WHERE category NOT IN ('D', 'E');
SELECT * FROM Trainers WHERE rate BETWEEN 2100 AND 2370;

SELECT * FROM Sportsmen WHERE mobile LIKE '+38095%';
SELECT * FROM Competition WHERE agelimit LIKE '2_';
SELECT * FROM Sportsmen WHERE birthDate LIKE '%-05-%';
SELECT * FROM Sportsmen WHERE birthDate LIKE '%-05-2_';

SELECT * FROM Sportsmen WHERE flName REGEXP 'Hamilton$';
SELECT * FROM Sportsmen WHERE birthDate REGEXP '^19';
SELECT * FROM Sportsmen WHERE birthDate REGEXP '^19.{7}2$';
SELECT * FROM Trainers WHERE rate REGEXP '^2[2-4].0$';	
SELECT * FROM Competition WHERE location REGEXP '24 Patricia Terrace|17 Lake Street';


SELECT AVG(scholarship) AS Average_scholarship 
FROM Sportsmen
WHERE rate > 1800;

SELECT SUM(scholarship) FROM Sportsmen;

SELECT MIN(rate), MAX(rate) FROM Trainers;

SELECT COUNT(*) AS numberOfSportsmen 
FROM Sportsmen;

SELECT COUNT(mobile) FROM Sportsmen;

SELECT rate, COUNT(*) AS highRateCount
FROM Sportsmen
WHERE rate > 1700
GROUP BY rate
ORDER BY rate DESC;

SELECT rate, COUNT(*) AS highRateCount
FROM Sportsmen
WHERE scholarship > 1500
GROUP BY rate
HAVING COUNT(*) > 1;

SELECT * FROM Sportsmen
WHERE EXISTS
(SELECT * FROM Trainers 
 WHERE Sportsmen.rate = Trainers.rate);

SELECT id, flName,
    (SELECT flName FROM Trainers
     WHERE Trainers.id = Sportsmen.trainer) AS Trainer
FROM Sportsmen;

SELECT t.id, t.flName,
    (SELECT COUNT(*) FROM Sportsmen s1
     WHERE s1.trainer = t.id) AS numberOfSportsmen
FROM Trainers t;

SELECT * FROM Trainers
WHERE rate > (SELECT AVG(rate) FROM Trainers);


INSERT INTO Sportsmen (flName, birthDate, sex, trainer, address) 
VALUE ('Jackson Evan Smith', '1987-09-01', 'm', 
       (SELECT id 
        FROM Trainers WHERE flName = 'Lena Kiana Maddox'),
       '7 Main Street');
SELECT * FROM Sportsmen;

-- Increasing the scholarship by 30% for each Sportsman whose Trainer has a rating above 2200.
UPDATE Sportsmen
SET scholarship = scholarship * 1.3
WHERE trainer IN (SELECT id 
                  FROM Trainers 
                  WHERE rate > 2200);
                  
SELECT id, flName, trainer, scholarship, rate 
FROM Sportsmen;

-- Deleting Participation in a contest of a Sportsman whose Trainer has an id = 5. 
SELECT * FROM Participation;                   

DELETE FROM Participation
WHERE sportsman IN (SELECT id 
                   FROM Sportsmen
                   WHERE trainer = 5);

SELECT * FROM Participation; 



-- implicit joins
SELECT s.id, s.flName, s.rate, 
       t.flName AS TrainersName,
       t.rate AS TrainersRate
FROM Sportsmen AS s, 
     Trainers AS t
WHERE s.trainer = t.id
ORDER BY s.id;


SELECT s.id, s.flName, s.rate, 
       c.comptype AS CompetitionType, 
       c.location AS CompetitionLocation,
       p.result
FROM Sportsmen AS s, 
     Competition AS c, 
     Participation as p
WHERE s.id = p.sportsman AND p.competition = c.id;

-- inner join
SELECT s.id, s.flName, p.result 
FROM Sportsmen AS s
INNER JOIN Participation AS p 
ON p.sportsman = s.id AND p.result > 250;


SELECT Sportsmen.id, 
       Sportsmen.flName, 
       Trainers.flName AS TrainersName,   
       Participation.result 
FROM Sportsmen
INNER JOIN Trainers 
    ON Trainers.id = Sportsmen.trainer
INNER JOIN Participation 
    ON Participation.sportsman = Sportsmen.id;

-- left outer join
SELECT Sportsmen.id, flName, rate,
       Participation.competition,
       Participation.result 
FROM Sportsmen
LEFT JOIN Participation 
          ON Sportsmen.id = Participation.sportsman;

-- right outer join
SELECT Sportsmen.id, flName, rate,
       Participation.competition,
       Participation.result 
FROM Sportsmen
RIGHT JOIN Participation 
           ON Sportsmen.id = Participation.sportsman;