-- liquibase formatted sql

-- changeset benriley:1788771618063-1 splitStatements:false
ALTER TABLE public.employees DROP CONSTRAINT uq_employees_email;

-- changeset benriley:1788771618063-2 splitStatements:false
DROP TABLE public.demo1;

-- changeset benriley:1788771618063-3 splitStatements:false
DROP TABLE public.demo2;

-- changeset benriley:1788771618063-4 splitStatements:false
DROP TABLE public.demo3;

-- changeset benriley:1788771618063-5 splitStatements:false
DROP TABLE public.demo4;

-- changeset benriley:1788771618063-6 splitStatements:false
DROP TABLE public.demo5;

-- changeset benriley:1788771618063-7 splitStatements:false
DROP TABLE public.employees;

