import '../services/openai_service.dart';
import '../services/api_service.dart';



class ChamadoController {
  ApiService apiService = ApiService();
  OpenAIService openAIService = OpenAIService();

  Future<bool> criarChamado(String msg, int idCliente) async {
      final data = await openAIService.sendMessage(msg, idCliente);
      return await apiService.post('/Chamados/', data) ? true : false;
  }

  Future<bool> editarChamado(Map<String, dynamic> data, int idChamado) async {
    return await apiService.patch('/Chamados/$idChamado', data) ? true : false;
  }
}

// // // {
// // //   "id_tecnico": 0,
// // //   "prioridade": "string",
// // //   "status": "string",
// // //   "tipo_atendimento": "string",
// // //   "categoria": "string",
// // //   "data_fechamento": "2025-11-14T01:55:27.799Z",
// // //   "tempo_resolucao": "string",
// // //   "sla_maximo": "string"
// // // }
