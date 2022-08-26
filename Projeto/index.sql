CREATE INDEX idx_jogo_b USING BTREE ON jogo (preco);

CREATE INDEX idx_jogo_h USING HASH ON jogo (categoria, preco, id_jogo);

CREATE INDEX idx_plataforma USING HASH ON plataforma (plat_nome, id_plataforma);

CREATE INDEX idx_plataforma_jogo USING HASH ON plataforma_jogo (p_id_jogo, id_plataforma);

CREATE INDEX idx_distribuidora USING HASH ON distribuidora(d_nome, id_dist);

CREATE INDEX idx_distribuidora_jogo USING HASH ON distribuidora_jogo (id_jogo, id_dist);

CREATE INDEX idx_pedido_data USING BTREE ON pedido (data_ped);

CREATE INDEX idx_carrinho USING HASH ON carrinho (id_jogo, id_usuario, id_cart);

CREATE INDEX idx_pedido USING HASH ON pedido (p_id_cart, estado);

CREATE INDEX idx_usuario USING HASH ON usuarios (login, id_usuario);