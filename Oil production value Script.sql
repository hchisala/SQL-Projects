
  
--Breaking down the data to oil production value growth from each year between 2018 and 2021
   
  SELECT 
    location, 
    time, 
    value, 
    LAG(value) OVER (PARTITION BY location ORDER BY time) AS prev_value, 
    ((value - LAG(value) OVER (PARTITION BY location ORDER BY time)) / LAG(value) OVER (PARTITION BY location ORDER BY time)) * 100 AS value_growth
FROM 
    OCED_data where time between 2018 and 2021;

-- Calulating the average for each country

  with Avg_value as (SELECT 
    location, 
    time,
    value, 
    LAG(value) OVER (PARTITION BY location ORDER BY time) AS prev_value, 
    ((value - LAG(value) OVER (PARTITION BY location ORDER BY time)) / LAG(value) OVER (PARTITION BY location ORDER BY time)) * 100 AS value_growth
FROM 
    OCED_data where time between 2018 and 2021)
  
    -- creating a new coulmn to describe the growth rate and grouping by each country

   select country_data.Country_Name, Avg_value.location, country_data.Continent_Name, avg(value_growth) as averagevalue, 
 case 
  when avg(value_growth) >20 then 'Extremly high growth'
  when avg(value_growth)  between 5 and 20.9 then 'high growth'
  when avg(value_growth)  between 0 and 4.9 then 'stable growth'
  else 'No growth'
  end as descrip
   from Avg_value 
   join country_data on Avg_value.location = country_data.CountryCode
   group by Avg_value.location order by averagevalue desc;
 
  -- Checking the highest producing countries in 2021 alone
  
  Select location, time, value, rank() over (order by value desc) as rank from Oced_data 
 where time = 2021 and location not in ('WLD','G20') and location not like ('%EU2%');
  

--Indetifying the highest oil production value locations (worldwide)

select oced_data.location,sum(oced_data.value) as total_value, country_data.Country_name, country_data.continent_name 
from OCED_data 
join country_data on oced_data.location = country_data.CountryCode
where oced_data.time between 2018 and 2021 
group by oced_data.location
having total_value <> 0
order by total_value desc; 

--Indetifying the highest oil production value locations (Africa)

  select oced_data.location,sum(oced_data.value) as total_value, country_data.Country_name, country_data.continent_name 
from OCED_data 
join country_data on oced_data.location = country_data.CountryCode
where oced_data.time between 2018 and 2021 and country_data.Continent_Name = 'Africa'
group by oced_data.location
having total_value <> 0
order by total_value desc; 

   --Indetifying the highest oil production value locations (Asia and Oceania)

 select oced_data.location,sum(oced_data.value) as total_value, country_data.Country_name, country_data.continent_name 
from OCED_data 
join country_data on oced_data.location = country_data.CountryCode
where oced_data.time between 2018 and 2021 and (country_data.Continent_Name = 'Oceania' or country_data.Continent_Name = 'Asia')
group by oced_data.location
having total_value <> 0
order by total_value desc; 

   --Indetifying the highest oil production value locations (Europe)

 select oced_data.location,sum(oced_data.value) as total_value, country_data.Country_name, country_data.continent_name 
from OCED_data 
join country_data on oced_data.location = country_data.CountryCode
where oced_data.time between 2018 and 2021 and country_data.Continent_Name = 'Europe'
group by oced_data.location
having total_value <> 0
order by total_value desc; 

   --Indetifying the highest oil production value locations (Americas)

select oced_data.location,sum(oced_data.value) as total_value, country_data.Country_name, country_data.continent_name 
from OCED_data 
join country_data on oced_data.location = country_data.CountryCode
where oced_data.time between 2018 and 2021 and (country_data.Continent_Name = 'North America' or country_data.Continent_Name = 'South America') 
group by oced_data.location
having total_value <> 0
order by total_value desc; 

--Summary Statistics

select oced_data.location, max(COALESCE(oced_data.Value,0)) as max_value, 
min(oced_data.Value) as min_value,
avg(oced_data.Value) as avg_value,
stdev(oced_data.Value) as stdev_value
from OCED_data  
group by LOCATION 
order by max_value desc;




