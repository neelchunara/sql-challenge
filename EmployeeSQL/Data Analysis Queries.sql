-- 1.List the employee number, last name, first name, sex, and salary of each employee.
SELECT s.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
INNER JOIN salaries AS s
ON s.emp_no = e.emp_no
ORDER BY s.emp_no;

-- 2.List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT DISTINCT ON (dept_manager.dept_no) dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager 
INNER JOIN departments 
ON dept_manager.dept_no= departments.dept_no
INNER JOIN employees 
ON dept_manager.emp_no = employees.emp_no
 ORDER BY dept_manager.dept_no;

-- 4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT DISTINCT ON (e.emp_no) d.dept_no, e.emp_no, e.last_name, e.first_name,d.dept_name
FROM employees as e
LEFT JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no
ORDER BY e.emp_no;

-- 5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT  e.first_name, e.last_name, e.sex
FROM employees as e
WHERE (e.first_name = 'Hercules') AND (LOWER(e.last_name) LIKE 'b%')
ORDER BY e.first_name;

-- Creating table for present departments for each employee which we can use for que 6 and 7.
SELECT DISTINCT ON (emp_no) *
INTO present_dept_emp
FROM dept_emp
ORDER BY emp_no;


-- 6.List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
INNER JOIN  present_dept_emp AS pde
ON e.emp_no = pde.emp_no
INNER JOIN departments AS d
ON pde.dept_no = d.dept_no
WHERE LOWER(d.dept_name) = 'sales';

-- 7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
INNER JOIN present_dept_emp AS pde
ON e.emp_no = pde.emp_no
INNER JOIN departments AS d
ON pde.dept_no = d.dept_no
WHERE (LOWER(d.dept_name) = 'sales') OR (LOWER(d.dept_name) = 'development');

-- 8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name,COUNT(last_name) AS Frequency 
FROM employees 
GROUP BY last_name
ORDER BY frequency DESC;