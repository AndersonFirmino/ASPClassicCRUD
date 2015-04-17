/*!
 * Arquivo com as regras e lógica da pagina.
 * Por: Anderson Araujo Firmino
 *
 * Data: 10/04/2014
 */
$(function() {
	console.log('Carregou JavaScript!');
	//SELECT
	try {
		carregarDados();
	} catch (e) {
		console.log(e);
	}


	$("#gravar").click(inserir);
});
//SELECT
function carregarDados() {
	$.post('BancoTratamento.asp', function(data) {
		$("#conteudo").html(data);
	});
};

//Alguns functions devem ficar fora para serem vistos quando se mistura ASP3 e JavaScript
function deletar(codigo) {
	//DELETE
	try {
		console.log('Removeu codigo =' + codigo);
		$.post('BancoTratamento.asp?delete=' + codigo);
		carregarDados();

	} catch (e) {
		console.log(e);
	}
}

function alerta(mensagem) {
	var segundos = 5;
	$("#obg").fadeIn(2000).css({
		"color": "Red",
		"visibility": "visible"
	}).text(mensagem);
	setTimeout(function() {
		$("#obg").fadeOut(1000);
	}, segundos * 1000);
}

function inserir() {
		//INSERT
		try {
			var nome = $("#nome").val();
			var idade = $("#idade").val();
			if (nome !== "" && idade !== "") {
				console.log("Gravou: nome = " + nome + " e Idade = " + idade);
				$.post("BancoTratamento.asp?nomeP=" + nome + "&idadeP=" + idade);
				$.post('BancoTratamento.asp', function(data) {
					carregarDados();
					$("#nome").val("");
					$("#idade").val("");
				});
			} else {
				alerta("Por favor preencha os campos antes de tentar gravar.");
			}



		} catch (e) {
			console.log(e);
		}
	}
	//UPDATE
function atualizar(codigo) {
	var nome;
	var idade;


	nome = prompt("Digite o novo nome:", "");
	idade = prompt("Digite a nova idade: ", "");

	if ((nome === "" || nome === null) && (idade === "" || idade === null)) {
		alerta("Por favor preencha os campos para que ocorra a atualização.");
		
	} else {
		try {
			console.log("Nome: " + nome + ", idade: " + idade + ", codigo: " + codigo);
			//URL com variaveis de url sempre tem que estar juntas o sinal de '=' exemplo: teste.html?var=1
			//Se tiver separado ao mandar por requisição ajax ira dar varias dor de cabeça;
			var pagina = 'BancoTratamento.asp?codU=' + codigo + '&nomeU=' + nome + '&idadeU=' + idade;
			$.post(pagina, function(data) {
				console.log(pagina);
				carregarDados();
			});


		} catch (e) {
			console.log(e);
		}

	};

};