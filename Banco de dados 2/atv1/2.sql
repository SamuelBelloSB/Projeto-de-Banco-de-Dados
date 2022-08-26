EXPLAIN select s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment 
from PART, SUPPLIER, PARTSUPP, NATION, REGION 
where p_partkey = ps_partkey 
and s_suppkey = ps_suppkey 
and p_size = 30 
and p_type like '%STEEL' 
and s_nationkey = n_nationkey 
and n_regionkey = r_regionkey 
and r_name = 'ASIA' 
and ps_supplycost = (select min(ps_supplycost) 
from PARTSUPP, SUPPLIER, NATION, REGION 
where p_partkey = ps_partkey 
and s_suppkey = ps_suppkey 
and s_nationkey = n_nationkey 
and n_regionkey = r_regionkey 
and r_name = 'ASIA') order by s_acctbal desc, n_name, s_name, p_partkey limit 100;

CREATE INDEX idx_part USING HASH ON part (p_size, p_type, p_partkey);
CREATE INDEX idx_partsupp USING HASH ON partsupp (ps_supplycost, ps_suppkey, ps_partkey);
CREATE INDEX idx_nation USING HASH ON nation (n_name, n_regionkey, n_nationkey);
CREATE INDEX idx_region USING HASH ON region (r_name, r_regionkey);
CREATE INDEX idx_supplier USING HASH ON supplier (s_acctbal, s_name, s_suppkey, s_nationkey);

DROP INDEX idx_part ON part;
DROP INDEX idx_partsupp ON partsupp;
DROP INDEX idx_nation ON nation;
DROP INDEX idx_region ON region;
DROP INDEX idx_supplier ON supplier;
