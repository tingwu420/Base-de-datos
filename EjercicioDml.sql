CREATE TABLE nuevo_empleado 
(id NUMBER(4) CONSTRAINT nuevo_empleado_id_nn NOT NULL, last_name VARCHAR2(25), 
first_name VARCHAR2(25), 
userid VARCHAR2(10), 
salary NUMBER(9,2));

drop table nuevo_empleado;
--primer registro
INSERT INTO nuevo_empleado VALUES(1, 'Patel','Ralph','rpatel',895);
INSERT INTO nuevo_empleado VALUES(2, 'Dancs','Betty ','bdancs ',860);
INSERT INTO nuevo_empleado VALUES(3, 'Biri ','Ben ','bbiri ',1100);
INSERT INTO nuevo_empleado VALUES(4, 'Newman ','Chad ','cnewman ',750);
INSERT INTO nuevo_empleado VALUES(5, 'Ropeburn ','Audrey ','aropebur ',1550);

--segundo registro con columnas
INSERT INTO nuevo_empleado(id,last_name,first_name,userid,salary)VALUES(1, 'Patel','Ralph','rpatel',895);
INSERT INTO nuevo_empleado(id,last_name,first_name,userid,salary)VALUES(2, 'Dancs','Betty ','bdancs ',860);
INSERT INTO nuevo_empleado(id,last_name,first_name,userid,salary)VALUES(3, 'Biri ','Ben ','bbiri ',1100);
INSERT INTO nuevo_empleado(id,last_name,first_name,userid,salary)VALUES(4, 'Newman ','Chad ','cnewman ',750);
INSERT INTO nuevo_empleado(id,last_name,first_name,userid,salary)VALUES(5, 'Ropeburn ','Audrey ','aropebur ',1550);

--FILA 3 Y 4--
INSERT INTO nuevo_empleado(id,last_name,first_name,userid,salary)VALUES(3, 'Biri ','Ben ','bbiri ',1100);
INSERT INTO nuevo_empleado(id,last_name,first_name,userid,salary)VALUES(4, 'Newman ','Chad ','cnewman ',750);

--CAMBIO DE APELLIDO--
UPDATE  nuevo_empleado SET last_name ='Martin' WHERE id=3;

--CAMBIAR SALARIO--
UPDATE  nuevo_empleado SET salary=1200  WHERE salary<900;

--ELIMINAR EMPLEADO--
DELETE FROM nuevo_empleado WHERE id=2;

--INSERTAR EMPLEADO--
INSERT INTO nuevo_empleado(id,last_name,first_name,userid,salary)VALUES(7,'Biri','Ben ','bbiri ',1100);

--MOSTRAR TABLA--
SELECT * FROM nuevo_empleado;

DELETE FROM nuevo_empleado;
COMMIT
ROLLBACK
DESC nuevo_empleado;

