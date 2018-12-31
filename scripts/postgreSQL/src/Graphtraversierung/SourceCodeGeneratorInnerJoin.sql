CREATE OR REPLACE FUNCTION innerJoinSourceCodeGenerator(iRecursionDepth integer, sTable text, integer iStart) RETURNS SETOF integer AS $$
Declare
  intermDst_ integer[];
  iCount integer;
  tStatement text;
  tSelectStatement text;
  tConcatenateStatement text;
  tAlternativeStatement text;
  tWhereStatement text;
  tFinalStatement text;
BEGIN
  iCount = 0;
  tSelectStatement = '';
  tWhereStatement = '';
  tConcatenateStatement := 'SELECT DISTINCT(dst) FROM ' || sTable || ' WHERE src IN(';
  tStatement := sTable || ' rf';
  tAlternativeStatement = sTable || ' rf';
  --   iCount = 0;
  if iRecursionDepth = 0 THEN
    raise notice 'Rekursivtiefe von 0 nicht möglich';
    RETURN ;
  end if;
  if iRecursionDepth = 1 THEN
    tConcatenateStatement = tConcatenateStatement || '765' || ')';
    return query EXECUTE tConcatenateStatement;
    RETURN;
  end if;
  WHILE iCount < iRecursionDepth LOOP
    if iCount = iRecursionDepth - 1 then
      tSelectStatement := tSelectStatement || tStatement  || iCount || ' ';
    else
      tSelectStatement := tSelectStatement || tStatement  || iCount || ', ';
    end if;
    if iCount != 0 then
      if iCount = iRecursionDepth - 1 then
        tWhereStatement := tWhereStatement || 'rf' || iCount || '.src = rf' || iCount - 1 || '.dst ';
      else
        tWhereStatement := tWhereStatement || 'rf' || iCount || '.src = rf' || iCount - 1 || '.dst AND ';
      end if;
      else
        tWhereStatement := 'rf' || iCount || '.src = '|| iStart || ' AND ' ;
    end if;
    iCount = iCount + 1;
  end loop;
  tWhereStatement := 'WHERE ' || tWhereStatement;
  tSelectStatement := 'FROM ' || tSelectStatement;
  tFinalStatement = 'SELECT DISTINCT(rf'||iRecursionDepth - 1 || '.dst) ' || tSelectStatement || tWhereStatement;
  raise notice 'FROM Statement: %', tSelectStatement;
  raise notice 'Where Statement: %', tWhereStatement;
  raise notice 'Finale Statement: %', tFinalStatement;
  return query EXECUTE tFinalStatement;
END;
$$ LANGUAGE plpgsql;