/* 
SQL Join query exercise

World database layout:
To use this database from a default MySQL install, type: use world;

Table: City
Columns: Id, Name, CountryCode, District, Population

Table: Country
Columns: Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, Capital

Table: CountryLanguage
Columns: CountryCode, Language, IsOfficial, Percentage
*/

-- 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT * FROM city
WHERE Name LIKE 'ping%'
ORDER BY Population ASC;


-- 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT * FROM city
WHERE Name LIKE 'ran%'
ORDER BY Population DESC;

-- 3: Count all cities
SELECT COUNT(Name)  FROM city;


-- 4: Get the average population of all cities
SELECT AVG(Population) AS AveragePopulation
FROM city;


-- 5: Get the biggest population found in any of the cities
SELECT MAX(Population) FROM city;
SELECT * FROM city
ORDER BY Population DESC
LIMIT 1;




-- 6: Get the smallest population found in any of the cities
SELECT MIN(Population) FROM city;
SELECT * FROM city
ORDER BY Population ASC
LIMIT 1;


-- 7: Sum the population of all cities with a population below 10000
SELECT SUM(Population) AS TotalSmallCitiesPopulation From city
WHERE Population < 10000;


-- 8: Count the cities with the country codes MOZ and VNM
SELECT COUNT(Name) From city
WHERE CountryCode IN ('MOZ', 'VNM');


-- 9: Get individual count of cities for the country codes MOZ and VNM
SELECT CountryCode, COUNT(Name) From city
WHERE CountryCode IN ('MOZ', 'VNM')
GROUP BY CountryCode;


-- 10: Get average population of cities in MOZ and VNM
SELECT CountryCode, AVG(Population) From city
WHERE CountryCode IN ('MOZ', 'VNM')
GROUP BY CountryCode;

-- 11: Get the country codes with more than 200 cities
SELECT CountryCode, COUNT(Name) AS CityCount FROM city
GROUP BY CountryCode
HAVING CityCount > 200;

-- 12: Get the country codes with more than 200 cities ordered by city count
SELECT CountryCode, COUNT(Name) AS CityCount FROM city
GROUP BY CountryCode
HAVING CityCount > 200
ORDER BY CityCount DESC;


-- 13: What language(s) is spoken in the city with a population between 400 and 500?
SELECT cL.Language From countrylanguage cL
WHERE cL.CountryCode IN (SELECT CountryCode From city WHERE Population BETWEEN 400 AND 500);


-- 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
SELECT ci.Name AS CityName, Language From city ci
JOIN countrylanguage cL ON ci.CountryCode=cL.CountryCode
WHERE ci.Population BETWEEN 500 AND 600;


-- 15: What names of the cities are in the same country as the city with a population of 122199 (including that city itself)
SELECT ci.Name AS CityName From city ci
WHERE CountryCode IN (SELECT CountryCode FROM city WHERE Population=122199);



-- 16: What names of the cities are in the same country as the city with a population of 122199 (excluding that city itself)
SELECT ci.Name AS CityName From city ci
WHERE CountryCode IN (SELECT CountryCode FROM city WHERE Population=122199) 
AND Population <> 122199;

-- 17: What are the city names in the country where Luanda is the capital?
SELECT ci.Name AS CityName From city ci
JOIN country c ON c.Code=ci.CountryCode
WHERE c.Capital IN (SELECT ID FROM city ci WHERE ci.Name='Luanda');

-- 18: What are the names of the capital cities in countries in the same region as the city named Yaren
SELECT ci.Name AS Capital FROM city ci
JOIN country c ON c.Capital = ci.ID
WHERE c.Region IN (SELECT Region FROM country 
WHERE Code = (SELECT CountryCode FROM city WHERE Name='Yaren'));

-- 19: What unique languages are spoken in the countries in the same region as the city named Riga
SELECT DISTINCT cL.Language From countrylanguage cL
JOIN country c ON c.Code = cL.CountryCode
WHERE c.Region IN (SELECT Region from country
WHERE Code = (SELECT CountryCode FROM city WHERE Name='Riga'));


-- 20: Get the name of the most populous city
SELECT Name FROM city
WHERE Population = (SELECT MAX(Population) FROM city);

