-- Create table of retiring employees from 1952-1955
SELECT e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t 
ON e.emp_no = t.emp_no 
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Get total number of employees for comparision. 
select count (emp_no)
from employees
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no, title) 
emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01' )
ORDER BY emp_no, title ASC, to_date DESC;

-- Get retiring titles by count
CREATE TABLE retiring_titles
AS
	SELECT COUNT(emp_no), title
	FROM unique_titles
	GROUP BY title
	ORDER BY COUNT(title) DESC;

-- Total Count by Comparision 
	SELECT COUNT(emp_no), title
	FROM titles
	GROUP BY title
	ORDER BY COUNT(title) DESC;
	
-- Get table of possible mentoring employees who were born in 1965.	
SELECT DISTINCT ON (e.emp_no) 
e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibilty
FROM employees as e
LEFT JOIN dept_emp as de
ON e.emp_no = de.emp_no
LEFT JOIN titles as t 
ON e.emp_no = t.emp_no 
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp_no ASC;

-- Get list of mentoring employees by title.
	SELECT COUNT(emp_no), title
	FROM mentorship_eligibilty
	GROUP BY title
	ORDER BY COUNT(title) DESC;
