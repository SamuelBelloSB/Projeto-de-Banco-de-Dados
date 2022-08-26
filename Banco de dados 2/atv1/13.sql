EXPLAIN select c_count, count(*) as custdist 
from (select c_custkey, count(o_orderkey) as c_count 
from CUSTOMER left outer join ORDERS on c_custkey = o_custkey 
and o_comment not like '%pending%deposits%' 
group by c_custkey) c_orders 
group by c_count 
order by custdist desc, c_count desc;

CREATE INDEX idx_customer USING HASH ON customer (c_count, c_custkey, c_orders);
CREATE INDEX idx_orders USING HASH ON orders (o_custkey, o_orderkey);

DROP INDEX idx_customer ON customer;
DROP INDEX idx_orders ON orders;