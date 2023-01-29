-- HW01 

-- Guðbjörg E. Sigurjónsdóttir : gudbjorges21@ru.is
-- Ágústa Björk Schweitz : agusta20@ru.is
-- Ásta Sól Bjarkadóttir


--A.

select COUNT (*)
from condition
where name like '%kidney%' or name like '%Kidney%'


--B.  The average salary of all registered nurses is 77265 (rounded). What is the average salary of all registered technicians (rounded)?

SELECT CEILING(AVG(salary))
FROM HealthcareWorker 
JOIN Role ON HealthcareWorker.RID = Role.ID
WHERE Role.name = 'Technician';


--C. There were 5510 admissions to private hospitals. How many admissions were there to government hospitals?

select COUNT(*) AS TotalAdmissions
from Admitted,hospital
where Admitted.HID = hospital.ID
and hospital.type = 'Government'


-- D.  Three healthcare workers have quit more than once. How many healthcare workers have quit at least once?


select COUNT(*) 
from works
where quit_date is not null
and quit_date > start_date 

-- E.  How many patients have been admitted to a hospital in the same city as they live in?

select count(*)
from patient 
where city in (
    select city
    from hospital
    join admitted on hospital.id = admitted.hid
    group by city
)

select count(*)
from Patient as p 
	join Admitted as A on p.id = a.pid
	join Hospital as H on a.hid = H.id
where h.city = p.city

-- F. There were 173 patients admitted to a hospital more than 2 times. How many patients were admitted more than 3 times?


select SUM(ID)
from patient
join admitted on patient.ID = admitted.PID
group by patient.ID
having COUNT(ID) > 3;

-- G. For 119 nurses there exist another nurse with the same name. For how many physicians does there exist another physician with the same name?

SELECT COUNT(*)
FROM HealthcareWorker
WHERE name IN (
    SELECT name
    FROM HealthcareWorker
    WHERE RID = 1
    GROUP BY name
    HAVING COUNT(*) > 1
);


-- H. How many healthcare workers have not treated anyone?


SELECT COUNT(*)
FROM HealthcareWorker 
WHERE HealthcareWorker.ID NOT IN (
    SELECT DISTINCT HasTreated.HWID
    FROM HasTreated
);

-- I. What condition(s) are most common? Return the result in a column named "Most common condition(s)


select distinct name 
from Condition
join Has on Condition.ID = Has.CID
where name in (
    select name
    from Condition
    join Has on Condition.ID = Has.CID
    group by name
    having COUNT(name) = (
        select MAX("Most common condition(s)")
        from (
            select COUNT(name) AS "Most common condition(s)"
            from Condition
            join Has on Condition.ID = Has.CID
            group by name
        )   X
    )
);



-- J 

SELECT DISTINCT Condition.name
FROM Condition
JOIN Has ON Condition.ID = Has.CID
JOIN Patient ON Has.PID = Patient.ID
JOIN Admitted ON Patient.ID = Admitted.PID
JOIN Hospital ON Admitted.HID = Hospital.ID
JOIN HasTreated ON Patient.ID = HasTreated.PID
JOIN HealthcareWorker ON HasTreated.HWID = HealthcareWorker.ID
JOIN Works ON HealthcareWorker.ID = Works.HWID
WHERE (Hospital.city = 'Torrington' OR Hospital.city = 'Cheyenne')
AND Admitted.admitted_date = Works.quit_date;