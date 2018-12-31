CREATE OR REPLACE FUNCTION selectSourceCodeGenerator(iRecursionDepth integer, sTable text, iStart integer) RETURNS SETOF integer AS $$
Declare
  intermDst_ integer[];
  iCount integer;
  tStatement text;
  tConcatenateStatement text;
BEGIN
  tConcatenateStatement := 'SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src IN(';
  tStatement := 'SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src IN ' || '(' || iStart ||')';
  --   iCount = 0;
  if iRecursionDepth = 0 THEN
    return query EXECUTE tStatement;
    RETURN;
  end if;
  WHILE iRecursionDepth > 0 LOOP
    tStatement := tConcatenateStatement || tStatement ||')';
    iRecursionDepth = iRecursionDepth - 1;
  end loop;
  raise notice 'Execute String %', tStatement;
  return query EXECUTE tStatement;
END;
$$ LANGUAGE plpgsql;