EXPLAIN select o_year, sum(case when nation = 'INDIA' then volume else 0 end) / sum(volume) as mkt_share 
from (select extract(year from o_orderdate) as o_year,	
l_extendedprice * (1 - l_discount) as volume, 
n2.n_name as nation 
from PART, SUPPLIER, LINEITEM, ORDERS, CUSTOMER, NATION n1, NATION n2, REGION 
where p_partkey = l_partkey 
and s_suppkey = l_suppkey 
and l_orderkey = o_orderkey 
and o_custkey = c_custkey 
and c_nationkey = n1.n_nationkey 
and n1.n_regionkey = r_regionkey 
and r_name = 'ASIA'	
and s_nationkey = n2.n_nationkey 
and o_orderdate between date '1995-01-01' 
and date '1996-12-31'
and p_type = 'SMALL PLATED COPPER') as all_nations 
group by o_year order by o_year;

CREATE INDEX idx_orders USING BTREE ON orders (o_orderdate, orderkey, o_custkey);
CREATE INDEX idx_part USING HASH ON part (p_type, p_partkey);
CREATE INDEX idx_lineitem USING HASH ON lineitem (l_orderkey, l_suppkey, l_partkey, l_extented, l_discount);
CREATE INDEX idx_nation USING HASH ON nation (n_name, n_nationkey);
CREATE INDEX idx_region USING HASH ON region (r_name, r_regionkey);
CREATE INDEX idx_supplier USING HASH ON supplier (s_nationkey, s_suppkey);
CREATE INDEX idx_customer USING HASH ON customer (c_nationkey, n_custkey);

DROP INDEX idx_orders ON orders;
DROP INDEX idx_part ON part;
DROP INDEX idx_lineitem ON lineitem;
DROP INDEX idx_nation ON nation;
DROP INDEX idx_region ON region;
DROP INDEX idx_supplier ON supplier;
DROP INDEX idx_customer ON customer;