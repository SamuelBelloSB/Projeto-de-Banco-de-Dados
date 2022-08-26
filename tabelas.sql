create table if not exists usuarios (
  id_usuario int auto_increment not null,
  login varchar(30) not null,
  u_senha varchar(30) not null,
  nome_exibicao varchar(50) not null,
  data_nasc date not null,
  endereco varchar(50) not null,
  cpf varchar(14) not null,
  
  constraint pk_user primary key (id_usuario)
);

create table if not exists atendentes (
  id_atendente int auto_increment not null,
  at_nome varchar(50) not null,
  cpf varchar(14) not null,
  
  constraint pk_agent primary key (id_atendente)
);

create table if not exists faq(
  id_faq int auto_increment not null,
  f_descricao varchar(100) not null,
  anexos blob,
  resposta varchar(280) not null,
  
  constraint pk_faq primary key (id_faq)
);

create table if not exists admin(
  id_admin int auto_increment not null,
  a_login varchar(16) not null,
  a_senha varchar(30) not null,
  a_nome varchar(50) not null,
  cpf varchar(14) not null,
  
  constraint pk_admin primary key(id_admin)
);

create table if not exists produto(
  id_produto int auto_increment not null,
  nome varchar(50),
  
  constraint pk_prod primary key(id_produto)
);

create table if not exists plataforma(
  id_plataforma int auto_increment not null,
  plat_nome varchar(100) not null,
  
  constraint pk_plat primary key(id_plataforma)
);

create table if not exists sistema(
  id_sistema int auto_increment not null,
  sist_nome varchar(100) not null,
  id_plataforma int not null,
  
  constraint pk_sist primary key(id_sistema),
  constraint fk_plat foreign key(id_plataforma)
  references plataforma(id_plataforma)
);

create table if not exists distribuidora(
  id_dist int auto_increment not null,
  d_login varchar(50) not null,
  d_senha varchar(30) not null,
  d_nome varchar(500) not null,
  tipo varchar(10) not null,
  d_cpf varchar(14),
  d_cnpj varchar(24),
  d_endereco varchar(100) not null,
  d_email varchar(25) not null,
  d_telefone varchar(20) not null,
  
  constraint pk_dist primary key(id_dist)
);

create table if not exists jogo(
  id_jogo int auto_increment not null,
  j_nome varchar(100) not null,
  data_lanc date not null,
  classificacao varchar(10) not null,
  categoria varchar(10) not null,
  specs varchar(100) not null,
  preco decimal(10,2) not null,
  id_produto int not null,
  unidades_vendidas int not null,
  qnt_chave int not null,
  id_dist int not null,
  data_cadastro date not null,
  disponivel int,
  
  
  constraint pk_jogo primary key(id_jogo),
  constraint fk_jogo_prod foreign key(id_produto)
  references produto(id_produto),
  constraint fk_jogo_dist foreign key(id_dist)
  references distribuidora(id_dist)
);

create table if not exists chaves(
  id_chave int auto_increment not null,
  key_estado varchar(10) not null,
  id_jogo int not null,
  
  constraint pk_chave primary key(id_chave),
  constraint fk_jogo_key foreign key(id_jogo)
  references jogo(id_jogo)
);

create table if not exists assinatura(
  id_assinatura int auto_increment not null,
  ass_nome varchar(100) not null,
  ass_preco int not null,
  id_produto int not null,
  
  constraint pk_ass primary key(id_assinatura),
  constraint fk_ass_prod foreign key(id_produto)
  references produto(id_produto)
);

create table if not exists gift_card(
  id_card int auto_increment not null,
  g_nome varchar(100) not null,
  g_preco int not null,
  id_produto int not null,
  qtd_codigo int not null,
  
  constraint pk_gift primary key(id_card),
  constraint fk_gift_prod foreign key(id_produto)
  references produto(id_produto)
);

create table if not exists codigo(
  id_codigo int auto_increment not null,
  cod_estado varchar(10) not null,
  id_card int not null,
  
  constraint pk_cod primary key(id_codigo),
  constraint fk_card foreign key(id_card)
  references gift_card(id_card)
);

create table if not exists wishlist(
  id_lista int auto_increment not null,
  id_usuario int not null,
  id_produto int not null,
  
  constraint pk_lista primary key(id_lista),
  constraint fk_lista_user foreign key(id_usuario)
  references usuarios(id_usuario),
  constraint fk_lista_prod foreign key(id_produto)
  references produto(id_produto)
);

