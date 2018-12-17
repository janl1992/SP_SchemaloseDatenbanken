WITH RECURSIVE graphtraverse AS(
    SELECT DISTINCT(dst) FROM public.relation_facebook WHERE src =765
    UNION
    SELECT p.dst FROM relation_facebook p WHERE src IN ( p.src )
) SELECT * FROM graphtraverse