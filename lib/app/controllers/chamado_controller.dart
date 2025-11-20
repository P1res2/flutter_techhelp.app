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
