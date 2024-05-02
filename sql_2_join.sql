# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT * FROM city
WHERE name LIKE 'ping%'
ORDER BY population ASC;
#
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT * FROM city
WHERE name LIKE 'ran%'
ORDER BY population DESC;
#
#
# 3: Count all cities
SELECT COUNT(*) AS city_count FROM city;
#
#
# 4: Get the average population of all cities
SELECT AVG(population) AS average_population FROM city;
#
#
# 5: Get the biggest population found in any of the cities
SELECT MAX(population) AS biggest_population FROM city;
#
#
# 6: Get the smallest population found in any of the cities
SELECT MIN(population) AS smallest_population FROM city;
#
#
# 7: Sum the population of all cities with a population below 10000
SELECT SUM(population) AS total_population_below_10000 FROM city
WHERE population < 10000;
#
#
# 8: Count the cities with the countrycodes MOZ and VNM
SELECT COUNT(*) AS city_count FROM city
WHERE countrycode IN ('MOZ', 'VNM');

#
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
SELECT countrycode, COUNT(*) AS city_count
FROM city
WHERE countrycode IN ('MOZ', 'VNM')
GROUP BY countrycode;
#
#
# 10: Get average population of cities in MOZ and VNM
SELECT countrycode, AVG(population) AS average_population
FROM city
WHERE countrycode IN ('MOZ', 'VNM')
GROUP BY countrycode;
#
#
# 11: Get the countrycodes with more than 200 cities
SELECT countrycode, COUNT(*) AS city_count
FROM city
GROUP BY countrycode
HAVING COUNT(*) > 200;
#
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
SELECT countrycode, COUNT(*) AS city_count
FROM city
GROUP BY countrycode
HAVING COUNT(*) > 200
ORDER BY city_count DESC;
#
#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
SELECT countrylanguage.Language
FROM city
JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
WHERE city.Population BETWEEN 400 AND 500;
#
#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
SELECT city.Name, countrylanguage.Language
FROM city
JOIN country ON city.CountryCode = country.Code
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE city.Population BETWEEN 500 AND 600;
#
#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
SELECT city.Name
FROM city
WHERE city.CountryCode = (
    SELECT CountryCode
    FROM city
    WHERE Population = 122199
);
#
#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
SELECT city.Name
FROM city
WHERE city.CountryCode = (
    SELECT CountryCode
    FROM city
    WHERE Population = 122199
)
AND city.Population != 122199;
#
#
# 17: What are the city names in the country where Luanda is capital?
SELECT city.Name
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE country.Capital = (
    SELECT ID
    FROM city
    WHERE Name = 'Luanda'
);
#
#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
SELECT capital.Name
FROM country AS capital_country
JOIN city AS capital ON capital.ID = capital_country.Capital
JOIN country AS yaren_country ON yaren_country.Region = capital_country.Region
JOIN city AS yaren ON yaren.CountryCode = yaren_country.Code
WHERE yaren.Name = 'Yaren';
#
#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga
SELECT DISTINCT language.Language
FROM city AS c_riga
JOIN country AS co_riga ON c_riga.CountryCode = co_riga.Code
JOIN country AS co_region ON co_riga.Region = co_region.Region
JOIN countrylanguage AS language ON co_region.Code = language.CountryCode
WHERE c_riga.Name = 'Riga';
#
#
# 20: Get the name of the most populous city
SELECT Name 
FROM city 
WHERE Population = (
    SELECT MAX(Population) 
    FROM city
);
#
