-- CREACIÓN DE TABLA DEPARTAMENTO --
CREATE TABLE DEPARTAMENTO(
dept_no NUMBER(2) not null,
denombre VARCHAR2(14),
loc  VARCHAR2(14)
 );
 
 -- CREACIÓN DE TABLA EMPLEADOS --
CREATE TABLE Empleados(
emp_no NUMBER(4) not null ,
apellido VARCHAR2(10),
oficio VARCHAR2(10),
dir NUMBER(4),
fecha_alt date ,  
salario number(10),
comisión number(10),
dept_no number(2)not null
);


