EXPLAIN select s_name, s_address 
from SUPPLIER, NATION 
where s_suppkey in ( select ps_suppkey 
	from PARTSUPP 
	where ps_partkey in (select p_partkey 
		from PART where p_name like 'green%') 
	and ps_availqty > (select 0.5 * sum(l_quantity) 
		from LINEITEM 
        where l_partkey = ps_partkey 
		and l_suppkey = ps_suppkey 
		and l_shipdate >= date '1993-01-01' 
and l_shipdate < date '1993-01-01' + interval '1' year)) 
and s_nationkey = n_nationkey 
and n_name = 'ALGERIA' 
order by s_name;

CREATE INDEX idx_supplier USING HASH ON supplier (s_suppkey, s_nationkey, s_name);
CREATE INDEX idx_nation USING HASH ON nation (n_nationkey, n_name);
CREATE INDEX idx_lineitem USING BTREE ON lineitem (l_shipdate, l_suppkey, l_partkey);

DROP INDEX idx_supplier ON supplier;
DROP INDEX idx_nation ON nation;
DROP INDEX idx_lineitem ON lineitem;