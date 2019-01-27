CREATE TEMPORARY TABLE temp_table(
   dst INTEGER
);
CREATE INDEX tmp_dst ON temp_table (dst);
INSERT INTO temp_table(dst) SELECT DISTINCT(dst) FROM relation_livejournal_partitioned WHERE src IN (SELECT DISTINCT(dst) FROM relation_livejournal_partitioned WHERE src IN (SELECT DISTINCT(dst) FROM relation_livejournal_partitioned WHERE src IN (SELECT DISTINCT(dst) FROM public.relation_livejournal_partitioned WHERE src IN(510760))));
SELECT DISTINCT(relation_livejournal_partitioned.dst) FROM relation_livejournal_partitioned, temp_table WHERE src=temp_table.dst ;
Drop table temp_table;
