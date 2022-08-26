insert into produto(nome)
values
		('Jogo'),
        ('Gift Card'),
        ('Assinatura');

insert into distribuidora(d_login,d_senha,d_nome,tipo,d_cpf,d_cnpj,d_endereco,d_email,d_telefone)
values
		('revolver','revolversenha','Revolver Digital','Dev',null,'aa-aaa-aaa/aaaa-aa','endereço genérico','email genérico','telefone generico'),
        ('semImaginacao','senhagenerica1','Sem criatividade','Pub',null,'bb-bbb-bbb/bbbb-bb','endereço genérico #2','e-mail sem criatividade','+00 000 0000-0000'),
        ('preguiça','senhagenerica2','Preguiça de preencher','Dev','111.111.111-11',null,'endereço de casa','e-mail de 2009','+00 001 1111-1111'),
        ('bandai','senhagenerica3','Bandai Namco','Pub',null,'22-333-333/4444-22','algum lugar no japao provavelmente','email generico2','telefone generico2');
        
insert	into jogo(j_nome, data_lanc, classificacao, categoria, specs, preco, id_produto, unidades_vendidas, qnt_chave, id_dist, data_cadastro)
values
	('Wizard with a gun','2022-10-05','adult','survival','generico','60.00','1','12345','1234567','1','2022-06-24'),
    ('Cult of the lamb','2022-08-15','adult','survival','generico','50.00','1','1357','12345','2','2022-07-20'),
    ('Não sei','2025-01-24','family','party','generico','34.50','1','0','0','2','2022-09-21'),
    ('aaaaaaa','2022-05-21','children','roguelite','generico','20.00','1','1','120','2','2022-07-11'),
    ('bbbbbbb','2019-07-23','adult','RPG','generico','37.00','1','123623','1256237','3','2021-09-11');

insert into plataforma(plat_nome)
values
		('Microsoft'),
        ('Uplay'),
        ('Console'),
        ('Mobile');
        
insert into usuarios(login,u_senha,nome_exibicao,data_nasc,endereco,cpf)
values
		('psicopato','senha da ju','Psicopato','1992-05-07','minha casa','333.333.333-22'),
        ('fulano','senhafraca4','Nome_Genérico','1994-10-22','algum lugar','222.222.222-11'),
        ('ciclano','senhamediana','Sem_Criatividade','2000-06-21','não faço ideia','663.743.252-56'),
        ('beltrano','senhaforte','Alguém','2006-02-16','lugar nenhum','352.677.152-64');

insert into carrinho(id_jogo, id_assinatura,id_card, id_usuario, ativo)
values
	('1',null,null,'4', true),
	('2',null,null,'3', true),
	('1',null,null,'2', true),
	('3',null,null,'2', true),
	('1',null,null,'1', true);

insert into pedido(estado, data_ped, pagamento, p_id_cart)
values
        ('completo','2022-07-22', 'pix','1'),
		('pendente','2022-07-18','credito','2'),
        ('pendente','2022-10-05','boleto','3'),
        ('pendente','2022-07-03','credito','4'),
        ('pendente','2021-09-10','pix','5');

-- update pedido set estado = 'completo' where id_pedido = 1;