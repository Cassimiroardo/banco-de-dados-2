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
	b.codcliente,
	b.nome	
from pedido as a
join cliente as b
on a.codcliente = b.codcliente
where b.uf = 'RS' OR b.uf = 'SC' 
and datediff(a.prazoentrega,a.datapedido) > 10
group by b.codcliente 
order by b.codcliente;

-- 6 | Mostrar os clientes e seus respectivos prazos de entrega,
-- ordenando do maior para o menor.

select
	b.codcliente,
	b.nome,
	a.prazoentrega as prazo
from pedido as a
join cliente as b
on a.codcliente = b.codcliente
order by a.prazoentrega desc;


-- 7 | Apresentar os vendedores, em ordem alfabética, 
-- que emitiram pedidos com prazos de entrega superiores a 15 dias
-- e que tenham salários fixos iguais ou superiores a R$ 1.000,00

select 
	a.codvendedor,
	a.nome
from vendedor as a
join pedido as b
on a.codvendedor = b.codvendedor
where datediff(b.prazoentrega,b.datapedido) > 15
AND salariofixo >= 1000.00
group by codvendedor
order by nome asc;    

-- 8 |  Os vendedores têm seu salário fixo acrescido de 20% da soma dos valores dos pedidos.
-- Faça uma consulta que retorne o nome dos funcionários e o total de comissão, desses funcionários

select
	a.codvendedor,
    sum(c.quantidade*d.valorunitario)*0.02 as comissão
from vendedor as a
join pedido as b
on a.codvendedor = b.codvendedor
right join itempedido as c
on b.codpedido = c.codpedido
right join produto as d
on c.codproduto = d.codproduto
group by a.codvendedor
order by comissão asc;

-- 9 | Os clientes e os respectivos vendedores que fizeram algum pedido 
-- para esse cliente juntamente com a data do pedido.

select
	a.codcliente,
    a.nome as cliente,
    b.codvendedor,
    c.nome as vendedor,
    b.datapedido
from cliente as a
left join pedido as b
on a.codcliente = b.codcliente
left join vendedor as c
on b.codvendedor = c.codvendedor
order by a.codcliente,
		 c.codvendedor;

-- 10 | Liste o nome do cliente e a quantidade de pedidos de cada cliente.

select
	a.codcliente,
	a.nome,
    count(b.codpedido) as total
from cliente as a
left join pedido as b
on a.codcliente = b.codcliente
group by a.codcliente
order by total,codcliente;

