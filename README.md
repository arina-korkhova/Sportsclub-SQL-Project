# Sportsclub SQL Project

## Table of contents

- [Sportsclub SQL Project](#sportsclub-sql-project)
    - [Introduction](#introduction)
    - [EER Diagram](#eer-diagram)
    - [The content of our tables](#the-content-of-our-tables)
    - [Examples of using simple commands](#examples-of-using-simple-commands)
    - [Using aggregate functions (AVG, SUM, MIN, MAX, COUNT)](#using-aggregate-functions-avg-sum-min-max-count)
    - [Using operators (GROUP BY, HAVING, EXISTS)](#using-operators-group-by-having-exists)
    - [Using a correlated subquery](#using-a-correlated-subquery)
    - [Using a non-correlated subquery](#using-a-non-correlated-subquery)
    - [Using subqueries in such commands as INSERT, UPDATE, DELETE](#using-subqueries-in-such-commands-as-insert-update-delete)
    - [Joining tables in queries (implicit join,  INNER JOIN, LEFT(RIGHT) OUTER JOIN)](#joining-tables-in-queries-implicit-join--inner-join-leftright-outer-join)
    - [Many-to-many relationship](#many-to-many-relationship)
    - [Implementation of the external level of database display using VIEW](#implementation-of-the-external-level-of-database-display-using-view)
    - [Window functions](#window-functions)
    - [Stored Procedures and Functions. Triggers. Cursors](#stored-procedures-and-functions-triggers-cursors)

### Introduction
I have created a sportsclub database, which contains four tables: `Trainers`, `Sportsmen`, `Competition`, `Participation`.

<details><summary>The sports club database's relations:</summary>
<p>

1. Trainers 
    * id (Primary Key), 
    * full name,
    * category (A, B, C, D, E), 
        * Rating categories:
          | Category | Ratings range    |
          | -------- | ---------------- |
          | A        | 2200-2399        |
          | B        | 2000-2199        |
          | C        | 1800–1999        |
          | D        | 1600–1799        |
          | E        | 1400–1599        |
    * rate.
2. Sportsmen
    * id (Primary Key), 
    * full name (mandatory field), 
    * date of birth (mandatory field), 
    * sex (mandatory field, either 'm' or 'f'), 
    * category (A, B, C, D, E), 
    * trainer (mandatory field, external key to the Trainers table), 
    * rate, 
    * scholarship (by default 0), 
    * address (mandatory field), 
    * mobile phone number, 
    * home phone number.
3. Competition 
    * id (Primary Key), 
    * type, 
    * location, 
    * date,
    * age limit.
4. Participation 
    * id (Primary Key), 
    * competition (Foreign Key), 
    * sportsman (Foreign Key), 
    * result [number of points won], 
    * place [taken during competition].

</p>
</details>


### EER Diagram
EER diagrams provide a visual representation of the relationships among the tables in your model. 

Let's take a look at our database's diagram:

![EER Diagram](https://github.com/arina-korkhova/Sportsclub-SQL-Project/blob/main/images/EER_Diagram.png)

### The content of our tables
```sql
SELECT * FROM Trainers;
```
Output:
```
+----+------------------------+----------+------+
| id | flName                 | category | rate |
+----+------------------------+----------+------+
|  1 | Violet Elle Woods      | B        | 2100 |
|  2 | Max Dean Bailey        | A        | 2300 |
|  3 | Lola Jane Keith        | A        | 2350 |
|  4 | Savannah Marie Mathews | A        | 2399 |
|  5 | Lena Kiana Maddox      | B        | 2050 |
|  6 | Luke James Hooper      | B        | 2000 |
+----+------------------------+----------+------+
```
---
```sql
SELECT * FROM Sportsmen;
```
Output:
```
+----+-------------------------+------------+--------+----------+---------+------+-------------+----------------------+---------------+-----------+
| id | flName                  | birthDate  | sex    | category | trainer | rate | scholarship | address              | mobile        | homephone |
+----+-------------------------+------------+--------+----------+---------+------+-------------+----------------------+---------------+-----------+
|  1 | Dominick Tom Jameson    | 1996-10-22 | m      | D        |       1 | 1700 |        1500 | 3125 Kessla Way      | +380661558796 | 7485139   |
|  2 | Steven Jack Ball        | 1997-05-13 | m      | C        |       2 | 1900 |        1600 | 68878 Fadel Route    | +380957892548 | 7190077   |
|  3 | Ross Max Booth          | 1998-03-02 | m      | E        |       5 | 1500 |           0 | 992 Lempi Creek      | NULL          | NULL      |
|  4 | Richard Frank Jones     | 1989-01-07 | m      | D        |       4 | 1600 |           0 | 33 Crestview Road    | +380509801433 | 7095240   |
|  5 | Kathleen Anne Hamilton  | 1999-05-29 | f      | E        |       6 | 1550 |        1400 | 31 Holly Road        | +380675207119 | NULL      |
|  6 | Susan Jane Morris       | 2000-10-31 | m      | D        |       6 | 1650 |        1800 | 28 Settlement Avenue | NULL          | 7196483   |
|  7 | Kimberly Maria Perez    | 1998-09-07 | f      | C        |       3 | 1800 |        1900 | 32 Willamette Avenue | +380507890049 | 7198825   |
|  8 | Melissa Kira Pittman    | 1994-03-13 | f      | C        |       2 | 1900 |        1450 | 17 Claremont Avenue  | +380665430876 | NULL      |
|  9 | Richard Thomas Anderson | 1996-11-28 | m      | C        |       3 | 1999 |        2000 | 21 Croix Trail       | +380958763144 | NULL      |
| 10 | Samantha Beth Hamilton  | 1997-10-07 | f      | D        |       1 | 1690 |        1900 | 6 Huntington Drive   | +380665974439 | 7775412   |
| 11 | Vincent Justin Maxwell  | 1996-07-19 | m      | E        |       4 | 1550 |           0 | 19 Marthas Lane      | +380677885109 | NULL      |
| 12 | Rebecca Laurel Williams | 2001-09-09 | f      | E        |       2 | 1520 |           0 | 16 Peace Way         | +380997859920 | 7198923   |
| 13 | Alexis Tara Larsen      | 1990-04-26 | f      | B        |       4 | 2000 |        2600 | 21 Huntington Drive  | +380665478810 | 7145409   |
| 14 | David Michael Harrison  | 1999-08-02 | m      | E        |       2 | 1430 |        1150 | 16 Crestview Road    | NULL          | NULL      |
+----+-------------------------+------------+--------+----------+---------+------+-------------+----------------------+---------------+-----------+
```

---
```sql
SELECT * FROM Competition;
```
Output:
```
+----+---------------+---------------------+------------+----------+
| id | comptype      | location            | compdate   | agelimit |
+----+---------------+---------------------+------------+----------+
|  1 | International | 24 Patricia Terrace | 2021-11-22 |       18 |
|  2 | National      | 24 Patricia Terrace | 2022-09-15 |       30 |
|  3 | Regional      | 17 Lake Street      | 2022-06-01 |       25 |
|  4 | Local         | 4 Pine Avenue       | 2022-02-13 |       21 |
+----+---------------+---------------------+------------+----------+
```

---
```sql
SELECT * FROM Participation;
```
Output:
```
+----+-------------+-----------+--------+-------+
| id | competition | sportsman | result | place |
+----+-------------+-----------+--------+-------+
|  1 |           1 |         1 |    300 |     1 |
|  2 |           1 |         2 |    100 |  NULL |
|  3 |           1 |         3 |    270 |     2 |
|  4 |           1 |         4 |     50 |    10 |
|  5 |           2 |         5 |    200 |     2 |
|  6 |           2 |         6 |    330 |     1 |
|  7 |           2 |         7 |    100 |     3 |
|  8 |           3 |         8 |    150 |     2 |
|  9 |           3 |         9 |    200 |     1 |
| 10 |           4 |        10 |     70 |  NULL |
+----+-------------+-----------+--------+-------+
```

### Examples of using simple commands
*Topics*: 
ALTER TABLE, ADD/DROP CONSTRAINT, UPDATE, DELETE, DISTINCT, WHERE, IN, BETWEEN, LIKE, REGEXP.

* **Adding a table column**
```sql
ALTER TABLE Competition ADD starttime DATETIME;
SELECT * FROM Competition;
```
Output:
```
+----+---------------+---------------------+------------+----------+-----------+
| id | comptype      | location            | compdate   | agelimit | starttime |
+----+---------------+---------------------+------------+----------+-----------+
|  1 | International | 24 Patricia Terrace | 2021-11-22 |       18 | NULL      |
|  2 | National      | 24 Patricia Terrace | 2022-09-15 |       30 | NULL      |
|  3 | Regional      | 17 Lake Street      | 2022-06-01 |       25 | NULL      |
|  4 | Local         | 4 Pine Avenue       | 2022-02-13 |       21 | NULL      |
+----+---------------+---------------------+------------+----------+-----------+
```
---
```sql
DESCRIBE Competition;
```
Output:
```
+-----------+-------------+------+-----+---------+----------------+
| Field     | Type        | Null | Key | Default | Extra          |
+-----------+-------------+------+-----+---------+----------------+
| id        | int         | NO   | PRI | NULL    | auto_increment |
| comptype  | varchar(40) | YES  |     | NULL    |                |
| location  | varchar(40) | YES  |     | NULL    |                |
| compdate  | date        | YES  |     | NULL    |                |
| agelimit  | int         | YES  |     | NULL    |                |
| starttime | datetime    | YES  |     | NULL    |                |
+-----------+-------------+------+-----+---------+----------------+
```

* **Changing the type of a table column**
```sql
ALTER TABLE Competition MODIFY COLUMN starttime TIME;
SELECT * FROM Competition;
```
Output:
```
+----+---------------+---------------------+------------+----------+-----------+
| id | comptype      | location            | compdate   | agelimit | starttime |
+----+---------------+---------------------+------------+----------+-----------+
|  1 | International | 24 Patricia Terrace | 2021-11-22 |       18 | NULL      |
|  2 | National      | 24 Patricia Terrace | 2022-09-15 |       30 | NULL      |
|  3 | Regional      | 17 Lake Street      | 2022-06-01 |       25 | NULL      |
|  4 | Local         | 4 Pine Avenue       | 2022-02-13 |       21 | NULL      |
+----+---------------+---------------------+------------+----------+-----------+
```

```sql
DESCRIBE Competition;
```
Output:
```
+-----------+-------------+------+-----+---------+----------------+
| Field     | Type        | Null | Key | Default | Extra          |
+-----------+-------------+------+-----+---------+----------------+
| id        | int         | NO   | PRI | NULL    | auto_increment |
| comptype  | varchar(40) | YES  |     | NULL    |                |
| location  | varchar(40) | YES  |     | NULL    |                |
| compdate  | date        | YES  |     | NULL    |                |
| agelimit  | int         | YES  |     | NULL    |                |
| starttime | time        | YES  |     | NULL    |                |
+-----------+-------------+------+-----+---------+----------------+
```


* **Deleting a table column, adding constraints to the table**
```sql=
ALTER TABLE Competition DROP COLUMN starttime;
ALTER TABLE Competition 
ADD CONSTRAINT chk_agelimit CHECK(agelimit > 0 AND agelimit < 100);
INSERT INTO Competition (comptype, location, compdate, agelimit) 
VALUES ('International', '11 Laura Street', '2021-10-30', 180);
```
Output:
```
ERROR 3819 (HY000): Check constraint 'chk_agelimit' is violated.
```

As expected, we get an error because the age of 180 is beyond an allowed range (0 < agelimit < 100). 

* **Removing restrictions for a table.**

```sql
ALTER TABLE Competition DROP CONSTRAINT chk_agelimit;
INSERT INTO Competition (comptype, location, compdate, agelimit) 
VALUES ('International', '11 Laura Street', '2021-10-30', 180);
SELECT * FROM Competition;
```
Output:
```
+----+---------------+---------------------+------------+----------+
| id | comptype      | location            | compdate   | agelimit |
+----+---------------+---------------------+------------+----------+
|  1 | International | 24 Patricia Terrace | 2021-11-22 |       18 |
|  2 | National      | 24 Patricia Terrace | 2022-09-15 |       30 |
|  3 | Regional      | 17 Lake Street      | 2022-06-01 |       25 |
|  4 | Local         | 4 Pine Avenue       | 2022-02-13 |       21 |
|  5 | International | 11 Laura Street     | 2021-10-30 |      180 |
+----+---------------+---------------------+------------+----------+
```

* **Changing `agelimit`**

```sql
UPDATE Competition SET agelimit = 18 WHERE agelimit > 100;
SELECT * FROM Competition;
```
Output:
```
+----+---------------+---------------------+------------+----------+
| id | comptype      | location            | compdate   | agelimit |
+----+---------------+---------------------+------------+----------+
|  1 | International | 24 Patricia Terrace | 2021-11-22 |       18 |
|  2 | National      | 24 Patricia Terrace | 2022-09-15 |       30 |
|  3 | Regional      | 17 Lake Street      | 2022-06-01 |       25 |
|  4 | Local         | 4 Pine Avenue       | 2022-02-13 |       21 |
|  5 | International | 11 Laura Street     | 2021-10-30 |       18 |
+----+---------------+---------------------+------------+----------+
```

* **Raising every sportsman's scholarship** 
```sql
UPDATE Sportsmen SET scholarship = scholarship + 500;
SELECT * FROM Sportsmen;
```
Output:
```
+----+-------------------------+------------+--------+----------+---------+------+-------------+----------------------+---------------+-----------+
| id | flName                  | birthDate  | sex    | category | trainer | rate | scholarship | address              | mobile        | homephone |
+----+-------------------------+------------+--------+----------+---------+------+-------------+----------------------+---------------+-----------+
|  1 | Dominick Tom Jameson    | 1996-10-22 | m      | D        |       1 | 1700 |        2000 | 3125 Kessla Way      | +380661558796 | 7485139   |
|  2 | Steven Jack Ball        | 1997-05-13 | m      | C        |       2 | 1900 |        2100 | 68878 Fadel Route    | +380957892548 | 7190077   |
|  3 | Ross Max Booth          | 1998-03-02 | m      | E        |       5 | 1500 |         500 | 992 Lempi Creek      | NULL          | NULL      |
|  4 | Richard Frank Jones     | 1989-01-07 | m      | D        |       4 | 1600 |         500 | 33 Crestview Road    | +380509801433 | 7095240   |
|  5 | Kathleen Anne Hamilton  | 1999-05-29 | f      | E        |       6 | 1550 |        1900 | 31 Holly Road        | +380675207119 | NULL      |
|  6 | Susan Jane Morris       | 2000-10-31 | m      | D        |       6 | 1650 |        2300 | 28 Settlement Avenue | NULL          | 7196483   |
|  7 | Kimberly Maria Perez    | 1998-09-07 | f      | C        |       3 | 1800 |        2400 | 32 Willamette Avenue | +380507890049 | 7198825   |
|  8 | Melissa Kira Pittman    | 1994-03-13 | f      | C        |       2 | 1900 |        1950 | 17 Claremont Avenue  | +380665430876 | NULL      |
|  9 | Richard Thomas Anderson | 1996-11-28 | m      | C        |       3 | 1999 |        2500 | 21 Croix Trail       | +380958763144 | NULL      |
| 10 | Samantha Beth Hamilton  | 1997-10-07 | f      | D        |       1 | 1690 |        2400 | 6 Huntington Drive   | +380665974439 | 7775412   |
| 11 | Vincent Justin Maxwell  | 1996-07-19 | m      | E        |       4 | 1550 |         500 | 19 Marthas Lane      | +380677885109 | NULL      |
| 12 | Rebecca Laurel Williams | 2001-09-09 | f      | E        |       2 | 1520 |         500 | 16 Peace Way         | +380997859920 | 7198923   |
| 13 | Alexis Tara Larsen      | 1990-04-26 | f      | B        |       4 | 2000 |        3100 | 21 Huntington Drive  | +380665478810 | 7145409   |
| 14 | David Michael Harrison  | 1999-08-02 | m      | E        |       2 | 1430 |        1650 | 16 Crestview Road    | NULL          | NULL      |
+----+-------------------------+------------+--------+----------+---------+------+-------------+----------------------+---------------+-----------+
```

* **Deleting every row, where `result` is lower then `200`**
Before:
```sql
SELECT * FROM Participation;
```
Output:
```
+----+-------------+-----------+--------+-------+
| id | competition | sportsman | result | place |
+----+-------------+-----------+--------+-------+
|  1 |           1 |         1 |    300 |     1 |
|  2 |           1 |         2 |    100 |  NULL |
|  3 |           1 |         3 |    270 |     2 |
|  4 |           1 |         4 |     50 |    10 |
|  5 |           2 |         5 |    200 |     2 |
|  6 |           2 |         6 |    330 |     1 |
|  7 |           2 |         7 |    100 |     3 |
|  8 |           3 |         8 |    150 |     2 |
|  9 |           3 |         9 |    200 |     1 |
| 10 |           4 |        10 |     70 |  NULL |
+----+-------------+-----------+--------+-------+
```
After:
```sql
DELETE FROM Participation WHERE result < 200;
SELECT * FROM Participation;
```
Output:
```
+----+-------------+-----------+--------+-------+
| id | competition | sportsman | result | place |
+----+-------------+-----------+--------+-------+
|  1 |           1 |         1 |    300 |     1 |
|  3 |           1 |         3 |    270 |     2 |
|  5 |           2 |         5 |    200 |     2 |
|  6 |           2 |         6 |    330 |     1 |
|  9 |           3 |         9 |    200 |     1 |
+----+-------------+-----------+--------+-------+
```

* **Selecting unique categories from the Trainers table**

```sql
SELECT DISTINCT category FROM Trainers;
```
Output:
```
+----------+
| category |
+----------+
| B        |
| A        |
+----------+
```

* **Selecting a Competition where the age limit is either `18` or `30`** 

```sql
SELECT * FROM Competition 
WHERE agelimit IN (18, 30);
```
Output:
```
+----+---------------+---------------------+------------+----------+
| id | comptype      | location            | compdate   | agelimit |
+----+---------------+---------------------+------------+----------+
|  1 | International | 24 Patricia Terrace | 2021-11-22 |       18 |
|  2 | National      | 24 Patricia Terrace | 2022-09-15 |       30 |
+----+---------------+---------------------+------------+----------+
```

* **Selecting Sportsmen whose category is not `'D'` and not `'E'`** 

```sql
SELECT * FROM Sportsmen 
WHERE category NOT IN ('D', 'E');
```
Output:
```
+----+-------------------------+------------+-----+----------+---------+------+-------------+----------------------+---------------+-----------+
| id | flName                  | birthDate  | sex | category | trainer | rate | scholarship | address              | mobile        | homephone |
+----+-------------------------+------------+-----+----------+---------+------+-------------+----------------------+---------------+-----------+
|  2 | Steven Jack Ball        | 1997-05-13 | m   | C        |       2 | 1900 |        1600 | 68878 Fadel Route    | +380957892548 | 7190077   |
|  7 | Kimberly Maria Perez    | 1998-09-07 | f   | C        |       3 | 1800 |        1900 | 32 Willamette Avenue | +380507890049 | 7198825   |
|  8 | Melissa Kira Pittman    | 1994-03-13 | f   | C        |       2 | 1900 |        1450 | 17 Claremont Avenue  | +380665430876 | NULL      |
|  9 | Richard Thomas Anderson | 1996-11-28 | m   | C        |       3 | 1999 |        2000 | 21 Croix Trail       | +380958763144 | NULL      |
| 13 | Alexis Tara Larsen      | 1990-04-26 | f   | B        |       4 | 2000 |        2600 | 21 Huntington Drive  | +380665478810 | 7145409   |
+----+-------------------------+------------+-----+----------+---------+------+-------------+----------------------+---------------+-----------+
```

* **Selecting Trainers whose rate is between `2100` and `2370`** 

```sql
SELECT * FROM Trainers 
WHERE rate BETWEEN 2100 AND 2370;
```
Output:
```
+----+-------------------+----------+------+
| id | flName            | category | rate |
+----+-------------------+----------+------+
|  1 | Violet Elle Woods | B        | 2100 |
|  2 | Max Dean Bailey   | A        | 2300 |
|  3 | Lola Jane Keith   | A        | 2350 |
+----+-------------------+----------+------+
```

* **Selecting Sportsmen whose mobile phone number starts with `'+38095'`** 

```sql
SELECT * FROM Sportsmen 
WHERE mobile LIKE '+38095%';
```
Output:
```
+----+-------------------------+------------+-----+----------+---------+------+-------------+-------------------+---------------+-----------+
| id | flName                  | birthDate  | sex | category | trainer | rate | scholarship | address           | mobile        | homephone |
+----+-------------------------+------------+-----+----------+---------+------+-------------+-------------------+---------------+-----------+
|  2 | Steven Jack Ball        | 1997-05-13 | m   | C        |       2 | 1900 |        1600 | 68878 Fadel Route | +380957892548 | 7190077   |
|  9 | Richard Thomas Anderson | 1996-11-28 | m   | C        |       3 | 1999 |        2000 | 21 Croix Trail    | +380958763144 | NULL      |
+----+-------------------------+------------+-----+----------+---------+------+-------------+-------------------+---------------+-----------+
```

* **Selecting Competitions where the age limit is between 20 and 29** 

```sql
SELECT * FROM Competition 
WHERE agelimit LIKE '2_';
```
Output:
```
+----+----------+----------------+------------+----------+
| id | comptype | location       | compdate   | agelimit |
+----+----------+----------------+------------+----------+
|  3 | Regional | 17 Lake Street | 2022-06-01 |       25 |
|  4 | Local    | 4 Pine Avenue  | 2022-02-13 |       21 |
+----+----------+----------------+------------+----------+
```

* **Selecting Sportsmen who were born in the `5th` month (May).** 

```sql
SELECT * FROM Sportsmen
WHERE birthDate LIKE '%-05-%';    
```
Output:
```
+----+------------------------+------------+-----+----------+---------+------+-------------+-------------------+---------------+-----------+
| id | flName                 | birthDate  | sex | category | trainer | rate | scholarship | address           | mobile        | homephone |
+----+------------------------+------------+-----+----------+---------+------+-------------+-------------------+---------------+-----------+
|  2 | Steven Jack Ball       | 1997-05-13 | m   | C        |       2 | 1900 |        2100 | 68878 Fadel Route | +380957892548 | 7190077   |
|  5 | Kathleen Anne Hamilton | 1999-05-29 | f   | E        |       6 | 1550 |        1900 | 31 Holly Road     | +380675207119 | NULL      |
+----+------------------------+------------+-----+----------+---------+------+-------------+-------------------+---------------+-----------+
```

* **Selecting Athletes who were born in the 5th month between the 20th and 29th** 

```sql
SELECT * FROM Sportsmen 
WHERE birthDate LIKE '%-05-2_';
```
Output:
```
+----+------------------------+------------+-----+----------+---------+------+-------------+---------------+---------------+-----------+
| id | flName                 | birthDate  | sex | category | trainer | rate | scholarship | address       | mobile        | homephone |
+----+------------------------+------------+-----+----------+---------+------+-------------+---------------+---------------+-----------+
|  5 | Kathleen Anne Hamilton | 1999-05-29 | f   | E        |       6 | 1550 |        1900 | 31 Holly Road | +380675207119 | NULL      |
+----+------------------------+------------+-----+----------+---------+------+-------------+---------------+---------------+-----------+
```

* **Selecting Sportsmen with the last name `'Hamilton'`**

```sql
SELECT * FROM Sportsmen 
WHERE flName REGEXP 'Hamilton$';
```
Output:
```
+----+------------------------+------------+-----+----------+---------+------+-------------+--------------------+---------------+-----------+
| id | flName                 | birthDate  | sex | category | trainer | rate | scholarship | address            | mobile        | homephone |
+----+------------------------+------------+-----+----------+---------+------+-------------+--------------------+---------------+-----------+
|  5 | Kathleen Anne Hamilton | 1999-05-29 | f   | E        |       6 | 1550 |        1900 | 31 Holly Road      | +380675207119 | NULL      |
| 10 | Samantha Beth Hamilton | 1997-10-07 | f   | D        |       1 | 1690 |        2400 | 6 Huntington Drive | +380665974439 | 7775412   |
+----+------------------------+------------+-----+----------+---------+------+-------------+--------------------+---------------+-----------+
```

* **Selecting Sportsmen whose year of birth begins with 19 (i.e. 1900-1999)** 

```sql
SELECT * FROM Sportsmen 
WHERE birthDate REGEXP '^19';
```
Output:
```
+----+-------------------------+------------+-----+----------+---------+------+-------------+----------------------+---------------+-----------+
| id | flName                  | birthDate  | sex | category | trainer | rate | scholarship | address              | mobile        | homephone |
+----+-------------------------+------------+-----+----------+---------+------+-------------+----------------------+---------------+-----------+
|  1 | Dominick Tom Jameson    | 1996-10-22 | m   | D        |       1 | 1700 |        2000 | 3125 Kessla Way      | +380661558796 | 7485139   |
|  2 | Steven Jack Ball        | 1997-05-13 | m   | C        |       2 | 1900 |        2100 | 68878 Fadel Route    | +380957892548 | 7190077   |
|  3 | Ross Max Booth          | 1998-03-02 | m   | E        |       5 | 1500 |         500 | 992 Lempi Creek      | NULL          | NULL      |
|  4 | Richard Frank Jones     | 1989-01-07 | m   | D        |       4 | 1600 |         500 | 33 Crestview Road    | +380509801433 | 7095240   |
|  5 | Kathleen Anne Hamilton  | 1999-05-29 | f   | E        |       6 | 1550 |        1900 | 31 Holly Road        | +380675207119 | NULL      |
|  7 | Kimberly Maria Perez    | 1998-09-07 | f   | C        |       3 | 1800 |        2400 | 32 Willamette Avenue | +380507890049 | 7198825   |
|  8 | Melissa Kira Pittman    | 1994-03-13 | f   | C        |       2 | 1900 |        1950 | 17 Claremont Avenue  | +380665430876 | NULL      |
|  9 | Richard Thomas Anderson | 1996-11-28 | m   | C        |       3 | 1999 |        2500 | 21 Croix Trail       | +380958763144 | NULL      |
| 10 | Samantha Beth Hamilton  | 1997-10-07 | f   | D        |       1 | 1690 |        2400 | 6 Huntington Drive   | +380665974439 | 7775412   |
| 11 | Vincent Justin Maxwell  | 1996-07-19 | m   | E        |       4 | 1550 |         500 | 19 Marthas Lane      | +380677885109 | NULL      |
| 13 | Alexis Tara Larsen      | 1990-04-26 | f   | B        |       4 | 2000 |        3100 | 21 Huntington Drive  | +380665478810 | 7145409   |
| 14 | David Michael Harrison  | 1999-08-02 | m   | E        |       2 | 1430 |        1650 | 16 Crestview Road    | NULL          | NULL      |
+----+-------------------------+------------+-----+----------+---------+------+-------------+----------------------+---------------+-----------+
12 rows in set (0.00 sec)
```

* **Selecting Sportsmen whose year of birth starts with `19` and the day ends with `2`**

```sql
SELECT * FROM Sportsmen 
WHERE birthDate REGEXP '^19.{7}2$';
```
Output:
```
+----+------------------------+------------+-----+----------+---------+------+-------------+-------------------+---------------+-----------+
| id | flName                 | birthDate  | sex | category | trainer | rate | scholarship | address           | mobile        | homephone |
+----+------------------------+------------+-----+----------+---------+------+-------------+-------------------+---------------+-----------+
|  1 | Dominick Tom Jameson   | 1996-10-22 | m   | D        |       1 | 1700 |        2000 | 3125 Kessla Way   | +380661558796 | 7485139   |
|  3 | Ross Max Booth         | 1998-03-02 | m   | E        |       5 | 1500 |         500 | 992 Lempi Creek   | NULL          | NULL      |
| 14 | David Michael Harrison | 1999-08-02 | m   | E        |       2 | 1430 |        1650 | 16 Crestview Road | NULL          | NULL      |
+----+------------------------+------------+-----+----------+---------+------+-------------+-------------------+---------------+-----------+
```

* **Selecting Trainers whose four-digit `rate` is between `2200` and `2490`**

```sql
SELECT * FROM Trainers 
WHERE rate REGEXP '^2[2-4].0$';
```
Output:
```
+----+-----------------+----------+------+
| id | flName          | category | rate |
+----+-----------------+----------+------+
|  2 | Max Dean Bailey | A        | 2300 |
|  3 | Lola Jane Keith | A        | 2350 |
+----+-----------------+----------+------+
```

* **Selecting Competitions, which are located on 24 Patricia Terrace and 17 Lake Street**

```sql
SELECT * FROM Competition 
WHERE location REGEXP '24 Patricia Terrace|17 Lake Street';	
```
Output:
```
+----+---------------+---------------------+------------+----------+
| id | comptype      | location            | compdate   | agelimit |
+----+---------------+---------------------+------------+----------+
|  1 | International | 24 Patricia Terrace | 2021-11-22 |       18 |
|  2 | National      | 24 Patricia Terrace | 2022-09-15 |       30 |
|  3 | Regional      | 17 Lake Street      | 2022-06-01 |       25 |
+----+---------------+---------------------+------------+----------+
```

### Using aggregate functions (AVG, SUM, MIN, MAX, COUNT)

* **AVG**

```sql
SELECT AVG(scholarship) AS Average_scholarship 
FROM Sportsmen
WHERE rate > 1800;
```
Output:
```
+---------------------+
| Average_scholarship |
+---------------------+
|           2412.5000 |
+---------------------+
```

* **SUM**

```sql
SELECT SUM(scholarship) FROM Sportsmen;
```
Output:
```
+------------------+
| SUM(scholarship) |
+------------------+
|            24300 |
+------------------+
```

* **MIN and MAX**

```sql
SELECT MIN(rate), MAX(rate) FROM Trainers;
```
Output:
```
+-----------+-----------+
| MIN(rate) | MAX(rate) |
+-----------+-----------+
|      2000 |      2399 |
+-----------+-----------+
```

* **COUNT**

```sql
SELECT COUNT(*) AS numberOfSportsmen 
FROM Sportsmen;
```
Output:
```
+-------------------+
| numberOfSportsmen |
+-------------------+
|                14 |
+-------------------+
```

---

```sql
SELECT COUNT(mobile) FROM Sportsmen;
```
Output:
```
+---------------+
| COUNT(mobile) |
+---------------+
|            11 |
+---------------+
```

### Using operators (GROUP BY, HAVING, EXISTS)

* **GROUP BY**

Selecting rates above 1700 and the number of people with them and sort them in descending order.

```sql
SELECT rate, COUNT(*) AS highRateCount
FROM Sportsmen
WHERE rate > 1700
GROUP BY rate
ORDER BY rate DESC;
```
Output:
```
+------+---------------+
| rate | highRateCount |
+------+---------------+
| 2000 |             1 |
| 1999 |             1 |
| 1900 |             2 |
| 1800 |             1 |
+------+---------------+
```

* **HAVING**

Choosing ratings where the number of people with them is more than 1 and they receive a scholarship above 1500.

```sql
SELECT rate, COUNT(*) AS highRateCount
FROM Sportsmen
WHERE scholarship > 1500
GROUP BY rate
HAVING COUNT(*) > 1;
```
Output:
```
+------+---------------+
| rate | highRateCount |
+------+---------------+
| 1900 |             2 |
+------+---------------+
```

* **EXISTS**

Choosing Sportsmen whose rating is equal to the rating of (any) Trainer.

```sql
SELECT * FROM Sportsmen
WHERE EXISTS
(SELECT * FROM Trainers 
 WHERE Sportsmen.rate = Trainers.rate);
```

```
+----+--------------------+------------+-----+----------+---------+------+-------------+---------------------+---------------+-----------+
| id | flName             | birthDate  | sex | category | trainer | rate | scholarship | address             | mobile        | homephone |
+----+--------------------+------------+-----+----------+---------+------+-------------+---------------------+---------------+-----------+
| 13 | Alexis Tara Larsen | 1990-04-26 | f   | B        |       4 | 2000 |        4030 | 21 Huntington Drive | +380665478810 | 7145409   |
+----+--------------------+------------+-----+----------+---------+------+-------------+---------------------+---------------+-----------+
```
### Using a correlated subquery

* **Displaying the full name of the Sportsman and the full name of their Trainer**

```sql
SELECT id, flName,
    (SELECT flName FROM Trainers
     WHERE Trainers.id = Sportsmen.trainer) AS Trainer
FROM Sportsmen;
```
Output:
```
+----+-------------------------+------------------------+
| id | flName                  | Trainer                |
+----+-------------------------+------------------------+
|  1 | Dominick Tom Jameson    | Violet Elle Woods      |
|  2 | Steven Jack Ball        | Max Dean Bailey        |
|  3 | Ross Max Booth          | Lena Kiana Maddox      |
|  4 | Richard Frank Jones     | Savannah Marie Mathews |
|  5 | Kathleen Anne Hamilton  | Luke James Hooper      |
|  6 | Susan Jane Morris       | Luke James Hooper      |
|  7 | Kimberly Maria Perez    | Lola Jane Keith        |
|  8 | Melissa Kira Pittman    | Max Dean Bailey        |
|  9 | Richard Thomas Anderson | Lola Jane Keith        |
| 10 | Samantha Beth Hamilton  | Violet Elle Woods      |
| 11 | Vincent Justin Maxwell  | Savannah Marie Mathews |
| 12 | Rebecca Lauren Williams | Max Dean Bailey        |
| 13 | Alexis Tara Larsen      | Savannah Marie Mathews |
| 14 | David Michael Harrison  | Max Dean Bailey        |
+----+-------------------------+------------------------+
```

* **Deriving the number of Sportsmen trained by each Coach**

```sql
SELECT t.id, t.flName,
    (SELECT COUNT(*) FROM Sportsmen s1
     WHERE s1.trainer = t.id) AS numberOfSportsmen
FROM Trainers t;
```
Output:
```
+------+------------------------+-------------------+
| id   | flName                 | numberOfSportsmen |
+------+------------------------+-------------------+
|    1 | Violet Elle Woods      |                 2 |
|    2 | Max Dean Bailey        |                 4 |
|    3 | Lola Jane Keith        |                 2 |
|    4 | Savannah Marie Mathews |                 3 |
|    5 | Lena Kiana Maddox      |                 1 |
|    6 | Luke James Hooper      |                 2 |
+------+------------------------+-------------------+
```

### Using a non-correlated subquery

* **Displaying the full name of the Trainers with a rating above the average**

```sql
SELECT * FROM Trainers
WHERE rate > (SELECT AVG(rate) FROM Trainers);
```
Output:
```
+----+------------------------+----------+------+
| id | flName                 | category | rate |
+----+------------------------+----------+------+
|  2 | Max Dean Bailey        | A        | 2300 |
|  3 | Lola Jane Keith        | A        | 2350 |
|  4 | Savannah Marie Mathews | A        | 2399 |
+----+------------------------+----------+------+
```

### Using subqueries in such commands as INSERT, UPDATE, DELETE 

* **Subquery in `INSERT` command**

```sql
INSERT INTO Sportsmen (flName, birthDate, sex, trainer, address) 
VALUE ('Jackson Evan Smith', '1987-09-01', 'm', 
       (SELECT id 
        FROM Trainers WHERE flName = 'Lena Kiana Maddox'),
       '7 Main Street');
SELECT * FROM Sportsmen;
```
Output:
```
+----+-------------------------+------------+-----+----------+---------+------+-------------+----------------------+---------------+-----------+
| id | flName                  | birthDate  | sex | category | trainer | rate | scholarship | address              | mobile        | homephone |
+----+-------------------------+------------+-----+----------+---------+------+-------------+----------------------+---------------+-----------+
|  1 | Dominick Tom Jameson    | 1996-10-22 | m   | D        |       1 | 1700 |        2000 | 3125 Kessla Way      | +380661558796 | 7485139   |
|  2 | Steven Jack Ball        | 1997-05-13 | m   | C        |       2 | 1900 |        2100 | 68878 Fadel Route    | +380957892548 | 7190077   |
|  3 | Ross Max Booth          | 1998-03-02 | m   | E        |       5 | 1500 |         500 | 992 Lempi Creek      | NULL          | NULL      |
|  4 | Richard Frank Jones     | 1989-01-07 | m   | D        |       4 | 1600 |         500 | 33 Crestview Road    | +380509801433 | 7095240   |
|  5 | Kathleen Anne Hamilton  | 1999-05-29 | f   | E        |       6 | 1550 |        1900 | 31 Holly Road        | +380675207119 | NULL      |
|  6 | Susan Jane Morris       | 2000-10-31 | m   | D        |       6 | 1650 |        2300 | 28 Settlement Avenue | NULL          | 7196483   |
|  7 | Kimberly Maria Perez    | 1998-09-07 | f   | C        |       3 | 1800 |        2400 | 32 Willamette Avenue | +380507890049 | 7198825   |
|  8 | Melissa Kira Pittman    | 1994-03-13 | f   | C        |       2 | 1900 |        1950 | 17 Claremont Avenue  | +380665430876 | NULL      |
|  9 | Richard Thomas Anderson | 1996-11-28 | m   | C        |       3 | 1999 |        2500 | 21 Croix Trail       | +380958763144 | NULL      |
| 10 | Samantha Beth Hamilton  | 1997-10-07 | f   | D        |       1 | 1690 |        2400 | 6 Huntington Drive   | +380665974439 | 7775412   |
| 11 | Vincent Justin Maxwell  | 1996-07-19 | m   | E        |       4 | 1550 |         500 | 19 Marthas Lane      | +380677885109 | NULL      |
| 12 | Rebecca Lauren Williams | 2001-09-09 | f   | E        |       2 | 1520 |         500 | 16 Peace Way         | +380997859920 | 7198923   |
| 13 | Alexis Tara Larsen      | 1990-04-26 | f   | B        |       4 | 2000 |        3100 | 21 Huntington Drive  | +380665478810 | 7145409   |
| 14 | David Michael Harrison  | 1999-08-02 | m   | E        |       2 | 1430 |        1650 | 16 Crestview Road    | NULL          | NULL      |
| 15 | Jackson Evan Smith      | 1987-09-01 | m   | NULL     |       5 | NULL |           0 | 7 Main Street        | NULL          | NULL      |
+----+-------------------------+------------+-----+----------+---------+------+-------------+----------------------+---------------+-----------+
```

* **Subquery in `UPDATE` command**

Increasing the `scholarship` by 30% for each Sportsman whose Trainer has a rating above 2200.

```sql
UPDATE Sportsmen
SET scholarship = scholarship * 1.3
WHERE trainer IN (SELECT id 
                  FROM Trainers 
                  WHERE rate > 2200);
```
Output:
```
Query OK, 9 rows affected (0.02 sec)
Rows matched: 9  Changed: 9  Warnings: 0
```

```sql
SELECT id, flName, trainer, scholarship, rate 
FROM Sportsmen;
```

```
+----+-------------------------+---------+-------------+------+
| id | flName                  | trainer | scholarship | rate |
+----+-------------------------+---------+-------------+------+
|  1 | Dominick Tom Jameson    |       1 |        2000 | 1700 |
|  2 | Steven Jack Ball        |       2 |        2730 | 1900 |
|  3 | Ross Max Booth          |       5 |         500 | 1500 |
|  4 | Richard Frank Jones     |       4 |         650 | 1600 |
|  5 | Kathleen Anne Hamilton  |       6 |        1900 | 1550 |
|  6 | Susan Jane Morris       |       6 |        2300 | 1650 |
|  7 | Kimberly Maria Perez    |       3 |        3120 | 1800 |
|  8 | Melissa Kira Pittman    |       2 |        2535 | 1900 |
|  9 | Richard Thomas Anderson |       3 |        3250 | 1999 |
| 10 | Samantha Beth Hamilton  |       1 |        2400 | 1690 |
| 11 | Vincent Justin Maxwell  |       4 |         650 | 1550 |
| 12 | Rebecca Lauren Williams |       2 |         650 | 1520 |
| 13 | Alexis Tara Larsen      |       4 |        4030 | 2000 |
| 14 | David Michael Harrison  |       2 |        2145 | 1430 |
| 15 | Jackson Evan Smith      |       5 |           0 | NULL |
+----+-------------------------+---------+-------------+------+
```

* **Subquery in `DELETE` command**

Deleting Participation in a contest of a Sportsman whose Trainer has an id = 5. 

At first, let's take a look at the original Participation table:

```sql
SELECT * FROM Participation;
```
Output:
```
+----+-------------+-----------+--------+-------+
| id | competition | sportsman | result | place |
+----+-------------+-----------+--------+-------+
|  1 |           1 |         1 |    300 |     1 |
|  3 |           1 |         3 |    270 |     2 |
|  5 |           2 |         5 |    200 |     2 |
|  6 |           2 |         6 |    330 |     1 |
|  9 |           3 |         9 |    200 |     1 |
+----+-------------+-----------+--------+-------+
```

Now, let's do the deed:

```sql
DELETE FROM Participation
WHERE sportsman IN (SELECT id 
                   FROM Sportsmen
                   WHERE trainer = 5);
```
Output:
```
Query OK, 1 row affected (0.01 sec)
```
Let's take a look at the result
```sql
SELECT * FROM Participation;
```
Output:
```
+----+-------------+-----------+--------+-------+
| id | competition | sportsman | result | place |
+----+-------------+-----------+--------+-------+
|  1 |           1 |         1 |    300 |     1 |
|  5 |           2 |         5 |    200 |     2 |
|  6 |           2 |         6 |    330 |     1 |
|  9 |           3 |         9 |    200 |     1 |
+----+-------------+-----------+--------+-------+
4 rows in set (0.00 sec)
```

As we can see, the Sportsman with an id = 3 is now eliminated. 

### Joining tables in queries (implicit join,  INNER JOIN, LEFT(RIGHT) OUTER JOIN)

* **Implicit join**

Joining *two* tables. 

```sql
SELECT s.id, s.flName, s.rate, 
       t.flName AS TrainersName,
       t.rate AS TrainersRate
FROM Sportsmen AS s, 
     Trainers AS t
WHERE s.trainer = t.id
ORDER BY s.id;
```
Output:
```
+----+-------------------------+------+------------------------+--------------+
| id | flName                  | rate | TrainersName           | TrainersRate |
+----+-------------------------+------+------------------------+--------------+
|  1 | Dominick Tom Jameson    | 1700 | Violet Elle Woods      |         2100 |
|  2 | Steven Jack Ball        | 1900 | Max Dean Bailey        |         2300 |
|  3 | Ross Max Booth          | 1500 | Lena Kiana Maddox      |         2050 |
|  4 | Richard Frank Jones     | 1600 | Savannah Marie Mathews |         2399 |
|  5 | Kathleen Anne Hamilton  | 1550 | Luke James Hooper      |         2000 |
|  6 | Susan Jane Morris       | 1650 | Luke James Hooper      |         2000 |
|  7 | Kimberly Maria Perez    | 1800 | Lola Jane Keith        |         2350 |
|  8 | Melissa Kira Pittman    | 1900 | Max Dean Bailey        |         2300 |
|  9 | Richard Thomas Anderson | 1999 | Lola Jane Keith        |         2350 |
| 10 | Samantha Beth Hamilton  | 1690 | Violet Elle Woods      |         2100 |
| 11 | Vincent Justin Maxwell  | 1550 | Savannah Marie Mathews |         2399 |
| 12 | Rebecca Lauren Williams | 1520 | Max Dean Bailey        |         2300 |
| 13 | Alexis Tara Larsen      | 2000 | Savannah Marie Mathews |         2399 |
| 14 | David Michael Harrison  | 1430 | Max Dean Bailey        |         2300 |
| 15 | Jackson Evan Smith      | NULL | Lena Kiana Maddox      |         2050 |
+----+-------------------------+------+------------------------+--------------+
```

Joining *three* tables.

```sql
SELECT s.id, s.flName, s.rate, 
       c.comptype AS CompetitionType, 
       c.location AS CompetitionLocation,
       p.result
FROM Sportsmen AS s, 
     Competition AS c, 
     Participation as p
WHERE s.id = p.sportsman AND p.competition = c.id;
```
Output:
```
+----+-------------------------+------+-----------------+---------------------+--------+
| id | flName                  | rate | CompetitionType | CompetitionLocation | result |
+----+-------------------------+------+-----------------+---------------------+--------+
|  1 | Dominick Tom Jameson    | 1700 | International   | 24 Patricia Terrace |    300 |
|  5 | Kathleen Anne Hamilton  | 1550 | National        | 24 Patricia Terrace |    200 |
|  6 | Susan Jane Morris       | 1650 | National        | 24 Patricia Terrace |    330 |
|  9 | Richard Thomas Anderson | 1999 | Regional        | 17 Lake Street      |    200 |
+----+-------------------------+------+-----------------+---------------------+--------+
```

* **INNER JOIN**

Joining *two* tables. 

```sql
SELECT s.id, s.flName, p.result 
FROM Sportsmen AS s
INNER JOIN Participation AS p 
ON p.sportsman = s.id AND p.result > 250;
```
Output:
```
+----+----------------------+--------+
| id | flName               | result |
+----+----------------------+--------+
|  1 | Dominick Tom Jameson |    300 |
|  6 | Susan Jane Morris    |    330 |
+----+----------------------+--------+
```

Joining *three* tables.

```sql=
SELECT Sportsmen.id, 
       Sportsmen.flName, 
       Trainers.flName AS TrainersName,   
       Participation.result 
FROM Sportsmen
INNER JOIN Trainers 
    ON Trainers.id = Sportsmen.trainer
INNER JOIN Participation 
    ON Participation.sportsman = Sportsmen.id;
```
Output:
```
+----+-------------------------+-------------------+--------+
| id | flName                  | TrainersName      | result |
+----+-------------------------+-------------------+--------+
|  1 | Dominick Tom Jameson    | Violet Elle Woods |    300 |
|  5 | Kathleen Anne Hamilton  | Luke James Hooper |    200 |
|  6 | Susan Jane Morris       | Luke James Hooper |    330 |
|  9 | Richard Thomas Anderson | Lola Jane Keith   |    200 |
+----+-------------------------+-------------------+--------+
```

* **LEFT OUTER JOIN**

```sql=
SELECT Sportsmen.id, flName, rate,
       Participation.competition,
       Participation.result 
FROM Sportsmen
LEFT JOIN Participation 
          ON Sportsmen.id = Participation.sportsman;
```
Output:
```
+----+-------------------------+------+-------------+--------+
| id | flName                  | rate | competition | result |
+----+-------------------------+------+-------------+--------+
|  1 | Dominick Tom Jameson    | 1700 |           1 |    300 |
|  2 | Steven Jack Ball        | 1900 |        NULL |   NULL |
|  3 | Ross Max Booth          | 1500 |        NULL |   NULL |
|  4 | Richard Frank Jones     | 1600 |        NULL |   NULL |
|  5 | Kathleen Anne Hamilton  | 1550 |           2 |    200 |
|  6 | Susan Jane Morris       | 1650 |           2 |    330 |
|  7 | Kimberly Maria Perez    | 1800 |        NULL |   NULL |
|  8 | Melissa Kira Pittman    | 1900 |        NULL |   NULL |
|  9 | Richard Thomas Anderson | 1999 |           3 |    200 |
| 10 | Samantha Beth Hamilton  | 1690 |        NULL |   NULL |
| 11 | Vincent Justin Maxwell  | 1550 |        NULL |   NULL |
| 12 | Rebecca Lauren Williams | 1520 |        NULL |   NULL |
| 13 | Alexis Tara Larsen      | 2000 |        NULL |   NULL |
| 14 | David Michael Harrison  | 1430 |        NULL |   NULL |
| 15 | Jackson Evan Smith      | NULL |        NULL |   NULL |
+----+-------------------------+------+-------------+--------+
```

* **RIGHT OUTER JOIN**

```sql=
SELECT Sportsmen.id, flName, rate,
       Participation.competition,
       Participation.result 
FROM Sportsmen
RIGHT JOIN Participation 
           ON Sportsmen.id = Participation.sportsman;
```
Output:
```
+------+-------------------------+------+-------------+--------+
| id   | flName                  | rate | competition | result |
+------+-------------------------+------+-------------+--------+
|    1 | Dominick Tom Jameson    | 1700 |           1 |    300 |
|    5 | Kathleen Anne Hamilton  | 1550 |           2 |    200 |
|    6 | Susan Jane Morris       | 1650 |           2 |    330 |
|    9 | Richard Thomas Anderson | 1999 |           3 |    200 |
+------+-------------------------+------+-------------+--------+
```

### Many-to-many relationship

A many-to-many relationship occurs when multiple records in one table are related to multiple records in another table.

I have many-to-many relationship among tables in my database. This is the Competition table and the Sportsmen table, interconnected with an additional Participation table. 

* Let's display all Participations: full name of the participant and type of competition

```sql
SELECT p.id AS ParticipationId, 
       s.flName AS Sportsman, 
       c.compType AS CompetitionType
FROM Sportsmen AS s, 
     Competition AS c, 
     Participation AS p
WHERE s.id = p.sportsman
  AND p.competition = c.id;
```
Output:
```
+-----------------+-------------------------+-----------------+
| ParticipationId | Sportsman               | CompetitionType |
+-----------------+-------------------------+-----------------+
|               1 | Dominick Tom Jameson    | International   |
|               5 | Kathleen Anne Hamilton  | National        |
|               6 | Susan Jane Morris       | National        |
|               9 | Richard Thomas Anderson | Regional        |
+-----------------+-------------------------+-----------------+
```

* **Let's display all Participations (participant's full name, type of competition, result), where the result is higher than 250.**

```sql
SELECT p.id AS ParticipationId, 
       s.flName AS Sportsman, 
       c.compType AS CompetitionType, 
       p.result
FROM Sportsmen AS s, Competition AS c, Participation AS p
WHERE s.id = p.sportsman 
  AND p.competition = c.id
  AND p.result > 250;
```
Output:
```
+-----------------+----------------------+-----------------+--------+
| ParticipationId | Sportsman            | CompetitionType | result |
+-----------------+----------------------+-----------------+--------+
|               1 | Dominick Tom Jameson | International   |    300 |
|               6 | Susan Jane Morris    | National        |    330 |
+-----------------+----------------------+-----------------+--------+
```

* **Let's display all the Participations (participant's full name, type of competition, result), where the female athletes are in alphabetical order of names.**

```sql
SELECT p.id AS ParticipationId, 
       s.flName AS Sportsman, 
       c.compType AS CompetitionType, 
       p.result
FROM Sportsmen AS s, Competition AS c, Participation AS p
WHERE s.id = p.sportsman
  AND p.competition = c.id
  AND s.sex = 'f'
ORDER BY s.flName;
```
Output:
```
+-----------------+------------------------+-----------------+--------+
| ParticipationId | Sportsman              | CompetitionType | result |
+-----------------+------------------------+-----------------+--------+
|               5 | Kathleen Anne Hamilton | National        |    200 |
|               6 | Susan Jane Morris      | National        |    330 |
+-----------------+------------------------+-----------------+--------+
```

* **Let's display all the Participations (participant's full name, type of competition, result), where the athlete was born in 1996 in alphabetical order of names**

```sql
SELECT p.id AS ParticipationId, 
       s.flName AS Sportsman, 
       c.compType AS CompetitionType, 
       p.result
FROM Sportsmen AS s, Competition AS c, Participation AS p
WHERE s.id = p.sportsman
  AND p.competition = c.id
  AND s.birthdate LIKE '1996-%'
ORDER BY s.flName;
```
Output:
```
+-----------------+-------------------------+-----------------+--------+
| ParticipationId | Sportsman               | CompetitionType | result |
+-----------------+-------------------------+-----------------+--------+
|               1 | Dominick Tom Jameson    | International   |    300 |
|               9 | Richard Thomas Anderson | Regional        |    200 |
+-----------------+-------------------------+-----------------+--------+
```

* **Let's select all Participations (participant's name, competition type, result), where the result is between 200 and 300 in ascending order of the result**

```sql
SELECT p.id AS ParticipationId, 
       s.flName AS Sportsman, 
       t.flName AS Trainer, 
       c.compType AS CompetitionType, 
       p.result
FROM Sportsmen AS s, Competition AS c, Participation AS p, Trainers AS t
WHERE s.id = p.sportsman
  AND p.competition = c.id 
  AND s.trainer = t.id
  AND p.result BETWEEN 200 AND 300
ORDER BY p.result;
```
Output:
```
+-----------------+-------------------------+-------------------+-----------------+--------+
| ParticipationId | Sportsman               | Trainer           | CompetitionType | result |
+-----------------+-------------------------+-------------------+-----------------+--------+
|               5 | Kathleen Anne Hamilton  | Luke James Hooper | National        |    200 |
|               9 | Richard Thomas Anderson | Lola Jane Keith   | Regional        |    200 |
|               3 | Ross Max Booth          | Lena Kiana Maddox | International   |    270 |
|               1 | Dominick Tom Jameson    | Violet Elle Woods | International   |    300 |
+-----------------+-------------------------+-------------------+-----------------+--------+
```

* **Alternative option with INNER JOIN**

```sql
SELECT p.id AS ParticipationId, 
       s.flName AS Sportsman, 
       t.flName AS Trainer, 
       c.compType AS CompetitionType, 
       p.result
FROM Participation AS p
INNER JOIN Competition AS c 
        ON p.competition = c.id 
        AND p.result BETWEEN 200 AND 300
INNER JOIN Sportsmen AS s 
        ON s.id = p.sportsman
INNER JOIN Trainers AS t 
        ON s.trainer = t.id
ORDER BY p.result;
```
Output:
```
+-----------------+-------------------------+-------------------+-----------------+--------+
| ParticipationId | Sportsman               | Trainer           | CompetitionType | result |
+-----------------+-------------------------+-------------------+-----------------+--------+
|               5 | Kathleen Anne Hamilton  | Luke James Hooper | National        |    200 |
|               9 | Richard Thomas Anderson | Lola Jane Keith   | Regional        |    200 |
|               3 | Ross Max Booth          | Lena Kiana Maddox | International   |    270 |
|               1 | Dominick Tom Jameson    | Violet Elle Woods | International   |    300 |
+-----------------+-------------------------+-------------------+-----------------+--------+
```

### Implementation of the external level of database display using VIEW

Let's create a view that includes the names of the athletes from the Sportsmen table, the names of the competitions from the Competition table, and the result from the Participation table.

Let's call the view `v_name_comp`:

```sql
CREATE VIEW v_name_comp (Name, Competition, Result) AS
SELECT Sportsmen.flName, Competition.compType, result
FROM Participation
JOIN Sportsmen ON Sportsmen.id = Participation.sportsman
JOIN Competition ON Competition.id = Participation.competition;
```

Let's take a look at the result:
```sql
SELECT * FROM v_name_comp;
```
Output:
```
+-------------------------+---------------+--------+
| Name                    | Competition   | Result |
+-------------------------+---------------+--------+
| Dominick Tom Jameson    | International |    300 |
| Ross Max Booth          | International |    270 |
| Kathleen Anne Hamilton  | National      |    200 |
| Susan Jane Morris       | National      |    330 |
| Richard Thomas Anderson | Regional      |    200 |
+-------------------------+---------------+--------+
```

Let's show that the view is updatable.

```sql
UPDATE v_name_comp
SET Result = 99
WHERE Result < 299;
```
Output:
```
Query OK, 3 rows affected (0.02 sec)
Rows matched: 3  Changed: 3  Warnings: 0
```

```sql
SELECT * FROM v_name_comp;
```
Output:
```
+-------------------------+---------------+--------+
| Name                    | Competition   | Result |
+-------------------------+---------------+--------+
| Dominick Tom Jameson    | International |    300 |
| Ross Max Booth          | International |     99 |
| Kathleen Anne Hamilton  | National      |     99 |
| Susan Jane Morris       | National      |    330 |
| Richard Thomas Anderson | Regional      |     99 |
+-------------------------+---------------+--------+
```

Let's check if the values in the source table have changed. 

```sql
SELECT Sportsmen.flName, Competition.compType, result
FROM Participation
JOIN Sportsmen ON Sportsmen.id = Participation.sportsman
JOIN Competition ON Competition.id = Participation.competition;
```
Output:
```
+-------------------------+---------------+--------+
| flName                  | compType      | result |
+-------------------------+---------------+--------+
| Dominick Tom Jameson    | International |    300 |
| Ross Max Booth          | International |     99 |
| Kathleen Anne Hamilton  | National      |     99 |
| Susan Jane Morris       | National      |    330 |
| Richard Thomas Anderson | Regional      |     99 |
+-------------------------+---------------+--------+
```

As we can see, in the original table, the results match the results from the v_name_comp view.

Let's check how the query is executed using the EXPLAIN statement.
```sql
EXPLAIN SELECT * FROM v_name_comp;
```
Output:
```
+----+-------------+---------------+------------+--------+-----------------------+---------+---------+--------------------------------------+------+----------+-------------+
| id | select_type | table         | partitions | type   | possible_keys         | key     | key_len | ref                                  | rows | filtered | Extra       |
+----+-------------+---------------+------------+--------+-----------------------+---------+---------+--------------------------------------+------+----------+-------------+
|  1 | SIMPLE      | participation | NULL       | ALL    | sportsman,competition | NULL    | NULL    | NULL                                 |    5 |   100.00 | Using where |
|  1 | SIMPLE      | competition   | NULL       | eq_ref | PRIMARY               | PRIMARY | 4       | sportsclub.participation.competition |    1 |   100.00 | NULL        |
|  1 | SIMPLE      | sportsmen     | NULL       | eq_ref | PRIMARY               | PRIMARY | 4       | sportsclub.participation.sportsman   |    1 |   100.00 | NULL        |
+----+-------------+---------------+------------+--------+-----------------------+---------+---------+--------------------------------------+------+----------+-------------+
```

### Window functions
Per the [PostgresSQL documentation](https://www.postgresql.org/docs/current/tutorial-window.html):

> A window function performs a calculation across a set of table rows that are somehow related to the current row… Behind the scenes, the window function is able to access more than just the current row of the query result

First, let's add some more data to Participation table to see results more clearly. 

```sql
INSERT INTO Participation (competition, sportsman, result, place) VALUES 
	(1, 11, 300, 1),
	(1, 12, 100, NULL),
	(2, 13, 200, 2),
	(2, 14, 330, 1),
	(2, 11, 100, 3),
	(3, 12, 150, 2),
	(3, 13, 200, 1),
	(4, 14, 70, NULL);

SELECT * FROM Participation;
```
Output:
```
+----+-------------+-----------+--------+-------+
| id | competition | sportsman | result | place |
+----+-------------+-----------+--------+-------+
|  1 |           1 |         1 |    300 |     1 |
|  3 |           1 |         3 |     99 |     2 |
|  5 |           2 |         5 |     99 |     2 |
|  6 |           2 |         6 |    330 |     1 |
|  9 |           3 |         9 |     99 |     1 |
| 11 |           1 |        11 |    300 |     1 |
| 12 |           1 |        12 |    100 |  NULL |
| 13 |           2 |        13 |    200 |     2 |
| 14 |           2 |        14 |    330 |     1 |
| 15 |           2 |        11 |    100 |     3 |
| 16 |           3 |        12 |    150 |     2 |
| 17 |           3 |        13 |    200 |     1 |
| 18 |           4 |        14 |     70 |  NULL |
+----+-------------+-----------+--------+-------+
13 rows in set (0.00 sec)
```

* **OVER() with PARTITION BY clause**

Let's select the number of competitions in which each athlete participated.

```sql
SELECT competition, sportsman, result,
    COUNT(competition) OVER(PARTITION BY sportsman) AS 'CompAmount'
FROM Participation;
```
Output:
```
+-------------+-----------+--------+------------+
| competition | sportsman | result | CompAmount |
+-------------+-----------+--------+------------+
|           1 |         1 |    300 |          1 |
|           1 |         3 |     99 |          1 |
|           2 |         5 |     99 |          1 |
|           2 |         6 |    330 |          1 |
|           3 |         9 |     99 |          1 |
|           1 |        11 |    300 |          2 |
|           2 |        11 |    100 |          2 |
|           1 |        12 |    100 |          2 |
|           3 |        12 |    150 |          2 |
|           2 |        13 |    200 |          2 |
|           3 |        13 |    200 |          2 |
|           2 |        14 |    330 |          2 |
|           4 |        14 |     70 |          2 |
+-------------+-----------+--------+------------+
```

Let's display this information in a more visual form, using the `v_name_comp` view that has been created in the previous paragraph.

```sql
SELECT *,
       COUNT(Competition) OVER(PARTITION BY Name) AS 'CompAmount'
FROM v_name_comp;
```
Output:
```
+-------------------------+---------------+--------+------------+
| Name                    | Competition   | Result | CompAmount |
+-------------------------+---------------+--------+------------+
| Alexis Tara Larsen      | National      |    200 |          2 |
| Alexis Tara Larsen      | Regional      |    200 |          2 |
| David Michael Harrison  | National      |    330 |          2 |
| David Michael Harrison  | Local         |     70 |          2 |
| Dominick Tom Jameson    | International |    300 |          1 |
| Kathleen Anne Hamilton  | National      |     99 |          1 |
| Rebecca Lauren Williams | International |    100 |          2 |
| Rebecca Lauren Williams | Regional      |    150 |          2 |
| Richard Thomas Anderson | Regional      |     99 |          1 |
| Ross Max Booth          | International |     99 |          1 |
| Susan Jane Morris       | National      |    330 |          1 |
| Vincent Justin Maxwell  | International |    300 |          2 |
| Vincent Justin Maxwell  | National      |    100 |          2 |
+-------------------------+---------------+--------+------------+
```

* **Aggregate functions**


```sql
SELECT  flName, Competition.compType, result,
	SUM(result) OVER(PARTITION BY flName) AS 'ResultsSum',
	COUNT(Competition.compType) OVER(PARTITION BY sportsman) AS 'CompCount',
	AVG(result) OVER(PARTITION BY compType) AS 'AvgResultInComp',
	MAX(result) OVER(PARTITION BY flName) AS 'MaxResult',
	MIN(result) OVER(PARTITION BY flName) AS 'MinResult'
FROM Participation
JOIN Sportsmen ON Sportsmen.id = Participation.sportsman
JOIN Competition ON Competition.id = Participation.competition
ORDER BY flName;
```
Output:
```
+-------------------------+---------------+--------+------------+-----------+-----------------+-----------+-----------+
| flName                  | compType      | result | ResultsSum | CompCount | AvgResultInComp | MaxResult | MinResult |
+-------------------------+---------------+--------+------------+-----------+-----------------+-----------+-----------+
| Alexis Tara Larsen      | National      |    200 |        400 |         2 |        211.8000 |       200 |       200 |
| Alexis Tara Larsen      | Regional      |    200 |        400 |         2 |        149.6667 |       200 |       200 |
| David Michael Harrison  | Local         |     70 |        400 |         2 |         70.0000 |       330 |        70 |
| David Michael Harrison  | National      |    330 |        400 |         2 |        211.8000 |       330 |        70 |
| Dominick Tom Jameson    | International |    300 |        300 |         1 |        199.7500 |       300 |       300 |
| Kathleen Anne Hamilton  | National      |     99 |         99 |         1 |        211.8000 |        99 |        99 |
| Rebecca Lauren Williams | International |    100 |        250 |         2 |        199.7500 |       150 |       100 |
| Rebecca Lauren Williams | Regional      |    150 |        250 |         2 |        149.6667 |       150 |       100 |
| Richard Thomas Anderson | Regional      |     99 |         99 |         1 |        149.6667 |        99 |        99 |
| Ross Max Booth          | International |     99 |         99 |         1 |        199.7500 |        99 |        99 |
| Susan Jane Morris       | National      |    330 |        330 |         1 |        211.8000 |       330 |       330 |
| Vincent Justin Maxwell  | International |    300 |        400 |         2 |        199.7500 |       300 |       100 |
| Vincent Justin Maxwell  | National      |    100 |        400 |         2 |        211.8000 |       300 |       100 |
+-------------------------+---------------+--------+------------+-----------+-----------------+-----------+-----------+
```

* **Analytic Functions**

```sql
SELECT flName, Competition.compType, result,
CUME_DIST() OVER(ORDER BY compType) AS 'Cume_Dist',
PERCENT_RANK() OVER(ORDER BY compType) AS 'Percent_Rank'
FROM Participation
JOIN Sportsmen ON Sportsmen.id = Participation.sportsman
JOIN Competition ON Competition.id = Participation.competition;
```
Output:
```
+-------------------------+---------------+--------+---------------------+--------------+
| flName                  | compType      | result | Cume_Dist           | Percent_Rank |
+-------------------------+---------------+--------+---------------------+--------------+
| Dominick Tom Jameson    | International |    300 |  0.2857142857142857 |            0 |
| Ross Max Booth          | International |     99 |  0.2857142857142857 |            0 |
| Vincent Justin Maxwell  | International |    300 |  0.2857142857142857 |            0 |
| Rebecca Lauren Williams | International |    100 |  0.2857142857142857 |            0 |
| Vincent Justin Maxwell  | International |    300 |  0.2857142857142857 |            0 |
| Rebecca Lauren Williams | International |    100 |  0.2857142857142857 |            0 |
| David Michael Harrison  | Local         |     70 | 0.38095238095238093 |          0.3 |
| David Michael Harrison  | Local         |     70 | 0.38095238095238093 |          0.3 |
| Kathleen Anne Hamilton  | National      |     99 |  0.7619047619047619 |          0.4 |
| Susan Jane Morris       | National      |    330 |  0.7619047619047619 |          0.4 |
| Alexis Tara Larsen      | National      |    200 |  0.7619047619047619 |          0.4 |
| David Michael Harrison  | National      |    330 |  0.7619047619047619 |          0.4 |
| Vincent Justin Maxwell  | National      |    100 |  0.7619047619047619 |          0.4 |
| Alexis Tara Larsen      | National      |    200 |  0.7619047619047619 |          0.4 |
| David Michael Harrison  | National      |    330 |  0.7619047619047619 |          0.4 |
| Vincent Justin Maxwell  | National      |    100 |  0.7619047619047619 |          0.4 |
| Richard Thomas Anderson | Regional      |     99 |                   1 |          0.8 |
| Rebecca Lauren Williams | Regional      |    150 |                   1 |          0.8 |
| Alexis Tara Larsen      | Regional      |    200 |                   1 |          0.8 |
| Rebecca Lauren Williams | Regional      |    150 |                   1 |          0.8 |
| Alexis Tara Larsen      | Regional      |    200 |                   1 |          0.8 |
+-------------------------+---------------+--------+---------------------+--------------+
21 rows in set (0.01 sec)
```

* **Ranking functions**

```sql
SELECT flName, Competition.compType, result,
RANK() OVER(PARTITION BY flName ORDER BY result) AS 'Rank'
FROM Participation
JOIN Sportsmen ON Sportsmen.id = Participation.sportsman
JOIN Competition ON Competition.id = Participation.competition;
```
Output:
```
+-------------------------+---------------+--------+------+
| flName                  | compType      | result | Rank |
+-------------------------+---------------+--------+------+
| Alexis Tara Larsen      | National      |    200 |    1 |
| Alexis Tara Larsen      | Regional      |    200 |    1 |
| Alexis Tara Larsen      | National      |    200 |    1 |
| Alexis Tara Larsen      | Regional      |    200 |    1 |
| David Michael Harrison  | Local         |     70 |    1 |
| David Michael Harrison  | Local         |     70 |    1 |
| David Michael Harrison  | National      |    330 |    3 |
| David Michael Harrison  | National      |    330 |    3 |
| Dominick Tom Jameson    | International |    300 |    1 |
| Kathleen Anne Hamilton  | National      |     99 |    1 |
| Rebecca Lauren Williams | International |    100 |    1 |
| Rebecca Lauren Williams | International |    100 |    1 |
| Rebecca Lauren Williams | Regional      |    150 |    3 |
| Rebecca Lauren Williams | Regional      |    150 |    3 |
| Richard Thomas Anderson | Regional      |     99 |    1 |
| Ross Max Booth          | International |     99 |    1 |
| Susan Jane Morris       | National      |    330 |    1 |
| Vincent Justin Maxwell  | National      |    100 |    1 |
| Vincent Justin Maxwell  | National      |    100 |    1 |
| Vincent Justin Maxwell  | International |    300 |    3 |
| Vincent Justin Maxwell  | International |    300 |    3 |
+-------------------------+---------------+--------+------+
21 rows in set (0.00 sec)
```

With repeated results of one sportsman:

```sql
SELECT flName, Competition.compType, result,
RANK() OVER(PARTITION BY flName ORDER BY result) AS 'Rank',
DENSE_RANK() OVER(PARTITION BY flName ORDER BY result) AS 'Dense_Rank'
FROM Participation
JOIN Sportsmen ON Sportsmen.id = Participation.sportsman
JOIN Competition ON Competition.id = Participation.competition;
```
Output:
```
+-------------------------+---------------+--------+------+------------+
| flName                  | compType      | result | Rank | Dense_Rank |
+-------------------------+---------------+--------+------+------------+
| Alexis Tara Larsen      | National      |    200 |    1 |          1 |
| Alexis Tara Larsen      | Regional      |    200 |    1 |          1 |
| Alexis Tara Larsen      | National      |    200 |    1 |          1 |
| Alexis Tara Larsen      | Regional      |    200 |    1 |          1 |
| David Michael Harrison  | Local         |     70 |    1 |          1 |
| David Michael Harrison  | Local         |     70 |    1 |          1 |
| David Michael Harrison  | National      |    330 |    3 |          2 |
| David Michael Harrison  | National      |    330 |    3 |          2 |
| Dominick Tom Jameson    | International |    300 |    1 |          1 |
| Kathleen Anne Hamilton  | National      |     99 |    1 |          1 |
| Rebecca Lauren Williams | International |    100 |    1 |          1 |
| Rebecca Lauren Williams | International |    100 |    1 |          1 |
| Rebecca Lauren Williams | Regional      |    150 |    3 |          2 |
| Rebecca Lauren Williams | Regional      |    150 |    3 |          2 |
| Richard Thomas Anderson | Regional      |     99 |    1 |          1 |
| Ross Max Booth          | International |     99 |    1 |          1 |
| Susan Jane Morris       | National      |    330 |    1 |          1 |
| Vincent Justin Maxwell  | National      |    100 |    1 |          1 |
| Vincent Justin Maxwell  | National      |    100 |    1 |          1 |
| Vincent Justin Maxwell  | International |    300 |    3 |          2 |
| Vincent Justin Maxwell  | International |    300 |    3 |          2 |
+-------------------------+---------------+--------+------+------------+
21 rows in set (0.00 sec)
```


### Stored Procedures and Functions. Triggers. Cursors

* **Create a stored function with a parameter**

The stored function takes a rating and returns the number of people with that rating.

```sql
DELIMITER $$
CREATE FUNCTION amount (srate INT) RETURNS INT
DETERMINISTIC
BEGIN
DECLARE amount INT DEFAULT 0;
SELECT COUNT(*) AS Amount
INTO amount FROM Sportsmen
WHERE rate = srate;
RETURN amount;
END $$

SELECT amount(1900);
```
Output:
```
+--------------+
| amount(1900) |
+--------------+
|            2 |
+--------------+
```

* **Create stored procedure with input parameter**

The procedure displays the list of Participations of an athlete in competitions, whose name is passed to the procedure via a parameter.

```sql
DELIMITER $$
CREATE PROCEDURE sportsman_participation (sportsman_name VARCHAR(40))
BEGIN
SELECT p.id, s.flName, c.compType, p.result
FROM Participation AS p
INNER JOIN Sportsmen AS s
        ON s.id = p.sportsman
INNER JOIN Competition AS c
        ON c.id = p.competition
WHERE s.flName = sportsman_name;
END $$

DELIMITER ;

call sportsman_participation('Rebecca Lauren Williams');
```
Output:
```
+----+-------------------------+---------------+--------+
| id | flName                  | compType      | result |
+----+-------------------------+---------------+--------+
| 12 | Rebecca Lauren Williams | International |    100 |
| 16 | Rebecca Lauren Williams | Regional      |    150 |
+----+-------------------------+---------------+--------+
```

* **Create a stored procedure with input and output parameters**

The procedure finds the athlete's maximum result.

```sql
DELIMITER $$
CREATE PROCEDURE sportsman_max_result (sportsman_name VARCHAR(40), 
                                       OUT max_res INT)
BEGIN
SELECT MAX(p.result) INTO max_res
FROM Participation AS p
INNER JOIN Sportsmen AS s
        ON s.id = p.sportsman
WHERE s.flName = sportsman_name;
END $$

DELIMITER ;

CALL sportsman_max_result('Rebecca Lauren Williams', @x);
SELECT @x;
```
Output:
```
+------+
| @x   |
+------+
|  150 |
+------+
```

* **Create procedure with cursor**

The `sp_tr` procedure with the `cur1` cursor produces tables with the names of athletes and their coaches.

```sql
DELIMITER $$
CREATE PROCEDURE sp_tr()
BEGIN
DECLARE tr_id INT;
DECLARE done INT DEFAULT TRUE;
DECLARE cur1 CURSOR FOR SELECT id FROM Sportsmen;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = FALSE;
OPEN cur1;
WHILE done DO FETCH cur1 INTO tr_id;
SELECT flName, trainer FROM Sportsmen WHERE trainer = tr_id;
END WHILE;
CLOSE cur1;
END $$

DELIMITER ;

CALL sp_tr();
```
Output:
```
+------------------------+---------+
| flName                 | trainer |
+------------------------+---------+
| Dominick Tom Jameson   |       1 |
| Samantha Beth Hamilton |       1 |
+------------------------+---------+

+-------------------------+---------+
| flName                  | trainer |
+-------------------------+---------+
| Steven Jack Ball        |       2 |
| Melissa Kira Pittman    |       2 |
| Rebecca Lauren Williams |       2 |
| David Michael Harrison  |       2 |
+-------------------------+---------+

+-------------------------+---------+
| flName                  | trainer |
+-------------------------+---------+
| Kimberly Maria Perez    |       3 |
| Richard Thomas Anderson |       3 |
+-------------------------+---------+

+------------------------+---------+
| flName                 | trainer |
+------------------------+---------+
| Richard Frank Jones    |       4 |
| Vincent Justin Maxwell |       4 |
| Alexis Tara Larsen     |       4 |
+------------------------+---------+

+--------------------+---------+
| flName             | trainer |
+--------------------+---------+
| Ross Max Booth     |       5 |
| Jackson Evan Smith |       5 |
+--------------------+---------+

+------------------------+---------+
| flName                 | trainer |
+------------------------+---------+
| Kathleen Anne Hamilton |       6 |
| Susan Jane Morris      |       6 |
+------------------------+---------+
```

<br/>  
<p align="center"><a href="#sportsclub-sql-project"><img src="https://github.com/arina-korkhova/Sportsclub-SQL-Project/blob/main/images/backToTopButton.png" alt="Back to top" height="29"/></a></p>
