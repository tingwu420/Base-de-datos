CREATE TABLE automático (
    modelo_automático VARCHAR2(5) NOT NULL,
    modelo_modelo_id  NUMBER NOT NULL
);

CREATE UNIQUE INDEX automático__idx ON
    automático (
        modelo_modelo_id
    ASC );

CREATE TABLE coche (
    precio         NUMBER(5 ) NOT NULL,
    fecha          DATE NOT NULL,
    color          VARCHAR2(6) NOT NULL,
    potencia       NUMBER(3) NOT NULL,
    seguro_tipo    VARCHAR2(5) NOT NULL
);


ALTER TABLE coche
    ADD CONSTRAINT coche_pk PRIMARY KEY ( precio,
                                          seguro_tipo );

CREATE TABLE compra (
    coche_precio    NUMBER(5) NOT NULL,
    coche_tipo      VARCHAR2(8) NOT NULL,
    compradores_dni VARCHAR2(8) NOT NULL
);


ALTER TABLE compra
    ADD CONSTRAINT compra_pk PRIMARY KEY ( coche_precio,
                                           coche_tipo,
                                           compradores_dni );

CREATE TABLE compradores (
    dni      VARCHAR2(8) NOT NULL,
    nombre   VARCHAR2(5) NOT NULL,
    apellido VARCHAR2(5) NOT NULL,
    teléfono NUMBER(9) NOT NULL
);


ALTER TABLE compradores ADD CONSTRAINT compradores_pk PRIMARY KEY ( dni );

CREATE TABLE concesionario (
    ciudad        VARCHAR2(4) NOT NULL,
    código_postal NUMBER(6) NOT NULL,
    teléfono      NUMBER(9) NOT NULL,
    PRIMARY KEY (ciudad)
);

CREATE TABLE contrato (
    empresa_nombre VARCHAR2(5) NOT NULL,
    seguro_tipo    VARCHAR2(5) NOT NULL
);


ALTER TABLE contrato ADD CONSTRAINT contrato_pk PRIMARY KEY ( empresa_nombre,
                                                              seguro_tipo );

CREATE TABLE empresa (
    nombre    VARCHAR2(5) NOT NULL,
    teléfono  NUMBER(9) NOT NULL,
    localidad VARCHAR2(5) NOT NULL
);


ALTER TABLE empresa ADD CONSTRAINT empresa_pk PRIMARY KEY ( nombre );

CREATE TABLE manual (
    modelo_manual    VARCHAR2(50) NOT NULL,
    modelo_modelo_id NUMBER NOT NULL
);


CREATE UNIQUE INDEX manual__idx ON
    manual (
        modelo_modelo_id
    ASC );

ALTER TABLE manual ADD CONSTRAINT manual_pk PRIMARY KEY ( modelo_manual );

CREATE TABLE modelo (
    compacto  VARCHAR2(5) ,
    "4X4"     VARCHAR2(5),
    deportivo VARCHAR2(5) ,
    familiar  VARCHAR2(5) ,
    berlina   VARCHAR2(5) ,
    modelo_id NUMBER NOT NULL,
    tipo_caja CHAR(5) NOT NULL
);


ALTER TABLE modelo ADD CONSTRAINT modelo_pk PRIMARY KEY ( modelo_id );

CREATE TABLE seguro (
    tipo     VARCHAR2(5) NOT NULL,
    precio   NUMBER(3) NOT NULL,
    teléfono NUMBER(9) NOT NULL
);


ALTER TABLE seguro ADD CONSTRAINT seguro_pk PRIMARY KEY ( tipo );

CREATE TABLE tiene (
    coche_precio      NUMBER(3) NOT NULL,
    coche_dni         VARCHAR2(8),
    coche_seguro_tipo VARCHAR2(5) NOT NULL,
    modelo_modelo_id  NUMBER(1) NOT NULL
);


ALTER TABLE tiene
    ADD CONSTRAINT tienev3_pk PRIMARY KEY ( coche_precio,
                                            coche_dni,
                                            coche_seguro_tipo,
                                            modelo_modelo_id );

CREATE TABLE vendedores (
    dni                  VARCHAR2(8) NOT NULL,
    nombre               VARCHAR2(5) NOT NULL,
    teléfono             NUMBER(9) NOT NULL,
    apellido             VARCHAR2(5) NOT NULL,
    concesionario_ciudad VARCHAR2(4) NOT NULL,
    PRIMARY KEY (dni)
);


--ALTER TABLE automático
   -- ADD CONSTRAINT automático_modelo_fk FOREIGN KEY ( modelo_modelo_id )
     --   REFERENCES modelo ( modelo_id );

