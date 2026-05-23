-- 1. Active airplanes
SELECT plane_no, status FROM AIRPLANE WHERE status = 'ACTIVE';

-- 2. Planes currently in hangars (no check-out date)
SELECT a.plane_no, h.hangar_no, ho.check_in_date
FROM HANGAR_OCCUPANCY ho
JOIN AIRPLANE a ON ho.plane_id = a.plane_id
JOIN HANGAR h ON ho.hangar_id = h.hangar_id
WHERE ho.check_out_date IS NULL;

-- 3. Number of tests performed by each technician
SELECT t.tech_id, e.emp_name, COUNT(*) as tests_done
FROM TESTING_EVENT te
JOIN TECHNICIAN t ON te.tech_id = t.tech_id
JOIN EMPLOYEE e ON t.emp_id = e.emp_id
GROUP BY t.tech_id, e.emp_name;

-- 4. Average test score per airplane
SELECT a.plane_no, AVG(te.score) as avg_score
FROM TESTING_EVENT te
JOIN AIRPLANE a ON te.plane_id = a.plane_id
GROUP BY a.plane_no;

-- 5. Technicians expert in Boeing 737
SELECT e.emp_name
FROM TECHNICIAN t
JOIN EMPLOYEE e ON t.emp_id = e.emp_id
JOIN MODEL m ON t.expertise_model_id = m.model_id
WHERE m.model_name = 'Boeing 737';

-- 6. Detailed test event list (plane, test, technician, score)
SELECT a.plane_no, ts.test_name, e.emp_name, te.test_date, te.score
FROM TESTING_EVENT te
JOIN AIRPLANE a ON te.plane_id = a.plane_id
JOIN TEST ts ON te.test_id = ts.test_id
JOIN TECHNICIAN t ON te.tech_id = t.tech_id
JOIN EMPLOYEE e ON t.emp_id = e.emp_id;

-- 7. Number of airplanes per model (including zero)
SELECT m.model_name, COUNT(a.plane_id) as plane_count
FROM MODEL m
LEFT JOIN AIRPLANE a ON m.model_id = a.model_id
GROUP BY m.model_name;

-- 8. Total hours spent on all tests
SELECT SUM(hours_spent) as total_hours FROM TESTING_EVENT;

-- 9. Tests with score >= 70
SELECT * FROM TESTING_EVENT WHERE score >= 70;

-- 10. Employees hired in the last 2 years
SELECT emp_name, hire_date 
FROM EMPLOYEE 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 11. Airplanes that have never been tested
SELECT plane_no FROM AIRPLANE
WHERE plane_id NOT IN (SELECT DISTINCT plane_id FROM TESTING_EVENT);

-- 12. Hangar occupancy with 'STILL INSIDE' for open records
SELECT a.plane_no, h.hangar_no, ho.check_in_date, 
       IFNULL(ho.check_out_date, 'STILL INSIDE') as check_out_date
FROM HANGAR_OCCUPANCY ho
JOIN AIRPLANE a ON ho.plane_id = a.plane_id
JOIN HANGAR h ON ho.hangar_id = h.hangar_id;

-- 13. Top 3 highest scoring tests
SELECT te.event_id, a.plane_no, te.score
FROM TESTING_EVENT te
JOIN AIRPLANE a ON te.plane_id = a.plane_id
ORDER BY te.score DESC
LIMIT 3;

-- 14. Number of technicians per model (experts)
SELECT m.model_name, COUNT(t.tech_id) as expert_count
FROM MODEL m
LEFT JOIN TECHNICIAN t ON m.model_id = t.expertise_model_id
GROUP BY m.model_name;

-- 15. Test results with PASS/FAIL (pass if score >= 70)
SELECT te.event_id, a.plane_no, ts.test_name, te.score,
       CASE WHEN te.score >= 70 THEN 'PASS' ELSE 'FAIL' END as result
FROM TESTING_EVENT te
JOIN AIRPLANE a ON te.plane_id = a.plane_id
JOIN TEST ts ON te.test_id = ts.test_id;

-- 16. Planes that have been tested in the last 30 days
SELECT plane_no FROM AIRPLANE a
WHERE EXISTS (
    SELECT 1 FROM TESTING_EVENT te 
    WHERE te.plane_id = a.plane_id 
    AND te.test_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
);

-- 17. Technicians who performed more than 1 test
SELECT e.emp_name, COUNT(te.event_id) AS tests_done
FROM TECHNICIAN t
JOIN EMPLOYEE e ON t.emp_id = e.emp_id
LEFT JOIN TESTING_EVENT te ON t.tech_id = te.tech_id
GROUP BY e.emp_name
HAVING COUNT(te.event_id) > 1;

-- 18. Stored procedure: Get full history of a specific airplane
DELIMITER //
CREATE PROCEDURE GetPlaneHistory(IN plane_number VARCHAR(20))
BEGIN
    SELECT a.plane_no, te.test_date, ts.test_name, te.score,
           ho.check_in_date, ho.check_out_date, h.hangar_no
    FROM AIRPLANE a
    LEFT JOIN TESTING_EVENT te ON a.plane_id = te.plane_id
    LEFT JOIN TEST ts ON te.test_id = ts.test_id
    LEFT JOIN HANGAR_OCCUPANCY ho ON a.plane_id = ho.plane_id
    LEFT JOIN HANGAR h ON ho.hangar_id = h.hangar_id
    WHERE a.plane_no = plane_number;
END//
DELIMITER ;

-- Call the procedure (example)
CALL GetPlaneHistory('5Y-KQA');

-- 19. Create and use a view: Plane test summary
CREATE VIEW PlaneTestSummary AS
SELECT a.plane_no, m.model_name, 
       COUNT(te.event_id) AS total_tests,
       AVG(te.score) AS avg_score,
       MAX(te.test_date) AS last_test_date
FROM AIRPLANE a
JOIN MODEL m ON a.model_id = m.model_id
LEFT JOIN TESTING_EVENT te ON a.plane_id = te.plane_id
GROUP BY a.plane_id;

-- Query the view
SELECT * FROM PlaneTestSummary;

-- 20. Monthly test statistics (tests per month and average score)
SELECT YEAR(test_date) AS year, MONTH(test_date) AS month, 
       COUNT(*) AS tests_count, AVG(score) AS avg_score
FROM TESTING_EVENT
GROUP BY YEAR(test_date), MONTH(test_date)
ORDER BY year DESC, month DESC;