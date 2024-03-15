DECLARE
  cadena VARCHAR2(30) := 'Esto es una cadena';
  longitud NUMBER(3);
BEGIN
   longitud :=length(cadena);
   dbms_output.put_line(longitud);
   BEGIN
    dbms_output.put_line(longitud+1);
    END;
END;

DECLARE
 -- numero NUMBER(3) :=50;
  numero NUMBER(3);
  nombre VARCHAR2(30) :='JUAN';
BEGIN
   numero :=50;
   dbms_output.put_line('Mi nombre es:'|| nombre);
END;

DECLARE
 -- numero NUMBER(3) :=50;
  numero NUMBER(3);
  nombre VARCHAR2(30) :='&nuevonombre';
BEGIN
   numero :=50;
   dbms_output.put_line('Mi nombre es:'|| nombre);
END;

--Sustituye el varchar2
DECLARE
 -- numero NUMBER(3) :=50;
  numero NUMBER(3);
  nombre employees.first_name%TYPE :='&nuevonombre';
BEGIN
   numero :=50;
   dbms_output.put_line('Mi nombre es:'|| nombre);
END;

--Practica 1-3
DECLARE


BEGIN

   dbms_output.put_line('Mi primer bloque es:PL/SQL');
END;

--Practica 1-4
DECLARE
  v_char VARCHAR2 (30) :='42 is the literal';
  v_num NUMBER(3):= length(v_char);
BEGIN   

   dbms_output.put_line(v_char|| to_char(v_num));
END;

--Practica 2-1
DECLARE


BEGIN

   dbms_output.put_line('Hola Mundo');
END;

--Practica 2-2
DECLARE
 
  nombre VARCHAR2(30) :='&nuevonombre';
   edad NUMBER(3):='&nuevoedad';
BEGIN
   
   dbms_output.put_line('Buenas tarde '|| nombre || ' tienes '|| edad||' años');
 
   
END;

--Practica 2-3
DECLARE
 
  num1 NUMBER(3) :='&nuevonum';
  num2 NUMBER(3):='&nuevonum';
  
BEGIN
   
 dbms_output.put_line(num1+num2);
 dbms_output.put_line(num1-num2);
 dbms_output.put_line(num1*num2);
 dbms_output.put_line(num1/num2);
 dbms_output.put_line(num1**num2);
 
   
END;

--Practica 2-4
DECLARE
 
  nombre employees.first_name%TYPE :='&nuevonombre';
  apellido employees.last_name%TYPE :='&nuevoapellido';
  identificador employees.job_id%TYPE :='&nuevonid';
BEGIN
  
   dbms_output.put_line('Mi nombre es:'|| nombre);
   dbms_output.put_line('Mi apelldo es:'|| apellido);
   dbms_output.put_line('Mi id es:'|| identificador);
END;

--Practica 3-1
DECLARE
  num1 NUMBER(3) :='&nuevonum';
  num2 NUMBER(3):='&nuevonum';

BEGIN
   if (num1>num2) THEN
   dbms_output.put_line('El numero '||num1||' es mayor');
   ELSIF (num2>num1) THEN
    dbms_output.put_line('El numero '||num2||' es mayor');
    ELSIF (num1=num2) THEN
    dbms_output.put_line('son iguales');
    END if;
END;

--Practica 3-2
DECLARE
  golcasa NUMBER(3) :='&nuevogol';
  golfuera NUMBER(3):='&nuevogol';

BEGIN
   if (golcasa>golfuera) THEN
   dbms_output.put_line('Gol de casa: '||golcasa|| ' Gol de fuera: '||golfuera|| ' Signo de quiniela:1');
   ELSIF (golfuera>golcasa) THEN
   dbms_output.put_line('Gol de casa: '||golcasa|| ' Gol de fuera: '||golfuera|| ' Signo de quiniela:2');
 ELSIF (golcasa=golfuera) THEN
     dbms_output.put_line('Gol de casa: '||golcasa|| ' Gol de fuera: '||golfuera||  ' Signo de quiniela:X');
    END if;
END;

--Practica 3-3
DECLARE
 
  num1 NUMBER(3) :='&nuevonum';
  num2 NUMBER(3):='&nuevonum';
 
  opcion NUMBER(1);
BEGIN
 
   dbms_output.put_line('1.SUMA 2.RESTA 3.MULTIPLICACION');
   opcion:='&opcion';
   if (opcion=1) THEN
  dbms_output.put_line(num1+num2);
   ELSIF (opcion=2) THEN
    dbms_output.put_line(num1-num2);
    ELSIF (opcion=3) THEN
    dbms_output.put_line(num1*num2);
    ELSE 
    dbms_output.put_line('operacion no permitida');

    END if;
END;

--CASE
DECLARE
 
  num1 NUMBER(3) :='&nuevonum';
  num2 NUMBER(3) :='&nuevonum';
  opcion NUMBER(1);
BEGIN
  dbms_output.put_line('1.SUMA 2.RESTA 3.MULTIPLICACION');
     opcion:='&opcion';
  CASE opcion
     when 1 THEN dbms_output.put_line(num1+num2);
     when 2 THEN dbms_output.put_line(num1-num2);
     when 3 THEN dbms_output.put_line(num1*num2);
       ELSE 
    dbms_output.put_line('operacion no permitida');

     end case;
 END;
 
 --Practica 3-4
 DECLARE
 
  num1 NUMBER(3) :='&nuevonum';
 
BEGIN
 
   if (num1<0) THEN
  dbms_output.put_line('El numero es negtivo');
   ELSIF (num1>0) THEN
    dbms_output.put_line('El numero es positivo');
    ELSIF (num1=0) THEN
    dbms_output.put_line('El numero es cero');

    END if;
END;

--Practica 3-5
DECLARE
 
  num1 NUMBER(3) :='&nuevonum';
  num2 NUMBER(3) :='&nuevonum';
  num3 NUMBER(3) :='&nuevonum';

BEGIN
     IF((num1<num2) AND (num2<num3)) THEN
       dbms_output.put_line('El numero esta ordenada de forma ascendente');
     ELSE 
       dbms_output.put_line('El numero no esta ordenado');
     END IF;
 END;
 
 --Practica 3-6
 DECLARE
 
  salario NUMBER(4) :='&nuevonum';

BEGIN
     IF((salario>1000) AND (salario<2000)) THEN
       dbms_output.put_line('El salario esta entre 1000 y 2000');
     ELSIF ((salario>2000) AND (salario<3000)) THEN
       dbms_output.put_line('El salario esta entre 2000 y 3000');
     ELSIF ((salario>3000) AND (salario<4000)) THEN
       dbms_output.put_line('El salario esta entre 3000 y 4000');
     ELSIF ((salario>5000)) THEN
       dbms_output.put_line('El salario es mayor de 5000');
       END IF;
 END;
 
 --Practica 3-7
 DECLARE
 
  num1 NUMBER(3) :='&nuevonum';
  num2 NUMBER(3) :='&nuevonum';
  num3 NUMBER(3) :='&nuevonum';


BEGIN
     IF((num1>num2) AND (num2>num3)) THEN
       dbms_output.put_line('||num1||' ,' ||num2 ||', '||num3||');
     ELSIF ((num1>num2) AND (num2<num3)) THEN
       dbms_output.put_line('num1>num3>num2');
     ELSIF ((num1>num3) AND (num2<num3)) THEN
       dbms_output.put_line('num2>num3>num1');
     ELSIF ((num1<num2) AND (num2<num3)) THEN
       dbms_output.put_line('num2>num3>num1');
       END IF;
 END;