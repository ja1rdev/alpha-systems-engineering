-- Permissions on table
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO root;

-- Permissions error on postgreSQL sequence
GRANT USAGE, SELECT ON SEQUENCE users_id_seq TO root;

-- Connect to database
\c alpha_systems_engineering

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    mobile_number VARCHAR(20) NULL,
    address VARCHAR(50) NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    status BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);