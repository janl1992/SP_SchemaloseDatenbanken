CREATE OR REPLACE FUNCTION selectCascadingGenerator(iRecursionDepth integer, sTable text, startingNode integer ) RETURNS SETOF integer AS $$
Declare
  intermDst_ integer[];
  --  iCount integer;
  tStatement text;
  tConcatenateStatement text;
BEGIN
  tConcatenateStatement := 'SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src IN(';
  tStatement := 'SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src IN('||startingNode||')';
  --   iCount = 0;
  if iRecursionDepth = 0 THEN
    return query EXECUTE tStatement;
    RETURN;
  end if;
  WHILE iRecursionDepth > 1 LOOP
    tStatement := tConcatenateStatement || tStatement ||')';
    iRecursionDepth = iRecursionDepth - 1;
  end loop;
  raise notice 'Execute String %', tStatement;
  return query EXECUTE tStatement;
END;
$$ LANGUAGE plpgsql;