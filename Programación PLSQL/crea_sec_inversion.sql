-- Jonathan Carrero

/*
SET AUTOCOMMIT ON;
SET SERVEROUTPUT ON;
*/

CREATE OR REPLACE PROCEDURE crea_sec_inversion(nombre_empresa empresa.nombree%TYPE)
  AS
    -- Quitamos los espacios en blanco y le añadimos el nombre de la empresa que viene por parámetro
    nombre_secuencia VARCHAR(2000) := trim('SEQ_' || UPPER(nombre_empresa));
    -- Variable para saber si existe la secuencia 
    existe NUMBER (8,0) := 0;
    plsql_block VARCHAR (2000);
         
BEGIN 
    -- Comprobamos si la secuencia existe
    SELECT COUNT (object_name) INTO existe FROM user_objects
    WHERE RTRIM (nombre_secuencia) = object_name;
    
    -- Si no existe...
    IF existe = 0 THEN
      -- La creamos diciendo que comience en 1 y que incremente de 1 en 1
      plsql_block := 'CREATE SEQUENCE ' || nombre_secuencia || ' INCREMENT BY 1 START WITH 1 NOMAXVALUE';
      -- Y la ejecutamos para crearla
      EXECUTE IMMEDIATE plsql_block;
      dbms_output.put_line('---  Secuencia ' || nombre_secuencia || ' creada ');
    -- Si ya existe...
    ELSE
      dbms_output.put_line('--- La secuencia ya existe: ' || nombre_secuencia); 
    END IF;
    
    -- Hacemos el commit
    COMMIT;
END crea_sec_inversion;

/

-- Si hubiese algún error, lo mostramos
show errors
