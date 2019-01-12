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

CREATE TABLE IF NOT EXISTS relation_facebook_partitioned(
                                                           src INTEGER REFERENCES profiles_facebook(ID),
                                                           dst INTEGER REFERENCES profiles_facebook(ID),
                                                           type VARCHAR(50),
                                                           date DATE
)PARTITION BY RANGE(src);
CREATE INDEX fb_part_src ON relation_facebook_partitioned (src);
CREATE INDEX fb_part_dst ON relation_facebook_partitioned (dst);
CREATE TABLE relation_facebook_partitioned_0 PARTITION OF relation_facebook_partitioned
  FOR VALUES FROM (0) TO (23000);
CREATE TABLE relation_facebook_partitioned_1 PARTITION OF relation_facebook_partitioned
  FOR VALUES FROM (23000) TO (46000);
CREATE TABLE relation_facebook_partitioned_2 PARTITION OF relation_facebook_partitioned
  FOR VALUES FROM (46000) TO (69000);
CREATE TABLE relation_facebook_partitioned_3 PARTITION OF relation_facebook_partitioned
  FOR VALUES FROM (69000) TO (92000);

CREATE TABLE IF NOT EXISTS relation_facebook_with_index(
                                                          src INTEGER REFERENCES profiles_facebook(ID),
                                                          dst INTEGER REFERENCES profiles_facebook(ID),
                                                          type VARCHAR(50),
                                                          date DATE
);
CREATE INDEX fb_dst ON relation_facebook_with_index (dst);
CREATE INDEX fb_src ON relation_facebook_with_index (src);



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
INSERT INTO relation_facebook_with_index(src, dst, type, date)  SELECT src, dst, "type", "date" from relation_facebook;
INSERT INTO relation_facebook_partitioned(src, dst, type, date)  SELECT src, dst, "type", "date" from relation_facebook;


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
CREATE TABLE IF NOT EXISTS relation_youtube_partitioned(
                                                           src INTEGER REFERENCES profiles_youtube(ID),
                                                           dst INTEGER REFERENCES profiles_youtube(ID),
                                                           type VARCHAR(50),
                                                           date DATE
)PARTITION BY RANGE(src);
CREATE INDEX yt_part_src ON relation_youtube_partitioned (src);
CREATE INDEX yt_part_dst ON relation_youtube_partitioned (dst);
CREATE TABLE relation_youtube_partitioned_0 PARTITION OF relation_youtube_partitioned
  FOR VALUES FROM (0) TO (800000);
CREATE TABLE relation_youtube_partitioned_1 PARTITION OF relation_youtube_partitioned
  FOR VALUES FROM (800001) TO (1600000);
CREATE TABLE relation_youtube_partitioned_2 PARTITION OF relation_youtube_partitioned
  FOR VALUES FROM (1600001) TO (2400000);
CREATE TABLE relation_youtube_partitioned_3 PARTITION OF relation_youtube_partitioned
  FOR VALUES FROM (2400001) TO (3200000);

CREATE TABLE IF NOT EXISTS relation_youtube_with_index(
                                                          src INTEGER REFERENCES profiles_youtube(ID),
                                                          dst INTEGER REFERENCES profiles_youtube(ID),
                                                          type VARCHAR(50),
                                                          date DATE
);
CREATE INDEX yt_dst ON relation_youtube_with_index (dst);
CREATE INDEX yt_src ON relation_youtube_with_index (src);

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
INSERT INTO relation_youtube_with_index(src, dst, type, date)  SELECT src, dst, "type", "date" from relation_youtube;
INSERT INTO relation_youtube_partitioned(src, dst, type, date)  SELECT src, dst, "type", "date" from relation_youtube;


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


CREATE TABLE IF NOT EXISTS relation_livejournal_with_index(
                                                 src INTEGER REFERENCES profiles_livejournal(ID),
                                                 dst INTEGER REFERENCES profiles_livejournal(ID),
                                                 type VARCHAR(50),
                                                 date DATE
);
CREATE INDEX lj_src ON relation_livejournal_with_index (src);
CREATE INDEX lj_dst ON relation_livejournal_with_index (dst);

CREATE TABLE IF NOT EXISTS relation_livejournal_partitioned(
                                                 src INTEGER REFERENCES profiles_livejournal(ID),
                                                 dst INTEGER REFERENCES profiles_livejournal(ID),
                                                 type VARCHAR(50),
                                                 date DATE
)PARTITION BY RANGE(src);
CREATE INDEX lj_part_src ON relation_livejournal_partitioned (src);
CREATE INDEX lj_part_dst ON relation_livejournal_partitioned (dst);
CREATE TABLE relation_livejournal_partitioned_0 PARTITION OF relation_livejournal_partitioned
    FOR VALUES FROM (0) TO (10000000);
