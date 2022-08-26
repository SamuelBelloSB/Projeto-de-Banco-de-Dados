EXPLAIN select ps_partkey, sum(ps_supplycost * ps_availqty) as value 
from PARTSUPP, SUPPLIER, NATION 
where ps_suppkey = s_suppkey 
and s_nationkey = n_nationkey 
and n_name = 'MOZAMBIQUE' 
group by ps_partkey having sum(ps_supplycost * ps_availqty) > (select sum(ps_supplycost * ps_availqty) * 0.0001000000 
from PARTSUPP, SUPPLIER, NATION 
where ps_suppkey = s_suppkey 
and s_nationkey = n_nationkey 
and n_name = 'MOZAMBIQUE') order by value desc;

CREATE INDEX idx_nation USING HASH ON nation (n_name, n_nationkey);
CREATE INDEX idx_partsupp USING HASH ON partsupp (ps_partkey, ps_supplycost, ps_availqty, ps_suppkey);
CREATE INDEX idx_supplier USING HASH ON supplier (s_nationkey, s_suppkey);

DROP INDEX idx_nation ON nation;
DROP INDEX idx_partsupp ON partsupp;
DROP INDEX idx_supplier ON supplier;