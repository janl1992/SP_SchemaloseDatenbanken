CREATE OR REPLACE FUNCTION selectUnionGenerator(sTable text, startingNode integer, depth integer ) RETURNS SETOF integer AS $$
Declare
  intermDst_ integer[];
  tStatement text;
  tSelectStatement text;
  tWithStatement text;
  tUnionStatement text;
  tWithStatementClose text;
BEGIN
  tWithStatement := 'WITH RECURSIVE graphtraverse(src, dst, lvl) AS(';
  tSelectStatement := 'SELECT src ,dst, 1 as lvl FROM ' || sTable || ' WHERE src ='||startingNode;
  tUnionStatement := ' UNION SELECT p1.src,p1.dst,p.lvl+1 as lvl FROM graphtraverse p, ' || sTable || ' p1 WHERE p1.src IN ( p.dst ) and lvl<'||depth;
  tWithStatementClose := ') SELECT DISTINCT(dst) FROM graphtraverse';
  tStatement := tWithStatement || tSelectStatement || tUnionStatement || tWithStatementClose;
  raise notice 'Execute String %', tStatement;
  return query EXECUTE tStatement;
END;
$$ LANGUAGE plpgsql;

