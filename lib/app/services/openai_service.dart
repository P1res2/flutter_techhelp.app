import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_techhelp_app/app/services/api_service.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey = dotenv.env['API_KEY'] ?? '';
  final ApiService _apiService = ApiService();

  Future<String> sendMessage(String msg, int idCliente) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");
    const String _sucessMessage = 'Eu criei um chamado para você, em breve um técnico entrara em contato para solucionar o seu problema. Confira a sua página inicial para ver os seus chamados.';
    const String _failMessage = 'Não foi possivel criar o seu chamado no momento, tente novamente mais tarde.';
    String message =
        """Você é um assistente que transforma mensagens de usuários em um objeto JSON padronizado para abertura de chamados técnicos.

Sempre retorne **apenas** um JSON no seguinte formato:
{
  "id_cliente": $idCliente,
  "titulo": "",
  "descricao": "",
  "prioridade": "",
  "tipo_atendimento": "",
  "categoria": ""
}

Regras:
- "titulo": deve ser um resumo curto do problema.
- "descricao": deve conter o texto completo ou um resumo detalhado do problema.
- "prioridade": escolha apenas entre ('Baixa', 'Media', 'Alta', 'Critica'), com base na gravidade e urgência percebida no texto.
- "tipo_atendimento": escolha apenas entre ('Remoto', 'Presencial'), conforme o texto indicar. Se não ficar claro, use "Remoto".
- "categoria": escolha apenas entre ('Hardware', 'Software', 'Redes', 'Segurança', 'Outros'), conforme o assunto do texto.  
  Exemplo:
  - computador não liga → "Hardware"
  - erro no sistema ou programa → "Software"
  - sem internet → "Redes"
  - vírus, acesso indevido → "Segurança"
  - qualquer outro caso → "Outros"
- Não adicione comentários, explicações ou texto fora do JSON.
- Sempre mantenha o formato JSON válido.

Exemplo de entrada:
> Meu notebook não liga e preciso resolver urgente, acho que é algo na fonte.

Exemplo de saída:
{
  "id_cliente": $idCliente,
  "titulo": "Notebook não liga",
  "descricao": "Cliente relata que o notebook não liga e suspeita de problema na fonte.",
  "prioridade": "Alta",
  "tipo_atendimento": "Presencial",
  "categoria": "Hardware"
}

Entrada:
> $msg
""";

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_apiKey",
    };

    final body = jsonEncode({
      "model": "gpt-5-nano",
      "messages": [
        {"role": "user", "content": message},
      ],
      "temperature": 1,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      try {
        await _apiService.post(
          '/Chamados/',
          json.decode(data["choices"][0]["message"]["content"]),
        );
      } on Exception {
        return _failMessage;
      }
      return _sucessMessage;
    } else {
      return _failMessage;
    }
  }
}
