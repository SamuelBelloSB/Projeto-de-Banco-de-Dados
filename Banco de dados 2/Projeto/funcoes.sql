drop function if exists desconto;
Delimiter //
Create function desconto(codigo_jogo int, taxa decimal(10,2)) 
Returns int
Begin 

	Update jogo_promocao

	Set  preco_com_desconto = (select preco - (preco * (taxa/100)) from jogo a where a.id_jogo = codigo_jogo)

	Where id_jogo = codigo_jogo; 

Return 1; 

End//
Delimiter ;

drop function if exists faturamento_jogo;
Delimiter //
create function faturamento_jogo (valor decimal(10,2), fatura decimal(10,2), jogo int, distribuidora int)
Returns decimal (10,2)

begin
	 return fatura + valor;
    
	-- return 1;
end//
delimiter ;

drop function if exists verificacao_disponibilidade;
Delimiter //
create function verificacao_disponibilidade(jogo_id int)
returns int

begin
	if (Select qnt_chave from jogo a where a.id_jogo = jogo_id) > 0
	then update jogo set disponivel = 1;
    else update jogo set disponivel = 0;
    end if;
    return 1;
end//
delimiter ;

drop function if exists decrementar_chaves;
Delimiter //
create function decrementar_chaves(jogo int, chave int)
returns int

begin
	update jogo set qnt_chave = chave-1 where jogo.id_jogo = jogo;
    
    return 1;
end//
delimiter ;

drop function if exists incrementar;
Delimiter //

create function incrementar(quant_jogo int)

returns int

begin

 return quant_jogo + 1;

end//

delimiter ;