USE compubras;

-- 1 | Mostrar a quantidade pedida para um determinado produto com um determinado
-- código a partir da tabela item de pedido.       

select 
	a.codproduto,
	a.descricao,
	coalesce(sum(b.quantidade), 0) as total
from produto as a 
left join itempedido as b
on a.codproduto = b.codproduto 	
group by b.codproduto, a.codproduto
order by b.codproduto;
  
-- 2 | Listar a quantidade de produtos que cada pedido contém.

select
	a.codpedido,
	coalesce(sum(b.quantidade), 0)
from pedido as a
left join itempedido as b
on a.codpedido = b.codpedido
group by codpedido
order by codpedido, codproduto;

-- 3 | Ver os pedidos de cada cliente, listando nome do cliente e número do pedido.

select
	a.codcliente,
	a.nome,
    b.codpedido
from cliente as a
join pedido as b
on a.codcliente = b.codcliente
order by codpedido asc,
		 codcliente asc;

-- 4 | Listar todos os clientes com seus respectivos pedidos.
-- os clientes que não têm pedidos também devem ser apresentados

select 
	a.codcliente,
    a.nome,
    coalesce(b.codpedido,'sem pedido') as pedido
from cliente as a
left join pedido as b
on a.codcliente = b.codcliente
order by codpedido, codcliente;

-- 5 | Clientes com prazo de entrega superior a 10 dias e que pertençam
-- aos estados do Rio Grande do Sul ou Santa Catarina. 

select 
	b.nome,
	timestampdiff(day,a.datapedido,a.prazoentrega)
from pedido as a
join cliente as b
on a.codcliente = b.codcliente
order by codpedido;
