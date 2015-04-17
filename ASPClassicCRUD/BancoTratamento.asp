<%
''======================================================
'' RESUMO DESCRITIVO DA PÁGINA
''======================================================
''
'' Nome da página: BancoTratamento.asp
'' Funcionalidade: Faz todas as requisições do banco
'' via o pedido AJAX.
'' 
''======================================================
'' Atualizações:
'' Data: 10/04/2015 > Anderson Araujo Firmino, 
'' Desenvolveu toda a logica na página. 
''
''======================================================
''					INCLUDES
''======================================================
%>
<!--#include file="bco.asp"-->
<%
''======================================================
'' Pegar os dados do banco e mostrar na tela.
''======================================================	
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * FROM nomes"
	rs.Open sql, bco
		If not rs.eof then
		%><table border="1"><%
			Do while not rs.eof
						codigo = rs("codigo")
						%>
						<td>Codigo:<span id="codigoPessoa"> <%=codigo%></span></td>	
						<td align='center'>Nome: <span id='pessoa'><%=rs("nome")%></span></td>
						<td>Idade: <%=rs("idade")%></td>
						<td><button onclick="atualizar(<%=codigo%>)">Atualizar</button></td>
						<td><button onclick="deletar(<%=codigo%>)">Remover</button></td>
						</tr>
						<%
						'nota: ali acima tem um onClick eu não consegui fazer isso de outra maneira... :s
						'com JQuery ou com addEventListener		

					rs.movenext
				loop
			%></table><%
		Else
			Response.Write("Nenhuma Pessoa Encontrada na tabela.")
		End If
	rs.Close
	Set rs = Nothing
''======================================================
'' Executa um DELETE caso receba um request do delete
''======================================================	
	cod = Request("delete")
	If cod <> "" Then 
		sql = "DELETE FROM nomes WHERE codigo ="&cod
		bco.Execute(sql)
	End If 
''======================================================	
'' Executa um Insert caso receba um request de nomeP 
'' e idade p 
''======================================================	
	nomeP = Request("nomeP")
	idadeP = Request("idadeP")
	If nomeP <> "" And IdadeP <> "" Then 
		sql = "INSERT INTO nomes (nome, idade)VALUES('"&nomeP&"', '"&idadeP&"')"
		bco.Execute(sql)
	End If
''========================================================
'' Executa Update caso receba um request de nomeU e idadeU
''========================================================
	nomeU = Request("nomeU")
	idadeU = Request("idadeU")
	codU = Request("codU")

	If nomeU <> "" And idadeU <> "" And codU <> "" Then 
		sql = "UPDATE nomes SET nome = '"&nomeU&"', idade = '"&idadeU&"' WHERE codigo = "&codU&""
		bco.Execute(sql)		
	End If
''========================================================
%>