ALTER TABLE coche
    ADD CONSTRAINT coche_seguro_fk FOREIGN KEY ( seguro_tipo )
        REFERENCES seguro ( tipo );


--ALTER TABLE compra
    --ADD CONSTRAINT compra_coche_fk FOREIGN KEY ( coche_precio, coche_tipo )
       -- REFERENCES coche ( precio,seguro_tipo );

--ALTER TABLE compra
   --ADD CONSTRAINT compra_compradores_fk FOREIGN KEY ( compradores_dni )
       -- REFERENCES compradores ( dni );

ALTER TABLE contrato
    ADD CONSTRAINT contrato_empresa_fk FOREIGN KEY ( empresa_nombre )
        REFERENCES empresa ( nombre );

--ALTER TABLE contrato
 --   ADD CONSTRAINT contrato_seguro_fk FOREIGN KEY ( seguro_tipo )
 --       REFERENCES seguro ( tipo );

ALTER TABLE manual
    ADD CONSTRAINT manual_modelo_fk FOREIGN KEY ( modelo_modelo_id )
        REFERENCES modelo ( modelo_id );

ALTER TABLE tiene
    ADD CONSTRAINT tienev3_coche_fk FOREIGN KEY ( coche_precio,
                                                  coche_seguro_tipo )
        REFERENCES coche ( precio,
                           seguro_tipo );

ALTER TABLE tiene
    ADD CONSTRAINT tienev3_modelo_fk FOREIGN KEY ( modelo_modelo_id )
        REFERENCES modelo ( modelo_id );

ALTER TABLE vendedores
   ADD CONSTRAINT vendedores_concesionario_fk FOREIGN KEY ( concesionario_ciudad )
       REFERENCES concesionario ( ciudad );


CREATE OR REPLACE TRIGGER arc_arc_1_automático BEFORE
    INSERT OR UPDATE OF modelo_modelo_id ON automático
    FOR EACH ROW
DECLARE
    d CHAR(3);
