--Procedimientos
CREATE OR REPLACE PROCEDURE CINCUENTA AS
BEGIN
FOR i IN 1.. 50 LOOP
   DBMS_OUTPUT.PUT_LINE(i);
END LOOP;
END;

--llamada
BEGIN
CINCUENTA;
END;

CREATE OR REPLACE PROCEDURE SUMA(num1 IN INTEGER,num2 IN INTEGER, res OUT INTEGER) 
AS

BEGIN 
 res :=num1+num2;
END;
--Llamada
DECLARE
v_res INTEGER;
BEGIN
suma(5,2,v_res);
 DBMS_OUTPUT.PUT_LINE('Resultado='||v_res);

END;

--Funciones
CREATE OR REPLACE FUNCTION F_SUMA(num1 IN INTEGER,num2 IN INTEGER)RETURN INTEGER
AS
v_res INTEGER;
BEGIN
v_res:= num1+num2;
   return v_res;
END;
--Llamada
DECLARE
v_res INTEGER;
BEGIN
 v_res:= F_SUMA(5,3);
  DBMS_OUTPUT.PUT_LINE('Resultado='||v_res);
END;

--Ejercicio procedimientos--
--Ej 1--
CREATE OR REPLACE PROCEDURE INTERCAMBIO(a OUT INTEGER, b OUT INTEGER) AS
temp INTEGER;
BEGIN
a:=temp;
a:=b;
b:=temp;
END;


--Llamada
DECLARE 
temp INTEGER;
a INTEGER :=30;
b INTEGER :=5;
BEGIN 
INTERCAMBIO(a,b);
DBMS_OUTPUT.PUT_LINE('A='||a||b||'B');

END;

--Ej 2--
CREATE OR REPLACE PROCEDURE NUMERO(num1  INTEGER, num2  INTEGER) AS

BEGIN

IF(num1>num2)THEN
DBMS_OUTPUT.PUT_LINE('El numero '||num1||' es mayor que '||num2);
ELSIF(num1<num2)THEN
DBMS_OUTPUT.PUT_LINE('El numero '||num2||' es mayor que '||num1);
 END IF;
END;

--Llamada
DECLARE 

num1 NUMBER:=2;
num2 NUMBER:=5;
BEGIN
NUMERO(num1,num2);

END;


--Ej 3--
CREATE OR REPLACE PROCEDURE CADENA(palabra VARCHAR2) AS
v_longitud INTEGER:=0;
BEGIN
 v_longitud := length(palabra);
  IF (v_longitud) > 15 THEN
  DBMS_OUTPUT.PUT_LINE('La longitud de la cadena es mayor de 15.');
    ELSIF (v_longitud) < 15 THEN
    DBMS_OUTPUT.PUT_LINE('La longitud de la cadena es menor de 15');
    END IF;
END;

DECLARE
palabra VARCHAR2(70):='qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq';

BEGIN
CADENA(palabra);
END;

--Ej 4--
CREATE OR REPLACE PROCEDURE ListarNumero(numero IN INTEGER) AS

BEGIN
   FOR I IN 0.. numero LOOP
    DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;


BEGIN
ListarNumero(50);
END;

--Ej 5--
CREATE OR REPLACE PROCEDURE DividirNumero(dividendo NUMBER, divisor NUMBER,cociente OUT NUMBER, resto OUT NUMBER) AS

BEGIN
      cociente := dividendo/divisor;
      resto:=MOD(dividendo,divisor);

END;

DECLARE
  dividendo number(3):=18;
  divisor number(3):=4;
  cociente number(3,2);
  resto number(3,2);
  
BEGIN
DividirNumero(dividendo,divisor,cociente,resto);
    DBMS_OUTPUT.PUT_LINE('Dividendo: '||dividendo);
    DBMS_OUTPUT.PUT_LINE('Divisor: '||divisor);
    DBMS_OUTPUT.PUT_LINE('Cociente: '||cociente);
    DBMS_OUTPUT.PUT_LINE('Resto: '||resto);
END;

--Funciones--
--Ej 6--
CREATE OR REPLACE FUNCTION MayorNumero(num1 IN INTEGER,num2 IN INTEGER, v_res IN INTEGER)RETURN INTEGER
AS
v_mayor integer;
BEGIN
  IF(num1 >num2)THEN
   v_mayor:= num1;
  ELSIF(num2>num1)THEN
   v_mayor:=num2;
  ELSE 
   v_mayor:=0;
   END IF; 
  RETURN v_mayor;
END;
--Llamada

BEGIN
    DBMS_OUTPUT.PUT_LINE(MayorNumero(10,5,v_res));
    v_res:=MayorNumero(10,5);
    MayorNumero(10,5,v_res);
END;

--Ej 7--
CREATE OR REPLACE FUNCTION Multiplo(num1 IN INTEGER,num2 IN INTEGER)RETURN BOOLEAN
AS
v_multiplo BOOLEAN := FALSE;
BEGIN
  v_multiplo:= MOD(num1,num2)=0;
  return v_multiplo;
END;

--Llamada

BEGIN
     IF(Multiplo(10,5))THEN
       DBMS_OUTPUT.PUT_LINE('TRUE');

  ELSE 
  DBMS_OUTPUT.PUT_LINE('False');  
  END IF; 

END;

--Ej 8--
CREATE OR REPLACE FUNCTION Modificado(cadena varchar2)RETURN VARCHAR2
AS
nueva_cadena VARCHAR2(50);
BEGIN
   nueva_cadena := SUBSTR(cadena,1,15)||' Modificado';
   return nueva_cadena;
END;


BEGIN
  DBMS_OUTPUT.PUT_LINE(Modificado('Hola esto es una cadena de prueba'));
END;


--Calculadora--
CREATE OR REPLACE FUNCTION Sumar(num1 IN INTEGER,num2 IN INTEGER, v_res IN INTEGER)RETURN INTEGER
AS
v_res INTEGER;
BEGIN
 v_res := num1+ num2;
 RETURN v_res;
END;

CREATE OR REPLACE FUNCTION Restar(num1 IN INTEGER,num2 IN INTEGER, v_res IN INTEGER)RETURN INTEGER
AS
v_res INTEGER;
BEGIN
 v_res := num1- num2;
 RETURN v_res;
END;

CREATE OR REPLACE FUNCTION Multiplicar(num1 IN INTEGER,num2 IN INTEGER, v_res IN INTEGER)RETURN INTEGER
AS
v_res INTEGER;
BEGIN
 v_res := num1+ num2;
 RETURN v_res;
END;

CREATE OR REPLACE FUNCTION Dividir(num1 IN INTEGER,num2 IN INTEGER, v_res IN INTEGER)RETURN INTEGER
AS
v_res INTEGER;
BEGIN
 v_res := num1 / num2;
 RETURN v_res;
END;

DECLARE
opcion integer;
resultado number (10,2);
v_num1 integer;
v_num2 integer;

BEGIN
opcion :=&opcion;
v_num1 :=&num;
v_num2 :=&num;

CASE 
WHEN opcion = 1 THEN v_resultado := Sumar(v_num1,v_num2);
WHEN opcion = 2 THEN v_resultado := Resar(v_num1,v_num2);
WHEN opcion = 3 THEN v_resultado := Multiplicar(v_num1,v_num2);
WHEN opcion = 4 THEN v_resultado := Dividir(v_num1,v_num2);


END CASE;
  DBMS_OUTPUT.PUT_LINE('El resultado es '||v_resultado);

END;