CREATE TABLE relation_livejournal_partitioned_1 PARTITION OF relation_livejournal_partitioned
    FOR VALUES FROM (10000000) TO (20000000);
CREATE TABLE relation_livejournal_partitioned_2 PARTITION OF relation_livejournal_partitioned
    FOR VALUES FROM (20000000) TO (30000000);
CREATE TABLE relation_livejournal_partitioned_3 PARTITION OF relation_livejournal_partitioned
    FOR VALUES FROM (30000000) TO (40000000);




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

INSERT INTO relation_livejournal_partitioned(src, dst, type, date)  SELECT src, dst, "type", "date" from relation_livejournal;
INSERT INTO relation_livejournal_with_index(src, dst, type, date)  SELECT src, dst, "type", "date" from relation_livejournal;



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

CREATE TABLE IF NOT EXISTS relation_epinions_partitioned(
                                                           src INTEGER REFERENCES profiles_epinions(ID),
                                                           dst INTEGER REFERENCES profiles_epinions(ID),
                                                           type VARCHAR(50),
                                                           date DATE
)PARTITION BY RANGE(src);
CREATE INDEX ep_part_src ON relation_epinions_partitioned (src);
CREATE INDEX ep_part_dst ON relation_epinions_partitioned (dst);
CREATE TABLE relation_epinions_partitioned_0 PARTITION OF relation_epinions_partitioned
  FOR VALUES FROM (0) TO (102000);
CREATE TABLE relation_epinions_partitioned_1 PARTITION OF relation_epinions_partitioned
  FOR VALUES FROM (102000) TO (204000);
CREATE TABLE relation_epinions_partitioned_2 PARTITION OF relation_epinions_partitioned
  FOR VALUES FROM (204000) TO (306000);
CREATE TABLE relation_epinions_partitioned_3 PARTITION OF relation_epinions_partitioned
  FOR VALUES FROM (306000) TO (408000);

CREATE TABLE IF NOT EXISTS relation_epinions_with_index(
                                                          src INTEGER REFERENCES profiles_epinions(ID),
                                                          dst INTEGER REFERENCES profiles_epinions(ID),
                                                          type VARCHAR(50),
                                                          date DATE
);
CREATE INDEX ep_dst ON relation_epinions_with_index (dst);
CREATE INDEX ep_src ON relation_epinions_with_index (src);


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
INSERT INTO relation_epinions_with_index(src, dst, type, date)  SELECT src, dst, "type", "date" from relation_epinions;
INSERT INTO relation_epinions_partitioned(src, dst, type, date)  SELECT src, dst, "type", "date" from relation_epinions;

CREATE INDEX ep_src ON relation_epinions (src);
CREATE INDEX ep_dst ON relation_epinions (dst);

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

CREATE TABLE IF NOT EXISTS relation_wiki_vote_partitioned(
                                                             src INTEGER REFERENCES profiles_wiki_vote(ID),
                                                             dst INTEGER REFERENCES profiles_wiki_vote(ID),
                                                             type VARCHAR(50),
                                                             date DATE
)PARTITION BY RANGE(src);
CREATE INDEX wv_part_src ON relation_wiki_vote_partitioned (src);
CREATE INDEX wv_part_dst ON relation_wiki_vote_partitioned (dst);
CREATE TABLE relation_wiki_vote_partitioned_0 PARTITION OF relation_wiki_vote_partitioned
  FOR VALUES FROM (0) TO (30000);
CREATE TABLE relation_wiki_vote_partitioned_1 PARTITION OF relation_wiki_vote_partitioned
  FOR VALUES FROM (30000) TO (60000);
CREATE TABLE relation_wiki_vote_partitioned_2 PARTITION OF relation_wiki_vote_partitioned
  FOR VALUES FROM (60000) TO (90000);
CREATE TABLE relation_wiki_vote_partitioned_3 PARTITION OF relation_wiki_vote_partitioned
  FOR VALUES FROM (90000) TO (120000);

CREATE TABLE IF NOT EXISTS relation_wiki_vote_with_index(
                                                            src INTEGER REFERENCES profiles_wiki_vote(ID),
                                                            dst INTEGER REFERENCES profiles_wiki_vote(ID),
                                                            type VARCHAR(50),
                                                            date DATE
);
CREATE INDEX wv_src ON relation_wiki_vote_with_index (src);
CREATE INDEX wv_dst ON relation_wiki_vote_with_index (dst);


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
INSERT INTO relation_wiki_vote_with_index(src, dst, type, date)  SELECT src, dst, "type", "date" from relation_wiki_vote;
INSERT INTO relation_wiki_vote_partitioned(src, dst, type, date)  SELECT src, dst, "type", "date" from relation_wiki_vote;