BEGIN
    SELECT
        a.tipo_caja
    INTO d
    FROM
        modelo a
    WHERE
        a.modelo_id = :new.modelo_modelo_id;

    IF ( d IS NULL OR d <> 'AUT' ) THEN
        raise_application_error(-20223, 'FK AUTOMÁTICO_MODELO_FK in Table AUTOMÁTICO violates Arc constraint on Table MODELO - discriminator column TIPO_CAJA doesn''t have value ''AUT'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_1_manual BEFORE
    INSERT OR UPDATE OF modelo_modelo_id ON manual
    FOR EACH ROW
DECLARE
    d CHAR(3);
BEGIN
    SELECT
        a.tipo_caja
    INTO d
    FROM
        modelo a
    WHERE
        a.modelo_id = :new.modelo_modelo_id;

    IF ( d IS NULL OR d <> 'MNL' ) THEN
        raise_application_error(-20223, 'FK MANUAL_MODELO_FK in Table MANUAL violates Arc constraint on Table MODELO - discriminator column TIPO_CAJA doesn''t have value ''MNL'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE SEQUENCE modelo_modelo_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER modelo_modelo_id_trg BEFORE
    INSERT ON modelo
    FOR EACH ROW
    WHEN ( new.modelo_id IS NULL )
BEGIN
    :new.modelo_id := modelo_modelo_id_seq.nextval;
END;
/

--CONCESIONARIO--
INSERT INTO concesionario(teléfono,código_postal,ciudad)VALUES(623456530, 29130,'Mala');
INSERT INTO concesionario(teléfono,código_postal,ciudad)VALUES(695447511, 29001,'Sevi');
INSERT INTO concesionario(teléfono,código_postal,ciudad)VALUES(678501466, 28004,'Madr');
INSERT INTO concesionario(teléfono,código_postal,ciudad)VALUES(952411750, 26104,'Vale');
INSERT INTO concesionario(teléfono,código_postal,ciudad)VALUES(680952488, 38204,'Barc');

--VENDEDORES--
INSERT INTO vendedores(nombre,apellido,teléfono,dni,concesionario_ciudad)VALUES('Salvi','Perez',677123456,'x777777v','Mala');
INSERT INTO vendedores(nombre,apellido,teléfono,dni,concesionario_ciudad)VALUES('Danie','Garci',666123456,'c555556a','Sevi');
INSERT INTO vendedores(nombre,apellido,teléfono,dni,concesionario_ciudad)VALUES('Samue','Lunas',888123456,'q999999v','Madr');
INSERT INTO vendedores(nombre,apellido,teléfono,dni,concesionario_ciudad)VALUES('Santi','Gomez',777524333,'a452345p','Vale');
INSERT INTO vendedores(nombre,apellido,teléfono,dni,concesionario_ciudad)VALUES('Frank','Lopez',958123456,'q111111v','Barc');


--COMPRADORES--
INSERT INTO compradores(dni,nombre,apellido,teléfono)VALUES('x123456v','Danie','Perez',123456789);
INSERT INTO compradores(dni,nombre,apellido,teléfono)VALUES('x234567v','Frank','Gucci',452173389);
INSERT INTO compradores(dni,nombre,apellido,teléfono)VALUES('n123456y','Samue','Garci',826456789);
INSERT INTO compradores(dni,nombre,apellido,teléfono)VALUES('q853456f','Crist','Diazs',555123444);
INSERT INTO compradores(dni,nombre,apellido,teléfono)VALUES('n124578g','Noeli','Garci',555598766);

--SEGUROS--
INSERT INTO seguro(tipo,precio,teléfono)VALUES('robos',120,523456789);
INSERT INTO seguro(tipo,precio,teléfono)VALUES('segur',149,789456654);
INSERT INTO seguro(tipo,precio,teléfono)VALUES('confr',220,660851227);
INSERT INTO seguro(tipo,precio,teléfono)VALUES('incen',520,952477105);
INSERT INTO seguro(tipo,precio,teléfono)VALUES('sinfr',315,952466871);
--COCHE--
INSERT INTO coche(precio,fecha,color,potencia,seguro_tipo)VALUES(11000,'16/02/2023','naranj',200,'robos');
INSERT INTO coche(precio,fecha,color,potencia,seguro_tipo)VALUES(55000,'11/04/2022','azules',450,'segur');
INSERT INTO coche(precio,fecha,color,potencia,seguro_tipo)VALUES(32000,'06/09/2019','morado',190,'confr');
INSERT INTO coche(precio,fecha,color,potencia,seguro_tipo)VALUES(65300,'29/08/2013','negros',163,'incen');
INSERT INTO coche(precio,fecha,color,potencia,seguro_tipo)VALUES(89000,'30/07/2021','blanco',750,'sinfr');


--COMPRA--
INSERT INTO compra(coche_precio,coche_tipo,compradores_dni)VALUES(32000,'automa','x123456v');
INSERT INTO compra(coche_precio,coche_tipo,compradores_dni)VALUES(55600,'manual','n124578g');
INSERT INTO compra(coche_precio,coche_tipo,compradores_dni)VALUES(41560,'automa','q111121v');
INSERT INTO compra(coche_precio,coche_tipo,compradores_dni)VALUES(78640,'manual','n123456y');



--EMMPRESA--
INSERT INTO empresa(nombre,teléfono,localidad)VALUES('bilba',888123456,'malag');
INSERT INTO empresa(nombre,teléfono,localidad)VALUES('direc',999888777,'madri');
INSERT INTO empresa(nombre,teléfono,localidad)VALUES('catal',777666555,'valen');
INSERT INTO empresa(nombre,teléfono,localidad)VALUES('pelay',555444333,'barce');
INSERT INTO empresa(nombre,teléfono,localidad)VALUES('reale',333222111,'sevil');

--CONTRATOS--
INSERT INTO contrato(empresa_nombre,seguro_tipo)VALUES('bilba','robos');
INSERT INTO contrato(empresa_nombre,seguro_tipo)VALUES('direc','segur');
INSERT INTO contrato(empresa_nombre,seguro_tipo)VALUES('catal','confr');
INSERT INTO contrato(empresa_nombre,seguro_tipo)VALUES('pelay','incen');
INSERT INTO contrato(empresa_nombre,seguro_tipo)VALUES('reale','sinfr');

--MODELOS--
INSERT INTO modelo(modelo_id,tipo_caja)VALUES(1,'aut');
INSERT INTO modelo(modelo_id,tipo_caja)VALUES(2,'man');
INSERT INTO modelo(modelo_id,tipo_caja)VALUES(3,'aut');
INSERT INTO modelo(modelo_id,tipo_caja)VALUES(4,'man');
INSERT INTO modelo(modelo_id,tipo_caja)VALUES(5,'aut');


COMMIT;
ROLLBACK;

--COCHE--
UPDATE  coche SET precio=56000  WHERE precio<40000;
DELETE FROM coche WHERE precio=32000;
COMMIT;

--COMPRA--
UPDATE  compra SET coche_precio=56000  WHERE coche_precio<40000;
DELETE FROM compra WHERE coche_precio=56000;
COMMIT;

--COMPRADORES--
UPDATE  compradores SET dni='p253456v'  WHERE dni='x123456v';
DELETE FROM compradores WHERE teléfono=123456789;
COMMIT;

--CONCESIONARIO--
UPDATE  concesionario SET teléfono=680951227  WHERE teléfono=623456530;
DELETE FROM concesionario WHERE teléfono=623456530;
COMMIT;

--CONTRATO--
UPDATE  contrato SET empresa_nombre='bilba'  WHERE empresa_nombre='direc';
DELETE FROM contrato WHERE empresa_nombre='bilba';
COMMIT;

--EMPRESA--
UPDATE  empresa SET teléfono=952411706  WHERE teléfono=888123456;
DELETE FROM empresa WHERE teléfono=888123456 ;
COMMIT;

--MODELO--
UPDATE  modelo SET modelo_id=6  WHERE modelo_id=1;
DELETE FROM modelo WHERE modelo_id=2;
COMMIT;

--SEGURO--
UPDATE  seguro SET tipo='incen'  WHERE precio<40000;
DELETE FROM seguro WHERE precio<40000;
COMMIT;

--TIENE--
UPDATE  coche SET precio=56000  WHERE precio<40000;
DELETE FROM coche WHERE precio<40000;
COMMIT;

--VENDEDORES--
UPDATE  vendedores SET teléfono=952411708  WHERE teléfono=677123456;
DELETE FROM vendedores WHERE teléfono=677123456;
COMMIT;

--Consulta básica--
SELECT * FROM coche;
SELECT * FROM compradores;
SELECT * FROM concesionario;
SELECT * FROM contrato;
SELECT * FROM empresa;
SELECT * FROM seguro;
SELECT * FROM vendedores;

--WHERE--
SELECT * 
FROM coche 
WHERE color LIKE 'az%';

SELECT * 
FROM compradores 
WHERE nombre LIKE 'Da%';

SELECT * 
FROM concesionario 
WHERE ciudad LIKE 'Ma%';

SELECT * 
FROM contrato 
WHERE empresa_nombre LIKE 'bilba%';

SELECT * 
FROM empresa 
WHERE nombre LIKE 'cata%';

SELECT * 
FROM seguro
WHERE tipo LIKE 'robos%';

SELECT * 
FROM vendedores 
WHERE apellido LIKE 'Lopez%';

--AVG,SUM,MAX,MIN,COUNT--
SELECT AVG(potencia) 
FROM coche;

SELECT color, SUM(precio) 
FROM coche
GROUP BY color
HAVING SUM(precio) > 50000;

SELECT fecha, MAX(precio)
FROM coche
GROUP BY fecha
ORDER BY fecha;

SELECT potencia, MIN(precio)
FROM coche
GROUP BY potencia
ORDER BY potencia;

SELECT  COUNT(*) 
FROM vendedores;

--JOIN--

SELECT coche.*, compra.*
FROM coche JOIN compra 
ON coche.precio = compra.coche_precio;

SELECT contrato.*, seguro.*
FROM contrato JOIN seguro 
ON contrato.seguro_tipo = seguro.tipo

SELECT contrato.*, empresa.*
FROM contrato JOIN empresa 
ON contrato.empresa_nombre = empresa.nombre;

SELECT compradores.*, compra.*
FROM compradores JOIN compra 
ON compradores.dni = compra.compradores_dni

SELECT coche.*, seguro.*
FROM coche JOIN seguro 
ON coche.seguro_tipo = seguro.tipo;

--OUTER JOIN--
SELECT coche.*, seguro.*
FROM coche LEFT OUTER JOIN seguro 
ON coche.seguro_tipo = seguro.tipo;

SELECT compradores.*, compra.*
FROM compradores LEFT OUTER JOIN compra 
ON compradores.dni = compra.compradores_dni

SELECT empresa.*, contrato.*
FROM empresa RIGHT OUTER JOIN contrato 
ON empresa.nombre = contrato.empresa_nombre

--SUBCONSULTAS--
SELECT *
FROM coche
WHERE seguro_tipo IN (SELECT tipo FROM seguro WHERE precio > 200);

SELECT *
FROM compradores
WHERE teléfono > (SELECT AVG(teléfono) FROM compradores);

SELECT *
FROM coche
WHERE seguro_tipo IN (SELECT tipo FROM seguro WHERE tipo = 'incen');
