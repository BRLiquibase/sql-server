--liquibase formatted sql

--changeset liquibase-poc:001-create-sample-table-postgresql
CREATE TABLE poc_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
--rollback DROP TABLE poc_sample;

drop table poc_sample;