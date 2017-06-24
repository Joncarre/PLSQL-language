-- Jonathan Carrero
/*
  SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
  SET AUTOCOMMIT OFF;
  SET SERVEROUTPUT ON SIZE 100000;

  -- Necesitamos una secuencia para insertar los valores
  CREATE SEQUENCE sec_compras INCREMENT BY 1 START WITH 10 NOMAXVALUE;
  DROP SEQUENCE sec_compras;
  -- Probar probarMiT2
  BEGIN
      probarMiT2();
  END;
*/

CREATE OR REPLACE PROCEDURE probarMiT2
  AS
 
BEGIN

    set transaction isolation level serializable;
    
    dbms_output.put_line('Voy a insertar las filas 2');
    INSERT INTO Compras VALUES ('00000002', '50000030',1, 0501,'tienda2',5);
    
    trabajando_T2(5);
    
    dbms_output.put_line('He despertado y voy a insertar las filas 4');
    INSERT INTO Compras VALUES ('00000004', '50000400',3, 0501,'tienda4',5000);

    trabajando_T2(5);
    
    dbms_output.put_line('He despertado y voy a insertar las filas 6');
    INSERT INTO Compras VALUES ('00000006', '30000002',1, 0501,'tienda6',3);
END probarMiT2;

/*
  --  Borrar y crear la tabla COMPRAS
  REM ... Compras: CO(DNI, NumT, NumF, Fecha, Tienda, Importe)
  
  DROP TABLE Compras CASCADE CONSTRAINTS;
  
  create table Compras
  (DNI		CHAR(8)  not null, 
   NumT		INT, 
   NumF		INT,
   Fecha		INT,
   Tienda		CHAR(20), 
   Importe		INT,
   PRIMARY KEY (DNI, NumT, NumF),
   FOREIGN KEY (DNI) REFERENCES Cliente(DNI),
   FOREIGN KEY (NumT)  REFERENCES Tarjeta(NumT));
  */
