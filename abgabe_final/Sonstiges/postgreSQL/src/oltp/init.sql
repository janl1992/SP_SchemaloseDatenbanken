CREATE TYPE GESCHLECHT as ENUM ('m','w','d');
CREATE TYPE ROLLE as ENUM ('N','M','U','A');


CREATE TABLE IF NOT EXISTS Mitglieder(
  ID_Mit SERIAL PRIMARY KEY,
  Name VARCHAR(100),
  Rolle ROLLE,
  GebDatum DATE,
  Geschlecht GESCHLECHT

);


CREATE TABLE IF NOT EXISTS Beitraege(

  ID_Bei SERIAL PRIMARY KEY,
  ID_Mit SERIAL REFERENCES Mitglieder(ID_Mit),
  Beitrag varchar(4000)

);

CREATE TABLE IF NOT EXISTS Kommentare
(
  NR        SERIAL,
  ID_Mit    SERIAL REFERENCES Mitglieder (ID_Mit),
  ID_Bei    SERIAL REFERENCES Beitraege (ID_Bei),
  Kommentar varchar(4000),
  PRIMARY KEY (NR, ID_Mit, ID_Bei)
);

CREATE TABLE IF NOT EXISTS Kommentare_tmp(
    NR INTEGER,
    ID_Mit INTEGER,
    ID_Bei INTEGER,
    Kommentar varchar(4000)


);
CREATE TABLE IF NOT EXISTS Mitglieder_TMP(
  ID_Mit SERIAL PRIMARY KEY,
  Name VARCHAR(100),
  Rolle ROLLE,
  GebDatum VARCHAR(100),
  Geschlecht GESCHLECHT

);
\copy Mitglieder_TMP FROM './data/Mitglieder.csv' DELIMITER ',' CSV HEADER;

UPDATE Mitglieder_TMP SET GebDatum = concat('0',GebDatum) WHERE length(GebDatum)<8;

INSERT INTO Mitglieder (ID_Mit,Name,Rolle,GebDatum,Geschlecht)
SELECT ID_Mit,Name,Rolle,to_date(GebDatum,'ddmmyyyy'),Geschlecht from Mitglieder_TMP;

DROP TABLE IF EXISTS MITGLIEDER_TMP;
\copy Beitraege FROM './data/Beitraege.csv' DELIMITER ',' CSV HEADER;

\copy Kommentare_tmp(ID_Bei,ID_Mit,Nr,Kommentar) FROM  './data/Kommentare.csv' DELIMITER ',' CSV HEADER;

INSERT INTO Kommentare(ID_Mit,ID_Bei,Kommentar) SELECT ID_Mit,ID_Bei,Kommentar from Kommentare_tmp
where ID_Mit IS NOT NULL and ID_Bei IS NOT NULL;

DROP TABLE IF EXISTS Kommentare_tmp;