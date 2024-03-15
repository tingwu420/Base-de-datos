-- CREACIÓN DE TABLA EMPLEADOS --
CREATE TABLE Empleados(
id_empleados NUMBER(5) not null constraint empleados_pk primary key,
nombre VARCHAR2(10),
apellidos VARCHAR2(10),
salario NUMBER(6),
direccion VARCHAR2(20),
puesto VARCHAR2(30)
);
-- MOdificación de tabla --
ALTER TABLE empleados DROP COLUMN puesto;
ALTER TABLE empleados ADD (fecha DATE);
ALTER TABLE empleados MODIFY (fecha TIMESTAMP);
ALTER TABLE empleados RENAME COLUMN fecha TO fechanueva;


DROP TABLE empleados;

-- CREACIÓN DE TABLA TAREAS --
CREATE TABLE tareas(
OrderID NUMBER(5) not null,
OrderNumber NUMBER(5) not null,
Descripcion VARCHAR2(30),
EmpleadoID number(5),
PRIMARY KEY(OrderID),
CONSTRAINT FK_CustomerOrder
FOREIGN KEY(empleadoID)
REFERENCES empleados(id_empleados)
);

DROP TABLE tareas;

-- TABLA TAREAS2 --
CREATE TABLE tareas2(
OrderID NUMBER(5) PRIMARY KEY,
OrderNumber NUMBER(5) not null,
Descripcion VARCHAR2(30),
EmpleadoID number(5) REFERENCES EMPLEADOS(id_empleados)
);

DROP TABLE tareas2;