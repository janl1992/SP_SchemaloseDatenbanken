CREATE OR REPLACE FUNCTION recursivesearch(tInput integer[], iRecursionDepth integer) RETURNS SETOF integer AS $$
  Declare
	intermDst_ integer[];
  BEGIN
	iRecursionDepth = iRecursionDepth + 1;
	CREATE TABLE intermDst AS SELECT * FROM unnest(tInput);
-- Does not return from function!
    return query SELECT DISTINCT(dst) FROM team22.public.relation_facebook WHERE src IN (SELECT * FROM intermDst);
-- Does not return from function!
	intermDst_ := ARRAY(SELECT DISTINCT(dst) FROM team22.public.relation_facebook WHERE src IN (SELECT * FROM intermDst));
	DROP TABLE intermDst;
-- As recursion depth is 5
	if iRecursionDepth < 5 THEN
		return query SELECT * FROM recursivesearch(intermDst_, iRecursionDepth);
	ELSE
		RETURN;
	END IF;
  END;
$$ LANGUAGE plpgsql;