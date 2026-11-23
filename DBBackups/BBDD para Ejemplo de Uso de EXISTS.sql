DROP DATABASE IF EXISTS ejemplo_exists;
CREATE DATABASE ejemplo_exists;
USE ejemplo_exists;

CREATE TABLE cities (
    city VARCHAR(50) PRIMARY KEY
);

CREATE TABLE stores (
    store_type VARCHAR(50) PRIMARY KEY
);

CREATE TABLE cities_stores (
    city VARCHAR(50),
    store_type VARCHAR(50),
    PRIMARY KEY (city, store_type),
    FOREIGN KEY (city) REFERENCES cities(city),
    FOREIGN KEY (store_type) REFERENCES stores(store_type)
);

INSERT INTO cities (city) VALUES
('Madrid'),
('Barcelona'),
('Sevilla'),
('Valencia');

INSERT INTO stores (store_type) VALUES
('libreria'),
('supermercado'),
('farmacia'),
('ferreteria'),
('panaderia');

INSERT INTO cities_stores (city, store_type) VALUES
('Madrid', 'supermercado'),
('Madrid', 'farmacia'),
('Madrid', 'panaderia'),
('Barcelona', 'supermercado'),
('Barcelona', 'libreria'),
('Sevilla', 'farmacia'),
('Sevilla', 'panaderia'),
('Valencia', 'supermercado'),
('Valencia', 'farmacia'),
('Valencia', 'libreria');