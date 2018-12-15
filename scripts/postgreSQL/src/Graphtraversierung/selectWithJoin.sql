SELECT distinct(rf5.dst)
FROM public.relation_facebook rf1,
     public.relation_facebook rf2,
     public.relation_facebook rf3,
     public.relation_facebook rf4,
     public.relation_facebook rf5
WHERE rf2.src = rf1.dst
  AND rf3.src = rf2.dst
  AND rf4.src = rf3.dst
  AND rf5.src = rf4.dst
  AND rf1.src = 765;