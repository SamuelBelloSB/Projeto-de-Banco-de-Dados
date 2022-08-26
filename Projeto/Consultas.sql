-- 1
explain Select j_nome from jogo where categoria = "RPG" and preco > 50;

-- 2
explain select * from jogo a, plataforma_jogo b, plataforma c 
where a.categoria = "Corrida" and a.preco > 100 and a.id_jogo = b.p_id_jogo and b.id_plataforma = c.id_plataforma and c.plat_nome = "Microsoft";

-- 3
select sum(faturamento) as total_fat
from distribuidora a, distribuidora_jogo b
where a.d_nome = "Bandai Namco" and a.id_dist = b.id_dist;

-- 4
select sum(qtd) as vendas
from pedido a, item_pedido b
where a.data_ped between 2022-06-03 and 2022-06-03;

-- 5
select sum(preco) as valor
from jogo a, carrinho b, pedido c, usuarios d
where a.id_jogo = b.id_jogo and b.id_usuario = d.id_usuario and c.p_id_cart = b.id_cart and c.estado = "completo" and d.login = "psicopato";


-- 6
select count(p_id_jogo) as qtd_jogos
from plataforma a, jogo b, plataforma_jogo c
where a.id_plataforma = c.id_plataforma and b.id_jogo = c.p_id_jogo and a.plat_nome = "Uplay";

-- 7
select count(id_usuario) as usuario_com_compras
from carrinho a, pedido b
where b.estado = "Completo" and a.id_cart = b.p_id_cart;

-- 8
select avg(preco) as gastos
from carrinho a, jogo b, item_pedido c, pedido d, usuarios e
where a.id_jogo = b.id_jogo and e.login = "psicopato" and d.data_ped between date_sub(now(), INTERVAL 11 MONTH) and now() and d.estado = "completo";

-- 9
select avg(preco) as media_vendas
from carrinho a, jogo b, pedido c
where c.estado = "completo" and a.id_jogo = b.id_jogo and b.unidades_vendidas>100;

-- 10
select sum(preco)/count(id_cart) as vendas
from carrinho a, jogo b, distribuidora d, pedido e, distribuidora_jogo f
where month(data_ped) = month(current_date()) and a.id_jogo = f.id_jogo and d.id_dist = f.id_dist and e.estado = "completo";