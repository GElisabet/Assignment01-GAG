--1

select COUNT (*)
from condition 
where name like '%injur%'

--EKKI RETT-- 

--2.  The average salary of all registered nurses is 77265 (rounded). What is the average salary of all registered technicians (rounded)?

select AVG(ROUND(salary,2)) AS AverageSalary
from HealthcareWorker,role
where HealthcareWorker.ID = role.ID
and role.name = 'Technician'

select AVG(ROUND(salary,2)) AS AverageSalary
from HealthcareWorker
join role on HealthcareWorker.ID = role.ID
and role.name = 'Nurse'

--EKKI RETT-- 


--3  There were 5510 admissions to private hospitals. How many admissions were there to government hospitals?

select COUNT(*) AS TotalAdmissions
from Admitted,hospital
where Admitted.HID = hospital.ID
and hospital.type = 'Government'

-- Rétt -- 

-- 4.  Three healthcare workers have quit more than once. How many healthcare workers have quit at least once?

select COUNT(*) 
from works
where quit_date is not null
and quit_date > start_date 


-- EKKI RETT --

-- 5.  How many patients have been admitted to a hospital in the same city as they live in?

select COUNT(*)
from Admitted,patient,hospital
where Admitted.PID = patient.ID
and Admitted.HID = hospital.ID
and patient.city = hospital.city

-- veit ekki með þetta -- 

-- 6. There were 173 patients admitted to a hospital more than 2 times. How many patients were admitted more than 3 times?





