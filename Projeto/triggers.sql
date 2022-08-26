drop trigger if exists tg_reserva_chave;
delimiter //
create trigger tg_reserva_chave after insert on pedido
for each row

begin
	insert into chave_resgatada(id_pedido, id_jogo)
    select MAX(id_pedido), id_jogo from pedido inner join carrinho where pedido.p_id_cart = carrinho.id_cart and pedido.estado = 'pendente';
end//
delimiter ;

drop trigger if exists tg_gerar_chave;
delimiter //
create trigger tg_gerar_chave before update on pedido
for each row 

begin
    if (new.estado ='completo' and (select id_pedido = pedido.id_pedido and chave_resgatada.id_chave) is null) then
       insert into chave_resgatada(id_chave)
       select id_chave from chaves a, item_pedido b, pedido c where a.id_jogo = b.id_jogo and a.key_estado = 'disponivel';
    end if;
end//
delimiter ;

drop trigger if exists tg_chave_indisponivel;
delimiter //
create trigger tg_chave_indisponivel after update on pedido
for each row

begin
	update chaves set key_estado = 'indisponivel' where chaves.id_chave = chaves_resgatadas.id_chave and chaves.key_estado = "disponivel";
end//
delimiter ;

drop trigger if exists tg_limpar_carrinho;
delimiter //
create trigger tg_limpar_carrinho before insert on pedido
for each row

begin
	update carrinho set ativo = false where carrinho.ativo = true and carrinho.id_cart = new.p_id_cart;
end//
delimiter ;

drop trigger if exists tg_novo_carrinho;
delimiter //
create trigger tg_novo_carrinho after insert on pedido
for each row

begin
	insert into carrinho(id_jogo, id_assinatura, id_card, id_usuario, ativo) 
    values (null, null, null, "1" , true);
    -- não sei como puxar usuario do login ativo
end//
delimiter ;

drop trigger if exists tg_venda;
delimiter //
create trigger tg_venda after update on pedido
for each row

begin
	update jogo set unidades_vendidas = unidades_vendidas + 1 
    where jogo.id_jogo = item_pedido.id_jogo and item_pedido.id_pedido = pedido.item_pedido and pedido.estado = 'completo';
end//
delimiter ;

drop trigger if exists tg_faturamento;
delimiter //
create trigger tg_faturamento after update on pedido
for each row
begin
	if pedido.estado = "completo" then update distribuidora_jogo set faturamento = faturamento_jogo(jogo.preco, distribuidora_jogo.faturamento, distribuidora_jogo.id_jogo, distribuidora_jogo.id_dist);
    end if;
end//
delimiter ;

drop trigger if exists jogo_em_promocao;
delimiter //
create trigger jogo_em_promocao before insert on jogo_promocao
for each row

begin
	update jogo_promocao set preco_com_desconto = desconto(new.id_jogo, 0.25);
end//
delimiter ; 

drop trigger if exists tg_incrementar_vendas;
delimiter //
create trigger tg_incrementar_vendas after update on pedido
for each row

begin
	if pedido.estado = "completo" then select incrementar(jogo.unidades_vendidas, pedido.estado) where MAX(pedido.id_pedido) = pedido.id_pedido and pedido.p_id_cart = carrinho.id.cart and carrinho.id_jogo = jogo.id_jogo;
	end if;
end//
delimiter ;
