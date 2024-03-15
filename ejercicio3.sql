
CREATE TABLE employees (
    empleado  VARCHAR2(5 ) NOT NULL,
    nombre  VARCHAR2(5) NOT NULL

);
CREATE TABLE department_id (
    dept_no  NUMBER(5 ) NOT NULL,
    denombre  VARCHAR2(5) NOT NULL

);
--sin distinct
select * from employees;
SELECT department_id
FROM employees;

--con distinct
SELECT distinct department_id
FROM employees;

--order by
SELECT distinct department_id
FROM employees
ORDER BY department_id DESC;

SELECT first_name,department_id
FROM employees
ORDER BY first_name,department_id;

--GROUP BY avg,max,min,count
SELECT first_name,department_id
FROM employees
GROUP BY department_id;