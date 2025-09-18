-- Documentación de roles y privilegios en PostgreSQL (ejecutable)
-- Nota: por defecto, CREATE ROLE crea un rol SIN permiso de inicio de sesión.
-- Si necesitas que el rol pueda conectarse, usa la opción LOGIN o crea un usuario (CREATE USER).

-- Crear un rol llamado dba (sin permiso de inicio de sesión)
CREATE ROLE dba;

-- Dar permisos al rol dba para usar un esquema (USAGE permite referenciar objetos del esquema)
GRANT USAGE ON SCHEMA public TO dba;

-- Asignar todos los privilegios a todas las tablas del esquema public
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO dba;

-- Notas

-- Listar roles
\du

/*
 Ejemplos (transcripción psql; no ejecutable como SQL directo):
 -- Crear un rol con superusuario (no recomendado salvo casos de administración total)
 postgres=# CREATE ROLE dba WITH SUPERUSER;
 CREATE ROLE
 -- Listar roles
 postgres=# \du
                                      Lista de roles
  Nombre de rol |                         Atributos                          | Miembro de
 ---------------+------------------------------------------------------------+------------
  dba           | Superusuario, No puede conectarse                          | {}
  postgres      | Superusuario, Crear rol, Crear BD, Replicación, Ignora RLS | {}

 -- Listar esquemas
 postgres=# \dn
*/

-- Dar permisos al rol dba para usar esquema
GRANT USAGE ON SCHEMA clinica TO dba;

-- Dar permisos al rol dba para usar tablas
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA clinica TO dba WITH GRANT OPTION;

-- Crear un usuario
CREATE USER administrador WITH PASSWORD '12345' IN ROLE dba;

-- Listar usuarios
\du

-- Crear rol jefe especialista
CREATE ROLE jefe_especialista;

-- Dar permisos al rol jefe especialista para usar esquema
GRANT USAGE ON SCHEMA CLINICA TO jefe_especialista;

-- Dar permisos al rol jefe especialista para usar tablas
GRANT SELECT, INSERT, UPDATE, DELETE ON CLINICA.EXPEDIENTE, CLINICA.EXPEDIENTE_DIAGNOSTICO, CLINICA.ESPECIALISTA TO jefe_especialista;

-- Conceder privilegio DELETE en CLINICA.ESPECIALISTA al rol jefe_especialista (y permitir que lo delegue)
GRANT DELETE ON CLINICA.ESPECIALISTA TO jefe_especialista WITH GRANT OPTION;

-- Crear usuario jefe_especialista_1 y asignarlo al rol jefe_especialista
CREATE USER jefe_especialista_1 WITH PASSWORD '12345' CONNECTION LIMIT 1 IN ROLE jefe_especialista;

-- Quitar acceso schema clinica al rol jefe especialista
REVOKE USAGE ON SCHEMA CLINICA FROM jefe_especialista;

-- Quitar permisos al rol jefe especialista para usar tablas
REVOKE INSERT, SELECT, UPDATE ON CLINICA.EXPEDIENTE, CLINICA.EXPEDIENTE_DIAGNOSTICO, CLINICA.ESPECIALISTA FROM jefe_especialista;

REVOKE DELETE ON CLINICA.ESPECIALISTA FROM jefe_especialista;

-- Eliminar rol jefe especialista
DROP ROLE jefe_especialista;

-- Privilegios para el rol dba sobre el esquema clinica
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA clinica TO dba WITH GRANT OPTION;

-- Revocar privilegios (ejemplos correctos):
-- Si deseas revocar sobre TABLAS existentes del esquema clinica
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA clinica FROM dba;
-- Si deseas revocar sobre SECUENCIAS existentes del esquema clinica
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA clinica FROM dba;

-- Para impedir que el rol use el esquema (no podrá resolver objetos dentro del esquema)
REVOKE USAGE ON SCHEMA clinica FROM dba;