--Data Cleaning and updating

Alter table custo_data drop column A;

Alter table custo_data drop column B;

update custo_data set package = '5 kg' where contact = 888556665;
update custo_data set package = '5 kg' where contact = 998570603;
delete from custo_data where contact = 884882882;

--Inserting new records

insert into custo_data (name, surname, sex, location,  profession, age, contact, package) 
values ('*****','*****','Male','Blantyre', 'Student', **, *******, '5 Kg');
insert into custo_data (name, surname, sex, location, profession, age, contact, package) 
values ('****','*******', 'Male', 'Kansungu','Professor', **, *****, '5 Kg');
insert into custo_data (name, surname, sex, location, profession, age, contact, package) 
values ('*****', '*****', 'Female','Mzuzu', 'Security Guard', **, ********, '6 Kg');

--Sensitive information has been censored for privacy reasons


---Summary EDA

-- Number of people in the EDA
select count(*) from custo_data;

--Avergae age of participates
select avg(age) from custo_data;

--Count of sales per product
 select  count(*) from custo_data where package Like '%6%';
 
 select  count(*) from custo_data where package Like '%5%';
 
--Evaluating Demographics and their prefered packages

select age, Profession, substring(package,1,1), count(*) as Total_Sales
from custo_data 
group by Age, profession, package
order by Total_Sales desc; 

--Analysis of sales from Businesses vs Employees

select Profession, substring(package,1,1), count(*) as Total_Sales
from custo_data 
where profession = 'Business'
group by profession
order by Total_Sales desc; 


select Profession, substring(package,1,1), count(*) as Total_Sales
from custo_data 
where profession is not 'Business' 
and profession is not 'N/A'
group by profession
order by Total_Sales desc; 

--Explore preferences of age groups for specific products/packages

Select age, package, count(*) as total_sales
from custo_data 
group by age, PACKAGE 
order by total_sales desc;

--Customer location analysis

select location, "AREA CODE" , age, package, count(*) as total_sales
from custo_data 
group by LOCATION 
order by total_sales desc;

--Marketing strategy analysis

select custo_data.location, custo_data.package, custo_data.age, popular_markets."Popular market"  
from custo_data 
join Popular_markets on custo_data.location = popular_markets.city
group by custo_data.location





