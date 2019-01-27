		Declare
				intermEmployeeId int;
        BEGIN
-- Does not return from function!
          return query SELECT full_name, manager_id FROM public.employee WHERE employee_id = i;
-- Does not return from function!
				  SELECT manager_id INTO intermEmployeeId FROM public.employee WHERE employee_id = i;
				  IF intermEmployeeId IS NOT null THEN
					  return query SELECT * FROM recursivesearch(intermEmployeeId);
				  ELSE
					  RETURN;
				  END IF;
        END;