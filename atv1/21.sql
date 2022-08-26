EXPLAIN select s_name, count(*) as numwait 
from SUPPLIER, LINEITEM l1, ORDERS, NATION 
where s_suppkey = l1.l_suppkey 
and o_orderkey = l1.l_orderkey 
and o_orderstatus = 'F' 
and l1.l_receiptdate > l1.l_commitdate 
and exists ( select * from LINEITEM l2 
	where l2.l_orderkey = l1.l_orderkey 
    and l2.l_suppkey <> l1.l_suppkey) 
and not exists (select * 
	from LINEITEM l3 
    where l3.l_orderkey = l1.l_orderkey 
    and l3.l_suppkey <> l1.l_suppkey 
    and l3.l_receiptdate > l3.l_commitdate) 
and s_nationkey = n_nationkey 
and n_name = 'EGYPT' 
group by s_name 
order by numwait desc, s_name limit 100;

CREATE INDEX idx_supplier USING HASH ON supplier (s_suppkey, s_nationkey, s_name);
CREATE INDEX idx_lineitem USING HASH ON lineitem (l_suppkey, l_orderkey, l_receiptdate, l_commitdate);
CREATE INDEX idx_nation USING HASH ON nation (n_nationkey, n_name);

DROP INDEX idx_supplier ON supplier;
DROP INDEX idx_lineitem ON lineitem;
DROP INDEX idx_nation ON nation;