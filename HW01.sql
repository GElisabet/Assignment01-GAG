
--A.
select *
from condition



select COUNT (*)
from condition
where name like '%kidney%' or name like '%Kidney%'

--Ágústu svar:
SELECT COUNT(*)
FROM Condition
WHERE LOWER(name) LIKE '%kidney%';

--B.  The average salary of all registered nurses is 77265 (rounded). What is the average salary of all registered technicians (rounded)?

select AVG(ROUND(salary,2)) AS AverageSalary
from HealthcareWorker,role
where HealthcareWorker.ID = role.ID
and role.name = 'Technician' 

select AVG(ROUND(salary,2)) AS AverageSalary
from HealthcareWorker
join role on HealthcareWorker.ID = role.ID
and role.name = 'Nurse' 

--EKKI RETT-- 
-- Ágústu svar:
SELECT CEILING(AVG(salary))
FROM HealthcareWorker HCW
    JOIN Role R ON HCW.RID = R.ID
WHERE R.name = 'Technician';

--C. There were 5510 admissions to private hospitals. How many admissions were there to government hospitals?

select COUNT(*) AS TotalAdmissions
from Admitted,hospital
where Admitted.HID = hospital.ID
and hospital.type = 'Government'

-- Rétt -- 

-- D.  Three healthcare workers have quit more than once. How many healthcare workers have quit at least once?

select COUNT(*) from works
where quit_date is not null


-- E.  How many patients have been admitted to a hospital in the same city as they live in?

select COUNT(*)
from Admitted,patient,hospital
where Admitted.PID = patient.ID
and Admitted.HID = hospital.ID
and patient.city = hospital.city

-- veit ekki með þetta -- 

-- F. There were 173 patients admitted to a hospital more than 2 times. How many patients were admitted more than 3 times?


select SUM(ID)
from patient
join admitted on patient.ID = admitted.PID
group by patient.ID
having COUNT(ID) > 3


-- G. For 119 nurses there exist another nurse with the same name. For how many physicians does there exist another physician with the same name?


-- find how many nurses have the same name as another nurse


select healthcareworker.name
from healthcareworker
where RID = 0
group by name 
having COUNT(name) > 1



SELECT COUNT(*)
FROM HealthcareWorker
WHERE HealthcareWorker.name IN (SELECT HealthcareWorker.name FROM HealthcareWorker
JOIN Role ON HealthcareWorker.RID = Role.ID
WHERE Role.name = 'Nurse'
GROUP BY HealthcareWorker.name
HAVING COUNT(*) >1);

