-- +goose Up
-- +goose StatementBegin
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users
(
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username            VARCHAR(32) UNIQUE NOT NULL,
    email               VARCHAR(255) UNIQUE NOT NULL,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- +goose StatementEnd

-- +goose StatementBegin
INSERT INTO users (username, email) 
VALUES  
    ('admin', 'admin@example.com'), 
    ('test', 'test@example.com'),
    ('bob', 'bob@example.com');

-- +goose StatementEnd


-- +goose Down
DROP TABLE IF EXISTS users;