-- Create procedure
CREATE OR REPLACE PROCEDURE clinica.insertPaciente(
    idPaciente VARCHAR(6),
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    sexo CHAR(1),
    fecha_nacimiento DATE,
    ciudad VARCHAR(20),
    estado VARCHAR(20),
    telefono VARCHAR(20)
)
AS $$
BEGIN
    INSERT INTO clinica.paciente VALUES (
        idPaciente, nombre, apellido, sexo, fecha_nacimiento, ciudad, estado, telefono
    );
END;

$$ LANGUAGE plpgsql


-- Insertar paciente
CALL clinica.insertPaciente('P-0012', 'MARIA', 'PEREZ', 'F', '2002-03-10', 'PASTO', 'NARIÑO', '7252222');

