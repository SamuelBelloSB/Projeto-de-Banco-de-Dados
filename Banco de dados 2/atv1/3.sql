EXPLAIN select l_orderkey, sum(l_extendedprice * (1 - l_discount)) as revenue, o_orderdate, o_shippriority 
from CUSTOMER, ORDERS, LINEITEM 
where c_mktsegment = 'AUTOMOBILE' 
and c_custkey = o_custkey 
and l_orderkey = o_orderkey 
and o_orderdate < date '1995-03-13' 
and l_shipdate > date '1995-03-13' 
group by l_orderkey, o_orderdate, o_shippriority 
order by revenue desc, o_orderdate limit 10;

CREATE INDEX idx_lineitem USING BTREE ON lineitem (l_orderkey, l_extendedprice, l_orderkey, l_shipdate);
CREATE INDEX idx_orders USING BTREE ON orders (o_orderdate, o_orderkey, o_custkey);
CREATE INDEX idx_customer USING HASH ON customer (c_mktsegment, c_custkey);

DROP INDEX idx_lineitem ON lineitem;
DROP INDEX idx_orders ON orders;
DROP INDEX idx_customer ON customer;