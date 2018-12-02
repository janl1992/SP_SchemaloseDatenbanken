# Postgres Data Import


## Import Statement
```
psql -h localhost -U postgres -d postgres -f init.sql 
```

## Cleanup Statement
```
psql -h localhost -U postgres -d postgres -f clean.sql 
```