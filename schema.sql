CREATE TYPE ROLE_ENUM AS ENUM ('TRAINEE', 'TRAINER');

CREATE TABLE users (
    id UUID PRIMARY KEY,
    name VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
    username VARCHAR NOT NULL UNIQUE,
    password VARCHAR NOT NULL,
    phone VARCHAR,
    address_id UUID,
    gender VARCHAR,
    role ROLE_ENUM NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metadata JSONB
);

-- CREATE TABLE FitnessCentres (
--     id SERIAL PRIMARY KEY,
--     name VARCHAR NOT NULL,
--     current_user_ids INTEGER[], -- Array of user IDs
--     trainer_user_ids INTEGER[], -- Array of user IDs
--     address_id INTEGER,
--     phone VARCHAR,
--     capacity INTEGER,
--     costing INTEGER,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     metadata JSONB,
--     FOREIGN KEY (address_id) REFERENCES Address(id)
-- );

-- -- Create the UserRFitnessCentre table
-- CREATE TABLE UserRFitnessCentre (
--     id SERIAL PRIMARY KEY,
--     user_id INTEGER,
--     fitness_centre_id INTEGER,
--     available_fitness_centre_ids INTEGER[], -- Array of fitness centre IDs
--     metadata JSONB,
--     FOREIGN KEY (user_id) REFERENCES Users(id),
--     FOREIGN KEY (fitness_centre_id) REFERENCES FitnessCentres(id)
-- );

-- -- Create the Orders table
-- CREATE TABLE Orders (
--     id SERIAL PRIMARY KEY,
--     user_r_fitnesscentre_id INTEGER,
--     order_total FLOAT NOT NULL,
--     status ORDER_STATUS NOT NULL,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     completed_at TIMESTAMP,
--     FOREIGN KEY (user_r_fitnesscentre_id) REFERENCES UserRFitnessCentre(id)
-- );

-- -- Create the Transaction table
-- CREATE TABLE Transaction (
--     id SERIAL PRIMARY KEY,
--     order_id INTEGER,
--     payment_method PAYMENT_METHOD NOT NULL,
--     amount FLOAT NOT NULL,
--     status TRANSACTION_STATUS NOT NULL,
--     FOREIGN KEY (order_id) REFERENCES Orders(id)
-- );

-- -- Create the Address table
-- CREATE TABLE Address (
--     id SERIAL PRIMARY KEY,
--     user_id INTEGER,
--     fitness_centre_id INTEGER,
--     state VARCHAR,
--     city VARCHAR,
--     street VARCHAR,
--     pincode INTEGER,
--     FOREIGN KEY (user_id) REFERENCES Users(id),
--     FOREIGN KEY (fitness_centre_id) REFERENCES FitnessCentres(id)
-- );

-- -- Create the Rating table
-- CREATE TABLE Rating (
--     id SERIAL PRIMARY KEY,
--     user_r_fitnesscentre_id INTEGER,
--     rating INTEGER NOT NULL,
--     FOREIGN KEY (user_r_fitnesscentre_id) REFERENCES UserRFitnessCentre(id)
-- );

-- -- Define ENUM types for roles, statuses, and payment methods
-- CREATE TYPE ORDER_STATUS AS ENUM ('CREATED', 'ONGOING', 'CANCELLED', 'COMPLETED');
-- CREATE TYPE PAYMENT_METHOD AS ENUM ('CREDIT_CARD', 'DEBIT_CARD', 'PAYPAL', 'BANK_TRANSFER');
-- CREATE TYPE TRANSACTION_STATUS AS ENUM ('PENDING', 'COMPLETED', 'FAILED');
