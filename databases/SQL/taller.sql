CREATE OR REPLACE PROCEDURE clinica.insertarPacienteExpediente(
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    sexo CHAR(1),
    fecha_nacimiento DATE,
    ciudad VARCHAR(20),
    estado VARCHAR(20),
    telefono CHAR(10),
    grupo_sanguineo VARCHAR(10),
    alergias VARCHAR(50),
    enfermedades VARCHAR(50)
)
AS $$
DECLARE
    last_id_paciente CHAR(6);
    last_num_paciente INT;
    new_id_paciente CHAR(6);
    fecha_creacion TIMESTAMP := CURRENT_TIMESTAMP;
BEGIN
    -- Obtener último idPaciente
    SELECT pk_idPaciente INTO last_id_paciente
    FROM clinica.paciente
    ORDER BY pk_idPaciente DESC
    LIMIT 1;

    IF last_id_paciente IS NULL THEN
        new_id_paciente := 'P-0001';
    ELSE
        last_num_paciente := CAST(SUBSTRING(last_id_paciente FROM 3) AS INT);
        new_id_paciente := 'P-' || LPAD((last_num_paciente + 1)::TEXT, 4, '0');
    END IF;

    -- Insertar paciente
    INSERT INTO clinica.paciente (
        pk_idPaciente, nombre, apellido, sexo, fechaNacimiento, ciudad, estado, telefono
    ) VALUES (
        new_id_paciente, nombre, apellido, sexo, fecha_nacimiento, ciudad, estado, telefono
    );

    -- Insertar expediente (sin ID, solo con pk_idPaciente y fecha actual)
    INSERT INTO clinica.expediente (
        pk_idPaciente, tipoSangre, tipoAlergia, padecimientoCro, fechaCreacion
    ) VALUES (
        new_id_paciente, grupo_sanguineo, alergias, enfermedades, fecha_creacion
    );

    RAISE NOTICE 'Paciente insertado con ID: % y expediente creado', new_id_paciente;
END;
$$ LANGUAGE plpgsql;

CALL clinica.insertarPacienteExpediente('JOE', 'SMITH', 'M', '1999-01-01', 'SAN FRANCISCO', 'CALIFORNIA', '7777777777', 'O POSITIVO', 'NA', 'NA');

-- Mostrar todos los registros de la tabla expediente
SELECT * FROM clinica.expediente;


-- Mostrar la definición de la procedimiento
SELECT
    proname AS procedure_name,
    oidvectortypes(proargtypes) AS argument_types,
    pg_get_functiondef(p.oid) AS definition
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'clinica'
  AND proname = 'insertarpacienteexpediente';

-- Eliminar la procedimiento
DROP PROCEDURE clinica.insertarPacienteExpediente(
    varchar, varchar, char, date, varchar, varchar, varchar, varchar, varchar, varchar
);