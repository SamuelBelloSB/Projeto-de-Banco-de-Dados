EXPLAIN select c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, sum(l_quantity) 
from CUSTOMER, ORDERS, LINEITEM 
where o_orderkey in (select l_orderkey 
from LINEITEM 
group by l_orderkey having sum(l_quantity) > 314) 
and c_custkey = o_custkey 
and o_orderkey = l_orderkey 
group by c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice 
order by o_totalprice desc, o_orderdate limit 100;

CREATE INDEX idx_customer USING HASH ON customer (c_custkey, c_name);
CREATE INDEX idx_orders USING HASH ON orders (o_orderkey, o_totalprice, o_orderdate);
CREATE INDEX idx_lineitem USING BTREE ON lineitem (l_orderkey, l_quantity);

DROP INDEX idx_customer ON customer;
DROP INDEX idx_orders ON orders;
DROP INDEX idx_lineitem ON lineitem;