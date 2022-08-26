EXPLAIN select n_name, sum(l_extendedprice * (1 - l_discount)) as revenue 
from CUSTOMER, ORDERS, LINEITEM, SUPPLIER, NATION, REGION 
where c_custkey = o_custkey 
and l_orderkey = o_orderkey 
and l_suppkey = s_suppkey 
and c_nationkey = s_nationkey 
and s_nationkey = n_nationkey 
and n_regionkey = r_regionkey 
and r_name = 'MIDDLE EAST' 
and o_orderdate >= date '1994-01-01' 
and o_orderdate < date '1994-01-01' + interval '1' year 
group by n_name order by revenue desc;

CREATE INDEX idx_nation USING HASH ON nation (n_name, n_regionkey);
CREATE INDEX idx_lineitem USING HASH ON lineitem (l_extendedprice, l_discount, l_suppkey, l_orderkey);
CREATE INDEX idx_orders USING BTREE ON orders (o_orderdate, orderkey, o_custkey);
CREATE INDEX idx_supplier USING HASH ON supplier (s_nationkey, s_suppkey);
CREATE INDEX idx_region USING HASH ON region (r_name, r_regionkey);
CREATE INDEX idx_customer USING HASH ON customer (c_nationkey, c_custkey);

DROP INDEX idx_nation ON nation;
DROP INDEX idx_lineitem ON lineitem;
DROP INDEX idx_orders ON orders;
DROP INDEX idx_supplier ON supplier;
DROP INDEX idx_region ON region;
DROP INDEX idx_customer ON customer;