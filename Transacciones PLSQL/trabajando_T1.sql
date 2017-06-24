-- Jonathan Carrero

/*
  SET AUTOCOMMIT OFF;
  SET SERVEROUTPUT ON SIZE 100000;
  -- Secuencia 1 para transacción 1
  CREATE SEQUENCE sec_T1 MINVALUE 0 MAXVALUE 1  START WITH 0 INCREMENT BY 1 cycle nocache;
  SELECT sec_T1.NEXTVAL FROM dual;
  -- Probar trabajando_T1
  BEGIN
    trabajando_T1(5);
  END;
*/

CREATE OR REPLACE PROCEDURE trabajando_T1(segundos NUMBER)
  AS
    -- Almacenará el id de la transacción
    id_transaccion CHAR(24);
    -- Irá almacenando el valor anterior al valor actual de la secuencia (como al principio no hay valor anterior, se inicializa a -1)
    sec_anterior NUMBER := -1;
    -- Irá almacenando el valor actual de la secuencia
    sec_actual NUMBER;
BEGIN
  LOOP
    -- Seleccionamos el valor actual de la sec_T1
    SELECT sec_T1.NEXTVAL INTO sec_actual FROM dual;
    -- Si coincide con el valor actual, entonces es que "alguien" lo ha modificado
    IF sec_anterior = sec_actual THEN 
      EXIT;
    ELSE
      -- Si no coincide, actualizamos la secuencia anterior
      sec_anterior := sec_actual;
      -- Y le decimos a la transacción que se duerma
      sys.dbms_lock.sleep(segundos);
    END IF;
  END LOOP;
  -- Si hemos salido del bucle, notificamos qué transacción ha dejado de trabajar
  SELECT dbms_transaction.local_transaction_id INTO id_transaccion FROM dual;
  dbms_output.put_line('He terminado de trabajar ' || id_transaccion);
END trabajando_T1;

/

show errors
