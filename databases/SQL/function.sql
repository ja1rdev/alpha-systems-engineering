PostgreSQL Documentation

-- Create Function
CREATE FUNCTION nameFunction() RETURNS datatype 
AS $$ BEGIN
END;
$$ LANGUAGE plpgsql;

SELECT nameFunction();

-- Create procedure, no return
CREATE PROCEDURE nameProcedure()
AS $$ BEGIN
END;
$$ LANGUAGE plpgsql;

CALL nameProcedure();

-- Create trigger
CREATE TRIGGER nameTrigger {BEFORE | AFTER} {AFTER | INSTEAD OF} { event [OR event ...]}
ON table_name
FOR EACH ROW
EXECUTE FUNCTION nameFunction();

Where event be one of: INSERT, UPDATE, DELETE, TRUNCATE

-- Example function sin parametros
CREATE FUNCTION clinica.helloworld() RETURNS VARCHAR(20)
AS $$ DECLARE
	message VARCHAR(20):='Hello World';
BEGIN
	RETURN message;
END;
$$ LANGUAGE plpgsql;

SELECT clinica.helloworld();

-- Example function con parametros
CREATE FUNCTION clinica.helloworld(message VARCHAR(20)) RETURNS VARCHAR(20)
AS $$ 
BEGIN
	RETURN message;
END;
$$ LANGUAGE plpgsql;

SELECT clinica.helloworld('Hello from select');


-- Function sumar
CREATE FUNCTION clinica.sumar(a INT, b INT) RETURNS INT
AS $$
BEGIN
	RETURN a + b;
END;
$$ LANGUAGE plpgsql;

SELECT clinica.sumar(1, 2);

-- Function IF AND ELSE
CREATE FUNCTION clinica.mayorMenor(num1 INT, num2 INT)
RETURNS VARCHAR(30) AS $$
BEGIN
    IF num1 > num2 THEN
        RETURN 'The number'||num1||'is greater than'||num2;
    ELSEIF num1 < num2 THEN
        RETURN 'The number'||num2||'is greater than'||num1;
    ELSE
        RETURN 'The numbers are equal';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT clinica.mayorMenor(10,20);

-- Delete function
DROP FUNCTION IF EXISTS clinica.mayorMenor;

CREATE OR REPLACE FUNCTION clinica.mayorMenor(num1 INT, num2 INT)
RETURNS VARCHAR(30) AS $$
BEGIN
    CASE
        WHEN num1 > num2 THEN
            RETURN 'The number'||num1||'is greater than'||num2;
        WHEN num1 < num2 THEN
            RETURN 'The number'||num2||'is greater than'||num1;
        ELSE
            RETURN 'The numbers are equal';
    END CASE;
END;
$$ LANGUAGE plpgsql;

-- Function that takes a number and returns the corresponding month
CREATE OR REPLACE FUNCTION clinica.getMonthName(month_num INT)
RETURNS VARCHAR(20) AS $$
DECLARE
    month_name VARCHAR(20);
BEGIN
    CASE month_num
        WHEN 1 THEN month_name := 'January';
        WHEN 2 THEN month_name := 'February';
        WHEN 3 THEN month_name := 'March';
        WHEN 4 THEN month_name := 'April';
        WHEN 5 THEN month_name := 'May';
        WHEN 6 THEN month_name := 'June';
        WHEN 7 THEN month_name := 'July';
        WHEN 8 THEN month_name := 'August';
        WHEN 9 THEN month_name := 'September';
        WHEN 10 THEN month_name := 'October';
        WHEN 11 THEN month_name := 'November';
        WHEN 12 THEN month_name := 'December';
        ELSE month_name := 'Invalid month number';
    END CASE;
    
    RETURN month_name;
END;
$$ LANGUAGE plpgsql;

SELECT clinica.getMonthName(9);


-- For loop
CREATE OR REPLACE FUNCTION clinica.loop(numero INT)
RETURNS INT AS $$
DECLARE
    i INT := 0;
BEGIN
    FOR i IN 1..numero loop
        RAISE NOTICE 'Contador % esto es un texto adicional', i;
    END loop;
    RETURN i;
END;

$$ LANGUAGE plpgsql;

-- For con incremento de 2
CREATE OR REPLACE FUNCTION clinica.loop(numero INT)
RETURNS INT AS $$
DECLARE
    i INT := 4;
BEGIN
    FOR i IN i..numero by 2 loop
        RAISE NOTICE 'Contador % esto es un texto adicional', i;
    END loop;
    RETURN i;
END;

$$ LANGUAGE plpgsql;

-- For invertido
CREATE OR REPLACE FUNCTION clinica.loop(numero INT)
RETURNS INT AS $$
DECLARE
    i INT;
BEGIN
    FOR i IN REVERSE numero..1 loop
        RAISE NOTICE 'Contador % esto es un texto adicional', i;
    END loop;
    RETURN 0;
END;

$$ LANGUAGE plpgsql;


-- While
CREATE OR REPLACE FUNCTION clinica.while(numero INT)
RETURNS INT AS $$
DECLARE
    i INT := 0;
BEGIN
    WHILE i < numero loop
        RAISE NOTICE 'Contador % esto es un texto adicional', i;
        i := i + 1;
    END loop;
    RETURN i;
END;

$$ LANGUAGE plpgsql;

-- Función que reciba un número y retorne los números pares desde 0 hasta el número ingresado (for)
CREATE OR REPLACE FUNCTION clinica.pares(numero INT)
RETURNS INT AS $$
DECLARE
    i INT := 0;
BEGIN
    FOR i IN 0..numero loop
        IF i % 2 = 0 THEN
            RAISE NOTICE 'El numero % es par', i;
        END IF;
    END loop;
    RETURN 0;
END;

$$ LANGUAGE plpgsql;

-- Función que reciba un número y retorne los números impares desde 0 hasta el número ingresado (while)
CREATE OR REPLACE FUNCTION clinica.impares(numero INT)
RETURNS INT AS $$
DECLARE
    i INT := 0;
BEGIN
    WHILE i < numero loop
        IF i % 2 <> 0 THEN
            RAISE NOTICE 'El numero % es impar', i;
        END IF;
        i := i + 1;
    END loop;
    RETURN i;
END;

$$ LANGUAGE plpgsql;