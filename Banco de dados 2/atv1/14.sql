select 100.00 * sum(case when p_type like 'PROMO%' then l_extendedprice * (1 - l_discount) else 0 end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue 
from LINEITEM, PART 
where l_partkey = p_partkey 
and l_shipdate >= date '1996-12-01' 
and l_shipdate < date '1996-12-01' + interval '1' month;

CREATE INDEX idx_lineitem USING BTREE ON lineitem (l_shipdate, l_partkey);
CREATE INDEX idx_part USING HASH ON part (p_type, p_partkey);

DROP INDEX idx_lineitem ON lineitem;
DROP INDEX idx_part ON part;