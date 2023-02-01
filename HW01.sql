-- HW01 

-- Guðbjörg E. Sigurjónsdóttir : gudbjorges21@ru.is
-- Ágústa Björk Schweitz : agusta20@ru.is
-- Ásta Sól Bjarkadóttir


--A.
SELECT COUNT(*)
FROM Condition
WHERE LOWER(name) LIKE '%kidney%';


--B.  

SELECT AVG(ROUND(salary,2)) AS AverageSalary
FROM HealthcareWorker,role
WHERE HealthcareWorker.ID = role.ID
AND role.name = 'Technician' 



--C. 

SELECT COUNT(*) AS TotalAdmissions
FROM Admitted,hospital
WHERE Admitted.HID = hospital.ID
AND hospital.type = 'Government'


-- D. 

SELECT COUNT(*)
FROM Works
WHERE quit_date IS NOT NULL


-- E.  

SELECT COUNT(*)
FROM Patient P
    JOIN Admitted A ON P.ID = A.PID
    JOIN Hospital H ON A.HID = H.ID
WHERE P.city like CONCAT('%', H.city);


-- F. 

SELECT COUNT(*)
FROM Patient
WHERE ID IN (
    SELECT PID
    FROM Admitted
    GROUP BY PID
    HAVING COUNT(*) > 3
);

-- G.

SELECT COUNT(*)
FROM HealthcareWorker
WHERE name IN (
    SELECT name
    FROM HealthcareWorker
    WHERE RID = 1
    GROUP BY name
    HAVING COUNT(*) > 1
);


-- H. 

SELECT COUNT(*)
FROM HealthcareWorker 
WHERE HealthcareWorker.ID NOT IN (
    SELECT DISTINCT HasTreated.HWID
    FROM HasTreated
);

-- I.

SELECT DISTINCT name 
FROM Condition
    JOIN Has on Condition.ID = Has.CID
WHERE name IN (
    SELECT name
    FROM Condition
        JOIN Has on Condition.ID = Has.CID
    GROUP BY name
    HAVING COUNT(name) = (
        SELECT MAX("Most common condition(s)")
        FROM (
            SELECT COUNT(name) AS "Most common condition(s)"
            FROM Condition
                JOIN Has ON Condition.ID = Has.CID
            GROUP BY name
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
