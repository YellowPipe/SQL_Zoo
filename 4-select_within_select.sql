--1
SELECT name FROM world
WHERE population > (
    SELECT population
    FROM world
    WHERE name='Russia')
--2
SELECT name
FROM world
WHERE continent = 'Europe' AND gdp/population > (
     SELECT gdp/population
     FROM world
     WHERE name = 'United Kingdom')
--3
SELECT name, continent
FROM world
WHERE continent = (
    SELECT continent
    FROM world
    WHERE name = 'Argentina'
) OR continent = (
    SELECT continent
    FROM world
    WHERE name = 'Australia')
ORDER BY name
--4
SELECT name, population
FROM world
WHERE population > (
    SELECT population
    FROM world
    WHERE name = 'Canada'
) AND population < (
    SELECT population
    FROM world
    WHERE name = 'Poland')
--5
SELECT name, CONCAT(ROUND(population/(
    SELECT population
    FROM world
    WHERE name = 'Germany'
)*100,0),'%')
FROM world
WHERE continent = 'Europe'
--6
SELECT name
FROM world
WHERE gdp > (
    SELECT MAX(GDP)
    FROM world
    WHERE continent = 'Europe'
)
--7
SELECT continent, name, area
FROM world x
WHERE area >= ALL (
     SELECT area
     FROM world y
     WHERE y.continent=x.continent
     AND area IS NOT NULL)

--8
SELECT continent, name
FROM world x
WHERE name <= ALL (
     SELECT name
     FROM world y
     WHERE y.continent=x.continent
     AND name IS NOT NULL)

--9
SELECT name, continent, population
FROM world
WHERE continent IN (
    SELECT continent
    FROM world a 
    WHERE 25000000 >= ALL (
        SELECT population
        FROM world b
        WHERE a.continent = b.continent
))
--10
SELECT name, continent
FROM world a
WHERE population > ALL (
    SELECT population*3
    FROM world b
    WHERE a.continent = b.continent
    AND a.name != b.name
)