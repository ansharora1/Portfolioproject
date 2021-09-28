


--SELECT * 
--FROM PORTFOLIO..covidvaccinations$
--ORDER BY 3,4

--Select data that we are going to be using
--Shows likelyhood of dying if you contract covid in india


SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS death_percentage
FROM PORTFOLIO..coviddeaths$
WHERE location = 'India'
ORDER BY 1,2

--looking at total cases vs population

SELECT location,date,total_cases,population,(total_cases/population)*100 AS case_percentage
FROM PORTFOLIO..coviddeaths$
WHERE location = 'India'
ORDER BY 1,2

-- country with highest infestion rate compared to population

SELECT  location,population, MAX(total_cases) AS highestinfectioncount, MAX((total_cases/population))*100 AS case_percentage
FROM PORTFOLIO..coviddeaths$
GROUP BY location, population
ORDER BY case_percentage DESC

--Showing countries with highest death count 

SELECT  location,MAX(cast(total_deaths AS int)) AS total_death_count
FROM PORTFOLIO..coviddeaths$
WHERE continent is not null
GROUP BY location
ORDER BY total_death_count DESC

-- Let's break things down by continent death per population
-- Showing continents with highest
SELECT  continent,MAX(cast(total_deaths AS int)) AS total_death_count
FROM PORTFOLIO..coviddeaths$
WHERE continent is not null
GROUP BY continent
ORDER BY total_death_count DESC

-- global numbers
SELECT date,SUM(new_cases) AS total_cases, SUM(cast(new_deaths AS int)) AS total_deaths, SUM(cast(new_deaths AS int))/SUM(new_cases)*100 AS death_percentage
FROM PORTFOLIO..coviddeaths$
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

-- looking at total population vs vaccination

SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
FROM PORTFOLIO..coviddeaths$ dea
join PORTFOLIO..covidvaccinations$ vac
 ON dea.location = vac.location
 and dea.date = vac.date
 WHERE dea.continent is not null
 ORDER BY 2,3

 --create view to store data for later vizualization

 create view globalnumber as
 SELECT date,SUM(new_cases) AS total_cases, SUM(cast(new_deaths AS int)) AS total_deaths, SUM(cast(new_deaths AS int))/SUM(new_cases)*100 AS death_percentage
FROM PORTFOLIO..coviddeaths$
WHERE continent is not null
GROUP BY date
--ORDER BY 1,2

SELECT *
FROM globalnumber