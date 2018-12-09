DROP TABLE IF EXISTS relation;
DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS relation_facebook;
DROP TABLE IF EXISTS profiles_facebook;
DROP TABLE IF EXISTS relation_youtube;
DROP TABLE IF EXISTS profiles_youtube;
DROP TABLE IF EXISTS relation_epinions;
DROP TABLE IF EXISTS profiles_epinions;
DROP TABLE IF EXISTS relation_wiki_vote;
DROP TABLE IF EXISTS profiles_wiki_vote;
DROP TABLE IF EXISTS relation_livejournal;
DROP TABLE IF EXISTS profiles_livejournal;
DROP TYPE IF EXISTS GENDER;


CREATE TYPE GENDER as ENUM ('MALE','FEMALE');



create TABLE IF NOT EXISTS profiles_facebook(
  ID INTEGER PRIMARY KEY,
  first VARCHAR(50),
  last VARCHAR(50),
  gender GENDER,
  birth DATE,
  country VARCHAR(50)
);



CREATE TABLE IF NOT EXISTS relation_facebook(
                                              src INTEGER REFERENCES profiles_facebook(ID),
                                              dst INTEGER REFERENCES profiles_facebook(ID),
                                              type VARCHAR(50),
                                              date DATE
);

create TABLE IF NOT EXISTS profiles_facebook_tmp(
                                              ID SERIAL PRIMARY KEY,
                                              first VARCHAR(50),
                                              last VARCHAR(50),
                                              gender GENDER,
                                              birth DATE,
                                              country VARCHAR(50)
);

\copy profiles_facebook_tmp(first,last,gender,birth,country) FROM '/data/WS2018/facebook-profiles' DELIMITER ',' CSV HEADER;
INSERT INTO profiles_facebook (ID, first, last, gender, birth, country)
SELECT ID-1, first, last, gender, birth, country from profiles_facebook_tmp;
DROP TABLE IF EXISTS profiles_facebook_tmp;
\copy relation_facebook FROM '/data/WS2018/facebook' DELIMITER ',' CSV HEADER;


create TABLE IF NOT EXISTS profiles_youtube(
                                             ID INTEGER PRIMARY KEY,
                                             first VARCHAR(50),
                                             last VARCHAR(50),
                                             gender GENDER,
                                             birth DATE,
                                             country VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS relation_youtube(
                                             src INTEGER references profiles_youtube(ID),
                                             dst INTEGER references profiles_youtube(ID),
                                             type VARCHAR(50),
                                             date DATE
);
create TABLE IF NOT EXISTS profiles_youtube_tmp(
                                             ID SERIAL PRIMARY KEY,
                                             first VARCHAR(50),
                                             last VARCHAR(50),
                                             gender GENDER,
                                             birth DATE,
                                             country VARCHAR(50)
);

\copy profiles_youtube_tmp(first,last,gender,birth,country) FROM '/data/WS2018/com-youtube-profiles' DELIMITER ',' CSV HEADER;
INSERT INTO profiles_youtube (ID, first, last, gender, birth, country)
SELECT ID-1, first, last, gender, birth, country from profiles_youtube_tmp;
DROP TABLE IF EXISTS profiles_youtube_tmp;
\copy relation_youtube FROM '/data/WS2018/com-youtube' DELIMITER ',' CSV HEADER;


create TABLE IF NOT EXISTS profiles_livejournal(
                                             ID INTEGER PRIMARY KEY,
                                             first VARCHAR(50),
                                             last VARCHAR(50),
                                             gender GENDER,
                                             birth DATE,
                                             country VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS relation_livejournal(
                                                 src INTEGER REFERENCES profiles_livejournal(ID),
                                                 dst INTEGER REFERENCES profiles_livejournal(ID),
                                                 type VARCHAR(50),
                                                 date DATE
);

create TABLE IF NOT EXISTS profiles_livejournal_tmp(
                                                 ID SERIAL PRIMARY KEY,
                                                 first VARCHAR(50),
                                                 last VARCHAR(50),
                                                 gender GENDER,
                                                 birth DATE,
                                                 country VARCHAR(50)
);

\copy profiles_livejournal_tmp(first,last,gender,birth,country) FROM '/data/WS2018/com-lj-profiles' DELIMITER ',' CSV HEADER;
INSERT INTO profiles_livejournal (ID, first, last, gender, birth, country)
SELECT ID-1, first, last, gender, birth, country from profiles_livejournal_tmp;
DROP TABLE IF EXISTS profiles_livejournal_tmp;
\copy relation_livejournal FROM '/data/WS2018/com-lj' DELIMITER ',' CSV HEADER;


create TABLE IF NOT EXISTS profiles_epinions(
                                              ID INTEGER PRIMARY KEY,
                                              first VARCHAR(50),
                                              last VARCHAR(50),
                                              gender GENDER,
                                              birth DATE,
                                              country VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS relation_epinions(
                                                 src INTEGER REFERENCES profiles_epinions(ID),
                                                 dst INTEGER REFERENCES profiles_epinions(ID),
                                                 type VARCHAR(50),
                                                 date DATE
);


create TABLE IF NOT EXISTS profiles_epinions_tmp(
                                              ID SERIAL PRIMARY KEY,
                                              first VARCHAR(50),
                                              last VARCHAR(50),
                                              gender GENDER,
                                              birth DATE,
                                              country VARCHAR(50)
);

\copy profiles_epinions_tmp(first,last,gender,birth,country) FROM '/data/WS2018/soc-Epinions1-profiles' DELIMITER ',' CSV HEADER;
INSERT INTO profiles_epinions (ID, first, last, gender, birth, country)
SELECT ID-1, first, last, gender, birth, country from profiles_epinions_tmp;
DROP TABLE IF EXISTS profiles_epinions_tmp;
\copy relation_epinions FROM '/data/WS2018/soc-Epinions1' DELIMITER ',' CSV HEADER;


create TABLE IF NOT EXISTS profiles_wiki_vote(
                                               ID INTEGER PRIMARY KEY,
                                               first VARCHAR(50),
                                               last VARCHAR(50),
                                               gender GENDER,
                                               birth DATE,
                                               country VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS relation_wiki_vote(
                                              src INTEGER references profiles_wiki_vote(ID),
                                              dst INTEGER references profiles_wiki_vote(ID),
                                              type VARCHAR(50),
                                              date DATE
);

create TABLE IF NOT EXISTS profiles_wiki_vote_tmp(
                                               ID SERIAL PRIMARY KEY,
                                               first VARCHAR(50),
                                               last VARCHAR(50),
                                               gender GENDER,
                                               birth DATE,
                                               country VARCHAR(50)
);


\copy profiles_wiki_vote_tmp(first,last,gender,birth,country) FROM '/data/WS2018/wiki-vote-profiles' DELIMITER ',' CSV HEADER;
INSERT INTO profiles_wiki_vote (ID, first, last, gender, birth, country)
SELECT ID-1, first, last, gender, birth, country from profiles_wiki_vote_tmp;
DROP TABLE IF EXISTS profiles_wiki_vote_tmp;
\copy relation_wiki_vote FROM '/data/WS2018/wiki-vote' DELIMITER ',' CSV HEADER;
