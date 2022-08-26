EXPLAIN select c_custkey, c_name, sum(l_extendedprice * (1 - l_discount)) as revenue,
c_acctbal, n_name, c_address, c_phone, c_comment
from CUSTOMER, ORDERS, LINEITEM, NATION
where c_custkey = o_custkey
and l_orderkey = o_orderkey
and o_orderdate >= date '1993-08-01'
and o_orderdate < date '1993-08-01' + interval '3' month
and l_returnflag = 'R'
and c_nationkey = n_nationkey
group by c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment
order by revenue desc limit 20;

CREATE INDEX idx_customer USING HASH ON customer (c_custkey, c_name, c_acctbal, c_phone, c_adress, c_comment, c_nationkey);
CREATE INDEX idx_nation USING HASH ON nation (n_name, n_nationkey);
CREATE INDEX idx_orders USING BTREE ON orders (o_custkey, o_orderkey, o_orderdate);
CREATE INDEX idx_lineitem USING HASH ON lineitem (l_orderkey, l_returnflag, l_extendedprice, l_discount);

DROP INDEX idx_customer ON customer;
DROP INDEX idx_nation ON nation;
DROP INDEX idx_orders ON orders;
DROP INDEX idx_lineitem ON lineitem;