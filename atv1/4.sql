EXPLAIN select o_orderpriority, count(*) as order_count 
from ORDERS where o_orderdate >= date '1995-01-01' 
and o_orderdate < date '1995-01-01' + interval '3' month 
and exists (select * from LINEITEM where l_orderkey = o_orderkey 
and l_commitdate < l_receiptdate) 
group by o_orderpriority order by o_orderpriority;

CREATE INDEX idx_orders USING BTREE on orders (o_orderdate, o_oderpriority);
CREATE INDEX idx_lineitem USING BTREE on lineitem (l_commitdate, l_receiptdate, l_orderkey);

DROP INDEX idx_orders ON orders;
DROP INDEX idx_lineitem ON lineitem;