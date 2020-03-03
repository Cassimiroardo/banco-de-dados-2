USE compubras;

-- 1 | Mostrar a quantidade pedida para um determinado produto com um determinado
-- código a partir da tabela item de pedido.       

SELECT b.CodPedido,
	   a.Descricao,
       SUM(b.quantidade) AS total
  FROM produto AS a
  INNER JOIN itempedido AS b
  WHERE a.CodProduto = b.CodProduto
  GROUP BY b.CodPedido,
		   a.CodProduto;
  
-- 2 | Listar a quantidade de produtos que cada pedido contém.

