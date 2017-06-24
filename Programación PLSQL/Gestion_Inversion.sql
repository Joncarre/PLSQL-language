-- Jonathan Carrero
/*

SET AUTOCOMMIT ON;
SET SERVEROUTPUT ON;

BEGIN
  Gestion_Inversion('00000008', 'Empresa80', 20, 'bono20');
END;

*/

CREATE OR REPLACE PROCEDURE Gestion_Inversion(dni INVIERTE.DNI%TYPE,
                                              nombree INVIERTE.NOMBREE%TYPE,
                                              cantidad INVIERTE.CANTIDAD%TYPE,
                                              tipo INVIERTE.TIPO%TYPE)
  AS
    contador NUMBER;
    plsql_block VARCHAR(2000);
    nombre_tabla VARCHAR(2000) := trim('inversiones_' || UPPER(nombree));
    nombre_secuencia VARCHAR(2000) := trim('SEQ_' || UPPER(nombree));

BEGIN
   
    -- Creamos la secuencia seq_XXXX
    crea_sec_inversion(nombree);
    -- Creamos la tabla inversiones_XXXX
    crea_tabla_inversiones(nombree);
    
    -- Aumentamos el valor de la secuencia
    plsql_block := 'SELECT ' || nombre_secuencia || '.NEXTVAL FROM DUAL';
    EXECUTE IMMEDIATE plsql_block INTO contador;

    -- Insertamos la fila en la tabla 'nombre_tabla'
    plsql_block := 'INSERT INTO ' || nombre_tabla || ' VALUES (:a, :b, :c, :d, :e)';
    EXECUTE IMMEDIATE plsql_block USING IN contador, dni, nombree, cantidad, tipo;
    
    -- Imprimir por pantalla el resultado de las pruebas
    plsql_block := 'SELECT dni, nombree, cantidad, tipo FROM ' || nombre_tabla;
    EXECUTE IMMEDIATE plsql_block;
    
    -- Hacemos commit
    COMMIT;
END Gestion_Inversion;

/

-- Si hubiese algún error, lo mostramos
show errors
