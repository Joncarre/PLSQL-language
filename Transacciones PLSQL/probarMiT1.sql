-- Jonathan Carrero

/*
  SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
  SET AUTOCOMMIT OFF;
  SET SERVEROUTPUT ON SIZE 100000;
  
  -- Necesitamos una secuencia para insertar los valores
  CREATE SEQUENCE sec_compras INCREMENT BY 1 START WITH 10 NOMAXVALUE;
  DROP SEQUENCE sec_compras;
  -- Probar probarMiT1
  BEGIN
      probarMiT1();
  END;
*/

CREATE OR REPLACE PROCEDURE probarMiT1
  AS
 
BEGIN

    set transaction isolation level serializable;
    
    dbms_output.put_line('Voy a insertar las filas 1');
    INSERT INTO Compras VALUES ('00000001', '50000400',1, 0501,'tienda1',50);
    
    trabajando_T1(5);
    
    dbms_output.put_line('He despertado y voy a insertar las filas 3');
    INSERT INTO Compras VALUES ('00000003', '50000400',2, 0502,'tienda3',500);

    trabajando_T1(5);
    
    dbms_output.put_line('He despertado y voy a insertar las filas 5');
    INSERT INTO Compras VALUES ('00000005', '50000003',1, 0501,'tienda5',50000);
    
END probarMiT1;

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
