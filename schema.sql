CREATE TYPE public.role AS ENUM ('TRAINEE','TRAINER');
CREATE TYPE public.order_status AS ENUM ('CREATED', 'ONGOING', 'CANCELLED', 'COMPLETED');
CREATE TYPE public.payment_method AS ENUM ('CREDIT_CARD', 'DEBIT_CARD', 'COD', 'UPI');
CREATE TYPE public.transaction_status AS ENUM ('INITIATED', 'PENDING', 'COMPLETED', 'FAILED');

CREATE TABLE public.users (
    id character varying NOT NULL PRIMARY KEY,
    name character varying NOT NULL,
    email character varying NOT NULL UNIQUE,
    username character varying NOT NULL UNIQUE,
    password character varying NOT NULL,
    phone character varying NOT NULL,
    address_id character varying,
    gender character varying,
    role public.role NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metadata json
);

CREATE TABLE public.fitness_centres (
    id character varying NOT NULL PRIMARY KEY,
    name character varying NOT NULL,
    current_user_ids character varying[],
    trainer_user_ids character varying[],
    address_id character varying,
    phone character varying NOT NULL,
    capacity INTEGER,
    costing json,
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metadata json
);

CREATE TABLE public.address (
    id character varying NOT NULL PRIMARY KEY,
    user_id character varying,
    fitness_centre_id character varying,
    state character varying,
    city character varying,
    street character varying,
    pincode character varying
);

CREATE TABLE public.user_r_fitnesscentre (
    id character varying NOT NULL PRIMARY KEY,
    user_id character varying,
    fitness_centre_id character varying,
    available_fitness_centre_ids character varying[],
    metadata json
);

CREATE TABLE public.orders (
    id character varying NOT NULL PRIMARY KEY,
    user_r_fitnesscentre_id character varying NOT NULL,
    order_total FLOAT NOT NULL,
    status public.order_status NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at timestamp without time zone
);

CREATE TABLE public.transaction (
    id character varying NOT NULL PRIMARY KEY,
    order_id character varying NOT NULL,
    payment_method public.payment_method NOT NULL,
    amount FLOAT NOT NULL,
    status public.transaction_status NOT NULL
);

CREATE TABLE public.rating (
    id character varying NOT NULL PRIMARY KEY,
    user_r_fitnesscentre_id character varying NOT NULL,
    rating INTEGER
);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "user_addressId_fkey" FOREIGN KEY ("address_id") REFERENCES public.address(id);

ALTER TABLE ONLY public.fitness_centres
    ADD CONSTRAINT "fitnessCentres_addressId_fkey" FOREIGN KEY ("address_id") REFERENCES public.address(id);

ALTER TABLE ONLY public.address
    ADD CONSTRAINT "address_userId_fkey" FOREIGN KEY ("user_id") REFERENCES public.users(id);

ALTER TABLE ONLY public.address
    ADD CONSTRAINT "address_fitnessCentreId_fkey" FOREIGN KEY ("fitness_centre_id") REFERENCES public.fitness_centres(id);

ALTER TABLE ONLY public.user_r_fitnesscentre
    ADD CONSTRAINT "userRFitnessCentre_userId_fkey" FOREIGN KEY ("user_id") REFERENCES public.users(id);

ALTER TABLE ONLY public.user_r_fitnesscentre
    ADD CONSTRAINT "userRFitnessCentre_fitnessCentreId_fkey" FOREIGN KEY ("fitness_centre_id") REFERENCES public.fitness_centres(id);

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "orders_userRFitnessCentreId_fkey" FOREIGN KEY ("user_r_fitnesscentre_id") REFERENCES public.user_r_fitnesscentre(id);

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT "transaction_orderId_fkey" FOREIGN KEY ("order_id") REFERENCES public.orders(id);

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT "rating_userRFitnesscentreId_fkey" FOREIGN KEY ("user_r_fitnesscentre_id") REFERENCES public.user_r_fitnesscentre(id);