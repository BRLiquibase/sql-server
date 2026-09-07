--liquibase formatted sql

--changeset liquibase-poc:002-add-status-column
ALTER TABLE poc_sample ADD status VARCHAR(20) DEFAULT 'ACTIVE';
--rollback ALTER TABLE poc_sample DROP COLUMN status;
