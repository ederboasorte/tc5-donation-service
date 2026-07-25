\connect postgres

SELECT 'CREATE DATABASE donation_db' WHERE NOT EXISTS (
    SELECT FROM pg_database WHERE datname = 'donation_db'
)\gexec

\connect donation_db

CREATE TABLE IF NOT EXISTS donations (
    id SERIAL PRIMARY KEY,
    ngo_id INT NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    donor_name VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL, -- Ex: APPROVED, PENDING
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);