
--------------------
-- Deliverable 2 --
--------------------
-- 1. Retrieve the emp_no, first_name, and last_name columns from the Employees table
SELECT emp_no, first_name, last_name
FROM employees;

-- 2. Retrieve the title, from_date, and to_date columns from the Titles table.

SELECT title, from_date, to_date
FROM titles;

-- 3. Create a new table using the INTO clause.
-- 4. Join both tables on the primary key.
-- 5. Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.

SELECT e.emp_no,
    e.first_name,
	e.last_name,
    t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees e
INNER JOIN titles t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- 6. Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
-- 7. Before you export your table, confirm that it looks like this image
-- 8. Copy the query from the Employee_Challenge_starter_code.sql and add it to your Employee_Database_challenge.sql file
-- Use Dictinct with Orderby to remove duplicate rows
-- 9. Retrieve the employee number, first and last name, and title columns 
-- from the Retirement Titles table.
-- 10. Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each 
-- set of rows defined by the ON () clause.
-- 11.Create a Unique Titles table using the INTO clause.
-- 12. Sort the Unique Titles table in ascending order by the employee number and descending order 
-- by the last date (i.e. to_date) of the most recent title.
-- 13. Export to .csv
-- 14. Verify before export

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title,
from_date,
to_date
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- 15. Write another query in the Employee_Database_challenge.sql file 
-- to retrieve the number of employees by their most recent job title who are about to retire.

SELECT COUNT (title) AS "Count", title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY "Count" DESC;

--------------------
-- Deliverable 2 --
--------------------

-- 4. Use a DISTINCT ON statement to retrieve the first occurrence of the employee 
-- number for each set of rows defined by the ON () clause.

SELECT DISTINCT ON (e.emp_no) e.emp_no, 
e.first_name, 
e.last_name, 
t.title,
e.birth_date,
de.from_date,
de.to_date
INTO emp_titles
FROM employees e
INNER JOIN dept_emp de
ON (e.emp_no = de.emp_no)
INNER JOIN titles t
ON (e.emp_no = t.emp_no);

-- 6. Filter the data on the to_date column to all the current employees, then filter the data on 
-- the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and
-- December 31, 1965.

SELECT DISTINCT ON (e.emp_no) e.emp_no, 
e.first_name, 
e.last_name, 
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees e
JOIN dept_emp de
ON (e.emp_no = de.emp_no)
JOIN titles t
ON (e.emp_no = t.emp_no)
WHERE (t.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;



