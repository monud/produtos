<%@page import="br.com.caelum.produtos.modelo.Produto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Listando os Produtos</title>
</head>
<body>
	<script type="text/javascript">
		function removeProduto(id){
			$("#mensagem").load('<c:url value="/produto/remove"/>' + '?produto.id=' + id);
			$("#produto" + id).remove();
		}
	</script>
	<h2><fmt:message key="${mensagem.bemvindo}"/></h2>
	<br/>
	<h1>Produtos</h1>
	<br/>
	
	<div id="mensagem"></div>
	<table width="100%">
		<tr>
			<td width="20%">Nome</td>
			<td>Preco</td>
			<td>Descricao</td>
			<td>Data de Inicio da Venda</td>
			<td>Usado?</td>
			<td>Contador</td>
			<td width="20%">Remover?</td>
		</tr>
		
		<%-- <%
			List<Produto> produtoList = (List<Produto>) request.getAttribute("produtoList");
			for(Produto p : produtoList) {
			<tr id="produto<%= p.getId() %>">
				<td><%= p.getNome().toUpperCase() %></td>
				<td><%= p.getPreco() %></td>
				<td><%= p.getDescricao() %></td>
				<td><%= p.getDataInicioVenda().getTime() %></td>
				<% if(p.isUsado()) { %>
				<td>Sim</td>
				<% } else { %>
				<td>Não</td>
				<% } %>
				<td><a href="#" onclick="return removeProduto(<%= p.getId() %>)">Remover</a></td>
			</tr>
		<%
			}
		%> --%>
		<c:forEach items="${produtoList}" var="p" varStatus="prod">
		
			<tr id="produto${p.id}">
				<td>${p.nome.toUpperCase()}</td>
				<%-- Código substituido pelo código abaixo para aprender a tag de formatação
				<td>${p.preco}</td> --%>
				<td>
					<fmt:formatNumber value="${p.preco}" type="currency"/>
				</td>
				
				<td>${p.descricao}</td>
				
				<%-- Código substituido pelo código abaixo para aprender a tag de formatação
				<td>${p.dataInicioVenda.time}</td> --%>
				<td>
				<fmt:formatDate value="${p.dataInicioVenda.time}" pattern="dd/MM/yyyy" /> 
				</td>
				
				<%-- Substituido pelo código mais parecido com if / else = choose
				<c:if test="${p.usado}">
					<td>Sim</td>
				</c:if>
				<c:if test="${not p.usado}">
					<td>Não</td>
				</c:if> --%>
				<c:choose>
					<c:when test="${p.usado}">
						<td>Sim</td>
					</c:when>
					<c:otherwise>
						<td>Não</td>
					</c:otherwise>
				</c:choose>
				<td>${prod.count}</td>
				<td><a href="#" onclick="return removeProduto(${p.id})">Remover</a></td>
			</tr>
			</c:forEach>
		
	</table>
	<!-- Adicionando a tag url do JSTL abaixo
	<a href="/produtos/produto/formulario">Adicionar um produto</a> -->
	<c:url value="/produtos/produto/formulario" var="urlAdicionar"/>
	<fmt:message key="${mensagem.addProduto}"/>
	<a href="${urlAdicionar}">Adicionar um produto</a>
	<c:import url="../_comum/rodape.jsp" />
</body>
</html>