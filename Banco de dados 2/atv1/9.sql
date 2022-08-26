EXPLAIN select nation, o_year, sum(amount) as sum_profit 
from (select n_name as nation, 
extract(year from o_orderdate) as o_year, 
l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount 
from PART, SUPPLIER, LINEITEM, PARTSUPP, ORDERS, NATION 
where s_suppkey = l_suppkey 
and ps_suppkey = l_suppkey 
and ps_partkey = l_partkey 
and p_partkey = l_partkey 
and o_orderkey = l_orderkey 
and s_nationkey = n_nationkey 
and p_name like '%dim%') as profit 
group by nation, o_year order by nation, o_year desc;

CREATE INDEX idx_nation USING HASH ON nation (n_nationkey, n_name);
CREATE INDEX idx_part USING HASH ON part (p_name, p_partkey);
CREATE INDEX idx_partsupp USING HASH ON partsupp (ps_partkey, ps_suppkey, ps_supplycost);
CREATE INDEX idx_orders USING HASH ON orders (o_oderdate, o_orderkey);
CREATE INDEX idx_lineitem USING HASH ON lineitem (l_suppkey, l_partkey, l_orderkey, l_extendedprice, l_quantify, l_discount);

DROP INDEX idx_nation ON nation;
DROP INDEX idx_part ON part;
DROP INDEX idx_partsupp ON partsupp;
DROP INDEX idx_orders ON orders;
DROP INDEX idx_lineitem ON lineitem;