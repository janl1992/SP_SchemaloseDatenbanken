CREATE OR REPLACE FUNCTION recursivesearch(tInput integer[], iRecursionDepth integer, sTable text) RETURNS SETOF integer AS $$
Declare
  intermDst_ integer[];
  iCount integer;
BEGIN
  --iRecursionDepth = iRecursionDepth + 1;
  CREATE TABLE intermDst AS SELECT * FROM unnest(tInput);
  EXECUTE 'CREATE TABLE intermDst1 AS SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src IN (SELECT * FROM intermDst)';
  -- Does not return from function!
  return query SELECT * FROM intermDst1;
  -- Does not return from function!
  intermDst_ := ARRAY(SELECT * FROM intermDst1);
  raise notice 'timestamp: %', clock_timestamp();
  SELECT count(*) INTO iCount FROM intermDst;
  raise notice 'Count Table: %', iCount;
  DROP TABLE intermDst;
  DROP TABLE intermDst1;
  -- As recursion depth is 5
  if iRecursionDepth > 1 THEN
    return query SELECT * FROM recursivesearch(intermDst_, iRecursionDepth - 1, sTable);
  ELSE
    RETURN;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Im Vergleich zum kaskadierendem Select returned diese Funktion bei einer rekursionstiefe
-- von 0  genauso viele Zeilen wie das kaskadierende Select(93). Bei einer
-- rekursionstiefe von 2 returned diese Funktion 109 Zeilen, das kaskadierende SELECT jedoch nur 16 Zeilen.
-- Der Grund dafür ist, dass sich die Funktion alle traversierten Knoten merkt:
-- 93 (0. Rekursionsstufe) + 16 (1. Rekursionsstufe) = 109
-- Das kaskadierende SELECT gibt jedoch nur die Zeilen der letzten Rekursionsstufe aus
