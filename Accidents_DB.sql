create database Accident_summary_DB
use Accident_summary_DB
select * from Road_accident


----a---
SELECT SUM(number_of_casualties) AS total_casualties_2022 FROM Road_accident
WHERE YEAR(accident_date) = 2022;
---b---
SELECT COUNT(*) AS total_accidents_2022 FROM Road_accident
WHERE YEAR(accident_date) = 2022;
---c---
SELECT SUM(number_of_casualties) AS total_fatal_casualties_2022 FROM Road_accident
WHERE YEAR(accident_date) = 2022 AND accident_severity = 'Fatal';
---d---
SELECT SUM(number_of_casualties) AS total_serious_casualties_2022 FROM Road_accident
WHERE YEAR(accident_date) = 2022 AND accident_severity = 'Serious';
---e---
SELECT SUM(number_of_casualties) AS total_slight_casualties_2022 FROM Road_accident
WHERE YEAR(accident_date) = 2022 AND accident_severity = 'Slight';
---f---
SELECT vehicle_type, sum(number_of_casualties) as total_casualties FROM Road_accident
WHERE YEAR(accident_date) = 2022 GROUP BY vehicle_type order by total_casualties desc ;
---g---
SELECT FORMAT(accident_date , 'MMMM') AS month, SUM(number_of_casualties) AS total_casualties FROM Road_accident
WHERE YEAR(accident_date) = 2022 GROUP BY FORMAT(accident_date , 'MMMM') ORDER BY SUM(number_of_casualties)DESC;
---h---
SELECT FORMAT(accident_date , 'MMMM') AS month, SUM(number_of_casualties) AS total_casualties FROM Road_accident
WHERE YEAR(accident_date) = 2021 GROUP BY FORMAT(accident_date , 'MMMM') ORDER BY SUM(number_of_casualties)DESC;
---i---
SELECT road_type, SUM(number_of_casualties) AS total_casualties FROM Road_accident 
WHERE YEAR(accident_date) = 2022 GROUP BY road_type ORDER BY total_casualties DESC;
---j---
SELECT urban_or_rural_area, SUM(number_of_casualties) AS total_casualties FROM Road_accident
WHERE YEAR(accident_date) = 2022 GROUP BY urban_or_rural_area ORDER BY total_casualties DESC;
---k---
SELECT light_conditions, SUM(number_of_casualties) AS total_casualties FROM Road_accident
WHERE YEAR(accident_date) = 2022 GROUP BY light_conditions ORDER BY total_casualties DESC;
---l---
SELECT TOP 10 local_authority, SUM(number_of_casualties) AS total_casualties FROM Road_accident
WHERE YEAR(accident_date) = 2022 GROUP BY local_authority ORDER BY total_casualties DESC;





SELECT vehicle_type, COUNT(*) AS number_of_accidents FROM Road_accident
GROUP BY vehicle_type ORDER BY number_of_accidents DESC;
--another answer for f--
SELECT vehicle_type, COUNT(*) AS number_of_accidents FROM Road_accident
WHERE YEAR(accident_date) = 2022 GROUP BY vehicle_type ORDER BY number_of_accidents DESC;

SELECT vehicle_type, sum(number_of_casualties) as total_casualties FROM Road_accident
WHERE YEAR(accident_date) = 2022 GROUP BY vehicle_type order by total_casualties desc ;


SELECT vehicle_type, COUNT(*) AS Number_of_Accidents_2022
FROM Road_accident
WHERE YEAR(accident_date) = 2022
GROUP BY vehicle_type;




SELECT FORMAT(accident_date , 'MMMM') AS month, SUM(number_of_casualties) AS total_casualties FROM Road_accident
WHERE YEAR(accident_date) = 2022 GROUP BY FORMAT(accident_date , 'MMMM') ORDER BY SUM(number_of_casualties)DESC;




(SELECT SUM(number_of_casualties) AS total_casualties_2022 FROM Road_accident
WHERE YEAR(accident_date) = 2022);-
(SELECT SUM(number_of_casualties) AS total_casualties_2022 FROM Road_accident
WHERE YEAR(accident_date) = 2021);

SELECT 
    (SELECT SUM(number_of_casualties) 
     FROM Road_accident 
     WHERE YEAR(accident_date) = 2022) -
    (SELECT SUM(number_of_casualties) 
     FROM Road_accident 
     WHERE YEAR(accident_date) = 2021) AS casualties_difference;