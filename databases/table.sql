-- Tabla datos paciente personal
CREATE TABLE clinica.datos_paciente_personal(
    folio serial PRIMARY KEY,
    tipoMovimiento VARCHAR(20),
    idPaciente clinica.id_paciente,
    nombrePaciente VARCHAR(20),
    usuario VARCHAR(20),
    fecha TIMESTAMP
);

-- Crea procedimiento o procedimiento
CREATE OR REPLACE FUNCTION clinica.borradoPaciente()
RETURNS TRIGGER AS $$
DECLARE
    usuario VARCHAR(20):= (SELECT current_user);
    fechaActual TIMESTAMP:= (SELECT left(cast(current_timestamp as char(30)), 19));
BEGIN

    INSERT INTO clinica.datos_paciente_personal(tipoMovimiento, idPaciente, nombrePaciente, usuario, fecha)
    VALUES('BORRADO', old.pk_idPaciente, old.nombre, usuario, fechaActual);
    RETURN new;
END $$

LANGUAGE plpgsql;

-- Crea trigger
CREATE TRIGGER borradoPaciente AFTER DELETE ON clinica.paciente FOR EACH ROW EXECUTE FUNCTION clinica.borradoPaciente();

-- Eliminar trigger
DROP TRIGGER borradoPaciente ON clinica.paciente;

-- Consulta
SELECT * FROM clinica.paciente ORDER BY pk_idPaciente ASC;