create table if not exists carrinho(
  id_cart int auto_increment not null,
  id_jogo int,
  id_assinatura int,
  id_card int,
  id_usuario int not null,
  ativo bool not null,
  
  constraint pk_cart primary key(id_cart),
  constraint fk_cart_user foreign key(id_usuario)
  references usuarios(id_usuario),
  constraint fk_cartjogo foreign key(id_jogo)
  references jogo(id_jogo),
  constraint fk_cartass foreign key(id_assinatura)
  references assinatura(id_assinatura),
  constraint fk_cartgift foreign key(id_card)
  references gift_card(id_card)
);

create table if not exists pedido(
  id_pedido int auto_increment not null,
  status varchar(50) not null,
  data_ped date not null,
  pagamento varchar(100) not null,
  p_id_cart int not null,
  
  constraint pk_ped primary key (id_pedido),
  constraint fk_cart foreign key(p_id_cart)
  references carrinho(id_cart)
);

create table if not exists item_pedido(
  id_item int auto_increment not null,
  id_pedido int not null,
  qtd int not null,
  
  constraint pk_itemped primary key(id_item,id_pedido),
  constraint fk_itemped foreign key(id_pedido)
  references pedido(id_pedido)
);

create table if not exists tickets(
  id_ticket int auto_increment not null,
  t_descricao varchar(280) not null,
  comentarios varchar(280) not null,
  data_ticket date not null,
  id_usuario int not null,
  id_atendente int not null,
  t_id_pedido int not null,
  
  constraint pk_tick primary key(id_ticket),
  constraint fk_agent foreign key(id_atendente)
  references atendentes(id_atendente),
  constraint fk_tick_user foreign key(id_usuario)
  references usuarios(id_usuario),
  constraint fk_ped foreign key(t_id_pedido)
  references pedido(id_pedido)
);

create table if not exists plataforma_jogo(
  id_plataforma int not null,
  p_id_jogo int not null,
  
  constraint pk_platjogo primary key(id_plataforma, p_id_jogo),
  constraint fk_platjogo foreign key(id_plataforma)
  references plataforma(id_plataforma),
  constraint fk_jogoplat foreign key(p_id_jogo)
  references jogo(id_jogo)
);

create table if not exists plataforma_sistema(
  id_plataforma int not null,
  id_sistema int not null,
  
  constraint pk_platsis primary key(id_plataforma, id_sistema),
  constraint fk_platsis foreign key(id_plataforma)
  references plataforma(id_plataforma),
  constraint fk_sisplat foreign key(id_sistema)
  references sistema(id_sistema)
);

create table if not exists sistema_jogo(
  id_jogo int not null,
  id_sistema int not null,
  
  constraint pk_sisjogo primary key(id_jogo, id_sistema),
  constraint fk_sisjogo foreign key(id_sistema)
  references sistema(id_sistema),
  constraint fk_jogosis foreign key(id_jogo)
  references jogo(id_jogo)
);

create table if not exists chave_resgatada(
	id_chaveres int auto_increment not null,
    id_chave int,
    id_pedido int not null,
    id_jogo int not null,
    
    constraint pk_chaveres primary key(id_chaveres),
    constraint fk_chaveres foreign key(id_chave)
    references chaves(id_chave),
    constraint fk_chaveped foreign key(id_pedido)
    references pedido(id_pedido),
    constraint fk_distped foreign key(id_jogo)
    references jogo(id_jogo)
);

create table if not exists codigo_resgatado(
	id_codres int not null,
    id_codigo int not null,
    id_pedido int not null,
    
    constraint pk_codres primary key(id_codres),
    constraint fk_codres foreign key(id_codigo)
    references codigo(id_codigo),
    constraint fk_codped foreign key(id_pedido)
    references pedido(id_pedido)
);

create table if not exists promocao(
  id_promocao int auto_increment not null,
  p_nome varchar(100) not null,
  tempo int not null,
  
  constraint pk_promo primary key(id_promocao)
);

create table if not exists jogo_promocao(
  id_promocao int not null,
  id_jogo int not null,
  preco_com_desconto int not null,
  
  constraint pk_jogopromo primary key(id_promocao, id_jogo),
  constraint fk_jogopromo foreign key(id_jogo)
  references jogo(id_jogo),
  constraint fk_promojogo foreign key(id_promocao)
  references promocao(id_promocao)
);

create table if not exists distribuidora_jogo(
  id_dist int not null,
  id_jogo int not null,
  faturamento decimal(10,2) not null,
  
  constraint pk_distjogo primary key(id_dist,id_jogo),
  constraint fk_distjogo foreign key(id_dist)
  references distribuidora(id_dist),
  constraint fk_jogodist foreign key(id_jogo)
  references jogo(id_jogo)
);

