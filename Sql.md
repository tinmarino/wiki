

### Revising the Select Query I

* 1 tester code

```sql
SELECT *
FROM CITY
WHERE
    COUNTRYCODE = 'USA'
    AND POPULATION > 100000;
```

* Some select queries

```sql
Select * From CITY Where COUNTRYCODE = 'USA' And POPULATION > 100000;
```

```sql
Select NAME From CITY Where COUNTRYCODE = 'USA' And POPULATION > 120000;
```

```sql
Select * From CITY;
```

```sql
Select * From CITY Where ID = 1661;
```

```sql
Select * From CITY Where COUNTRYCODE = 'JPN';
```

```sql
Select * From CITY Where COUNTRYCODE = 'JPN';
```

```sql
Select CITY, STATE From STATION;
```

```sql
Select Distinct CITY From STATION Where Mod(ID,2) = 0; -- Oracle
Select Distinct CITY From STATION Where ID % 2 = 0; -- MySql
```

```sql
Select (Count(CITY) - Count(Distinct CITY)) from STATION
```


### Weather Observation Station 5

```sql
SELECT * FROM (
    SELECT CITY, length(CITY)
    FROM STATION
    WHERE length(CITY) = (SELECT max(length(CITY)) FROM STATION)
    ORDER BY CITY)
WHERE rownum = 1;

SELECT * FROM (
    SELECT CITY, length(CITY)
    FROM STATION
    WHERE length(CITY) = (SELECT min(length(CITY)) FROM STATION)
    ORDER BY CITY)
WHERE rownum = 1;
```

```sql
SELECT *
FROM
    (SELECT CITY, LENGTH(CITY)
    FROM STATION
    ORDER BY LENGTH(CITY), CITY)
WHERE ROWNUM = 1
UNION
SELECT *
FROM
    (SELECT CITY, LENGTH(CITY)
    FROM STATION
    ORDER BY LENGTH(CITY) DESC, CITY)
WHERE ROWNUM = 1;
```

```sql
select MIN(city), length(city)
from station
group by length(city)
having length(city) = (select MIN(length(city)) from station)
    or length(city) = (select MAX(length(city)) from station)
order by length(city) ASC;
```


### Weather Observation Station 6

* MySql

```sql
SELECT DISTINCT city FROM station WHERE city REGEXP "^[aeiou].*";
```

* Oracle

```sql
select distinct CITY
from STATION
where regexp_like(CITY, '^[AEIOU]');
```


### Weather Observation Station 11

```sql
select distinct CITY
from STATION
where regexp_like(CITY, '^[^AEIOU]')
   or regexp_like(CITY, '[^aeiou]$');
```


### Higher Than 75 Marks

```sql
select Name from Students
where Marks > 75
order by substr(Name, -3), Id;
```


### Employee Names

```sql
select Name from Employee
order by Name;
```


### Employee Salaries

```sql
select Name from Employee
where Salary > 2000 and Months < 10
order by Employee_id;
```


### SQL Project Planning

```sql
select min(start_date), max(start_date) + 1
from (select start_date, to_char(start_date,'dd') - row_number() over (order by start_date) as rnk
from projects)
group by rnk
order by max(start_date) - min(start_date), min(start_date);
```
