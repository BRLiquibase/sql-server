--liquibase formatted sql

--changeset liquibase-poc:001-create-sample-table
CREATE TABLE poc_sample (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);
--rollback DROP TABLE poc_sample;
