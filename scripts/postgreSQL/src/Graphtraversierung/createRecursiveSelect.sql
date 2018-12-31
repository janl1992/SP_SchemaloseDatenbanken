CREATE OR REPLACE FUNCTION createRecursiveSelect(sTable text) RETURNS SETOF integer AS $$
BEGIN
  return query EXECUTE 'SELECT DISTINCT(dst) FROM ' || sTable ||  ' WHERE src IN (SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src IN (SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src IN (SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src IN (SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src IN(765)))))';
END
$$ LANGUAGE plpgsql;