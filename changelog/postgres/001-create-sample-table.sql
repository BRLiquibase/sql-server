--liquibase formatted sql

--changeset liquibase-poc:001-create-sample-table-postgresql
CREATE TABLE poc_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
--rollback DROP TABLE poc_sample;

drop table if exists poc_sample;

--changeset liquibase-poc:001-create-sample-table-postgresql-add-index
CREATE INDEX idx_poc_sample_name ON poc_sample(name);
--rollback DROP INDEX idx_poc_sample_name;  