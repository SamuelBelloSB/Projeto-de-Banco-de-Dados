create view vw_distribuidor as
Select count(id_chaveres) as qtd_chaves, data_cadastro, faturamento
from chave_resgatada a, jogo b, distribuidora c, distribuidora_jogo d
Where b.id_dist = c.id_dist and a.id_jogo = b.id_jogo and d.id_dist = c.id_dist;

create view vw_atendente as
select id_pedido, data_ped, pagamento 
from pedido a, carrinho b, tickets c
where b.id_usuario = c.id_usuario and b.id_cart = a.p_id_cart;