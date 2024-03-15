CREATE TABLE automático (
    modelo_automático VARCHAR2(50) NOT NULL,
    modelo_modelo_id  NUMBER NOT NULL
);

CREATE UNIQUE INDEX automático__idx ON
    automático (
        modelo_modelo_id
    ASC );

CREATE TABLE coche (
    precio         NUMBER(5,5 ) NOT NULL,
    fecha          DATE NOT NULL,
    color          VARCHAR2(50) NOT NULL,
    potencia       VARCHAR2(50) NOT NULL,
    vendedores_dni VARCHAR2(10) NOT NULL,
    seguro_tipo    VARCHAR2(50) NOT NULL
);

ALTER TABLE coche
    ADD CONSTRAINT coche_pk PRIMARY KEY ( precio,
                                          vendedores_dni,
                                          seguro_tipo );

CREATE TABLE compra (
    coche_precio    NUMBER(2, 2) NOT NULL,
    coche_dni       VARCHAR2(10) NOT NULL,
    coche_tipo      VARCHAR2(50) NOT NULL,
    compradores_dni VARCHAR2(9) NOT NULL
);

ALTER TABLE compra
    ADD CONSTRAINT compra_pk PRIMARY KEY ( coche_precio,
                                           coche_dni,
                                           coche_tipo,
                                           compradores_dni );

CREATE TABLE compradores (
    dni      VARCHAR2(9) NOT NULL,
    nombre   VARCHAR2(50) NOT NULL,
    apellido VARCHAR2(50) NOT NULL,
    teléfono NUMBER(9, 9) NOT NULL
);

ALTER TABLE compradores ADD CONSTRAINT compradores_pk PRIMARY KEY ( dni );

CREATE TABLE concesionario (
    ciudad        VARCHAR2(4) NOT NULL,
    código_postal NUMBER(6, 6) NOT NULL,
    teléfono      NUMBER(9, 9) NOT NULL
);
ALTER TABLE concesionario MODIFY código_postal NUMBER(6) ;
ALTER TABLE concesionario MODIFY teléfono NUMBER(9) ;

ALTER TABLE concesionario ADD CONSTRAINT concesionario_pk PRIMARY KEY ( ciudad );

CREATE TABLE contrato (
    empresa_nombre VARCHAR2(50) NOT NULL,
    seguro_tipo    VARCHAR2(50) NOT NULL
);

ALTER TABLE contrato ADD CONSTRAINT contrato_pk PRIMARY KEY ( empresa_nombre,
                                                              seguro_tipo );

CREATE TABLE empresa (
    nombre    VARCHAR2(50) NOT NULL,
    teléfono  NUMBER(9, 9) NOT NULL,
    localidad VARCHAR2(50) NOT NULL
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
    compacto  VARCHAR2(50) NOT NULL,
    "4X4"     VARCHAR2(50),
    deportivo VARCHAR2(50) NOT NULL,
    familiar  VARCHAR2(50) NOT NULL,
    berlina   VARCHAR2(50) NOT NULL,
    modelo_id NUMBER NOT NULL,
    tipo_caja CHAR(3) NOT NULL
);

ALTER TABLE modelo ADD CONSTRAINT modelo_pk PRIMARY KEY ( modelo_id );

CREATE TABLE seguro (
    tipo     VARCHAR2(50) NOT NULL,
    precio   NUMBER(2, 2) NOT NULL,
    teléfono NUMBER(9, 9) NOT NULL
);

ALTER TABLE seguro ADD CONSTRAINT seguro_pk PRIMARY KEY ( tipo );

CREATE TABLE tiene (
    coche_precio      NUMBER(2, 2) NOT NULL,
    coche_dni         VARCHAR2(10) NOT NULL,
    coche_seguro_tipo VARCHAR2(50) NOT NULL,
    modelo_modelo_id  NUMBER NOT NULL
);

ALTER TABLE tiene
    ADD CONSTRAINT tienev3_pk PRIMARY KEY ( coche_precio,
                                            coche_dni,
                                            coche_seguro_tipo,
                                            modelo_modelo_id );

CREATE TABLE vendedores (
    dni                  VARCHAR2(10) NOT NULL,
    nombre               VARCHAR2(40) NOT NULL,
    teléfono             NUMBER(9, 9) NOT NULL,
    apellido             VARCHAR2(50) NOT NULL,
    concesionario_ciudad VARCHAR2(40) NOT NULL,
    vendedores           VARCHAR2(50) NOT NULL
);
ALTER TABLE vendedores MODIFY teléfono NUMBER(9) ;


ALTER TABLE vendedores ADD CONSTRAINT vendedores_pk PRIMARY KEY ( dni );

ALTER TABLE automático
    ADD CONSTRAINT automático_modelo_fk FOREIGN KEY ( modelo_modelo_id )
        REFERENCES modelo ( modelo_id );

ALTER TABLE coche
    ADD CONSTRAINT coche_seguro_fk FOREIGN KEY ( seguro_tipo )
        REFERENCES seguro ( tipo );

ALTER TABLE coche
    ADD CONSTRAINT coche_vendedores_fk FOREIGN KEY ( vendedores_dni )
        REFERENCES vendedores ( dni );

--ALTER TABLE compra
   -- ADD CONSTRAINT compra_coche_fk FOREIGN KEY ( coche_precio,coche_dni, coche_tipo )
       -- REFERENCES coche ( precio,vendedores_dni,seguro_tipo );

ALTER TABLE compra
    ADD CONSTRAINT compra_compradores_fk FOREIGN KEY ( compradores_dni )
        REFERENCES compradores ( dni );

--ALTER TABLE contrato
   -- ADD CONSTRAINT contrato_empresa_fk FOREIGN KEY ( empresa_nombre )
       -- REFERENCES empresa ( nombre );

ALTER TABLE contrato
    ADD CONSTRAINT contrato_seguro_fk FOREIGN KEY ( seguro_tipo )
        REFERENCES seguro ( tipo );

ALTER TABLE manual
    ADD CONSTRAINT manual_modelo_fk FOREIGN KEY ( modelo_modelo_id )
        REFERENCES modelo ( modelo_id );

ALTER TABLE tiene
    ADD CONSTRAINT tienev3_coche_fk FOREIGN KEY ( coche_precio,
                                                  coche_dni,
                                                  coche_seguro_tipo )
        REFERENCES coche ( precio,
                           vendedores_dni,
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
INSERT INTO concesionario(teléfono,código_postal,ciudad)VALUES(623456530, 29130,'Málaga');
INSERT INTO concesionario(teléfono,código_postal,ciudad)VALUES(695447511, 29001,'Sevilla');
INSERT INTO concesionario(teléfono,código_postal,ciudad)VALUES(678501466, 28004,'Madrid');

--VENDEDORES--
INSERT INTO vendedores(nombre,apellido,teléfono,dni,concesionario_ciudad,vendedores)VALUES('Oscar','Perez',777123456,x77777,'Málaga','primero');
INSERT INTO vendedores(nombre,apellido,teléfono,dni,concesionario_ciudad,vendedores)VALUES('Daniel','Garcia',666123456,x88888,'Sevilla','segundo');
INSERT INTO vendedores(nombre,apellido,teléfono,dni,concesionario_ciudad,vendedores)VALUES('Samuel','Luna',888123456,X99999,'Madrid','tercero');

INSERT INTO coche(nombre,apellido,teléfono,dni,concesionario_ciudad,fehca)VALUES('Oscar','Perez',777123456,x77777,'Málaga','22/01/2024');

