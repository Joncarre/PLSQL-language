-- Jonathan Carrero
/*
SET AUTOCOMMIT ON;
SET SERVEROUTPUT ON;
*/

CREATE OR REPLACE PROCEDURE crea_tabla_inversiones(nombre_empresa empresa.nombree%TYPE)
  AS
    -- Creamos el nombre de la tabla que queremos crear
    nombre_tabla VARCHAR(2000) := trim('inversiones_' || UPPER(nombre_empresa));
    -- Variable para saber si existe la secuencia 
    existe NUMBER (8,0) := 0;
    plsql_block VARCHAR (2000);

BEGIN
    -- Comprobamos si ya existe una tabla con ese nombre
    SELECT COUNT (table_name) INTO existe FROM tabs
    WHERE RTRIM (nombre_tabla) = table_name;
    -- Si no existe...
    IF existe = 0 THEN
      plsql_block := 'CREATE TABLE ' || nombre_tabla || 
                                                        ' (NUMSEC NUMBER (8,0) NOT NULL,
                                                        DNI CHAR (8),
                                                        NOMBREE CHAR (20),
                                                        CANTIDAD FLOAT,
                                                        TIPO CHAR (10),
                                                        PRIMARY KEY (NUMSEC))';
      EXECUTE IMMEDIATE plsql_block;
      dbms_output.put_line('--- Tabla ' || nombre_tabla || ' creada ');
    -- Si existe...
    ELSE
      dbms_output.put_line('--- La tabla ya existe: ' || nombre_tabla);
    END IF;

    -- Hacemos commit
    COMMIT;
END crea_tabla_inversiones;

/

-- Si hubiese algún error, lo mostramos
show errors
