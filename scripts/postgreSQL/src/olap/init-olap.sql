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

CREATE TYPE GENDER as ENUM ('MALE','FEMALE');
CREATE TABLE IF NOT EXISTS relation_facebook(
  src INTEGER,
  dst INTEGER,
  type VARCHAR(50),
  date DATE
);

create TABLE IF NOT EXISTS profiles_facebook(
  first VARCHAR(50),
  last VARCHAR(50),
  gender GENDER,
  birth DATE,
  country VARCHAR(50)
);


\copy relation_facebook FROM '/data/WS2018/facebook' DELIMITER ',' CSV HEADER;
\copy profiles_facebook FROM '/data/WS2018/facebook-profiles' DELIMITER ',' CSV HEADER;


CREATE TABLE IF NOT EXISTS relation_youtube(
                                              src INTEGER,
                                              dst INTEGER,
                                              type VARCHAR(50),
                                              date DATE
);

create TABLE IF NOT EXISTS profiles_youtube(
                                              first VARCHAR(50),
                                              last VARCHAR(50),
                                              gender GENDER,
                                              birth DATE,
                                              country VARCHAR(50)
);

\copy relation_youtube FROM '/data/WS2018/com-youtube' DELIMITER ',' CSV HEADER;
\copy profiles_youtube FROM '/data/WS2018/com-youtube-profiles' DELIMITER ',' CSV HEADER;

CREATE TABLE IF NOT EXISTS relation_livejournal(
                                             src INTEGER,
                                             dst INTEGER,
                                             type VARCHAR(50),
                                             date DATE
);

create TABLE IF NOT EXISTS profiles_livejournal(
                                             first VARCHAR(50),
                                             last VARCHAR(50),
                                             gender GENDER,
                                             birth DATE,
                                             country VARCHAR(50)
);

\copy relation_livejournal FROM '/data/WS2018/com-lj' DELIMITER ',' CSV HEADER;
\copy profiles_livejournal FROM '/data/WS2018/com-lj-profiles' DELIMITER ',' CSV HEADER;

CREATE TABLE IF NOT EXISTS relation_epinions(
                                                 src INTEGER,
                                                 dst INTEGER,
                                                 type VARCHAR(50),
                                                 date DATE
);

create TABLE IF NOT EXISTS profiles_epinions(
                                                 first VARCHAR(50),
                                                 last VARCHAR(50),
                                                 gender GENDER,
                                                 birth DATE,
                                                 country VARCHAR(50)
);

\copy relation_epinions FROM '/data/WS2018/soc-Epinions1' DELIMITER ',' CSV HEADER;
\copy profiles_epinions FROM '/data/WS2018/soc-Epinions1-profiles' DELIMITER ',' CSV HEADER;

CREATE TABLE IF NOT EXISTS relation_wiki_vote(
                                              src INTEGER,
                                              dst INTEGER,
                                              type VARCHAR(50),
                                              date DATE
);

create TABLE IF NOT EXISTS profiles_wiki_vote(
                                              first VARCHAR(50),
                                              last VARCHAR(50),
                                              gender GENDER,
                                              birth DATE,
                                              country VARCHAR(50)
);

\copy relation_wiki_vote FROM '/data/WS2018/wiki-vote' DELIMITER ',' CSV HEADER;
\copy profiles_wiki_vote FROM '/data/WS2018/wiki-vote-profiles' DELIMITER ',' CSV HEADER;