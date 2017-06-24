-- Jonathan Carrero y Miguel Sánchez-Brunete

/*
  SET AUTOCOMMIT OFF;
  SET SERVEROUTPUT ON SIZE 100000;
  -- Secuencia para el trigger_compras
  CREATE SEQUENCE sec_log INCREMENT BY 1 START WITH 1 NOMAXVALUE;
  DROP SEQUENCE sec_log;
  SELECT sec_log.NEXTVAL FROM dual;
*/

CREATE OR REPLACE TRIGGER trigger_compras

AFTER INSERT ON COMPRAS

FOR EACH ROW

DECLARE
    indice number(38,0); 
BEGIN
    SELECT sec_log.NEXTVAL INTO indice FROM dual;
    INSERT INTO LOGcompra VALUES (indice, :new.DNI, :new.NUMT, :new.NUMF, :new.Fecha, :new.Tienda, :new.Importe);
END;

/

show errors;

/*
CREATE TABLE LOGcompra  (NUMSEC NUMBER (8,0) NOT NULL,
                         DNI NUMBER (38,0),
                         NUMT NUMBER (38,0),
                         NUMF NUMBER (38,0),
                         FECHA NUMBER (38,0),
                         TIENDA CHAR (20),
                         IMPORTE NUMBER (38,0),
                         PRIMARY KEY (NUMSEC));
                         
DROP TABLE LOGcompra CASCADE CONSTRAINTS;
*/