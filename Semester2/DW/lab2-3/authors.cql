CREATE KEYSPACE IF NOT EXISTS library
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE library;

CREATE TABLE IF NOT EXISTS Authors (
    id INT,
    first_name TEXT,
    last_name TEXT,
    url TEXT,
    join_date DATE,
    PRIMARY KEY (id)
);
