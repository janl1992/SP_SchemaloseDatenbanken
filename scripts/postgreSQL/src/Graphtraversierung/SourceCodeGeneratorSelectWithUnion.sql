CREATE OR REPLACE FUNCTION selectWithUnionSourceCodeGenerator_withStartingNode(sTable text, startingNode integer ) RETURNS SETOF integer AS $$
Declare
  intermDst_ integer[];
  tStatement text;
  tSelectStatement text;
  tWithStatement text;
  tUnionStatement text;
  tWithStatementClose text;
BEGIN
  tWithStatement := 'WITH RECURSIVE graphtraverse AS(';
  tSelectStatement := 'SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src ='||startingNode;
  tUnionStatement := ' UNION SELECT DISTINCT(p.dst) FROM ' || sTable || ' p WHERE src IN (p.src)';
  tWithStatementClose := ') SELECT * FROM graphtraverse';
  tStatement := tWithStatement || tSelectStatement || tUnionStatement || tWithStatementClose;
  raise notice 'Execute String %', tStatement;
  return query EXECUTE tStatement;
END;
$$ LANGUAGE plpgsql;

