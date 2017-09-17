-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
DROP DATABASE if exists tournament;
CREATE DATABASE tournament;

\connect tournament


CREATE TABLE players(id serial primary key, name text UNIQUE);
CREATE TABLE  results(
	id serial primary key,
	winner_id int references players(id),
	looser_id int references players(id));


CREATE VIEW scores AS SELECT p.id, p.name, 
    (SELECT count(*) from results as r where p.id = winner_id) as wins,
    (SELECT count(*) from results as r where p.id = winner_id OR p.id=looser_id) as matches
    from players as p ORDER BY wins DESC;