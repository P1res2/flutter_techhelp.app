import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  final String _prefixUrlApi = prefixUrlApi;

  Future<T> getBy<T>(
    String sufixUrl,
    T Function(Map<String, dynamic>) fromMap,
  ) async {
    final response = await http.get(Uri.parse("$_prefixUrlApi$sufixUrl"));

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar dados: ${response.statusCode}');
    }

    final dynamic data = json.decode(response.body);
    return fromMap(data);
  }

  // Get all
  Future<List<T>> getAll<T>(
    String sufixUrl,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await http.get(Uri.parse("$_prefixUrlApi$sufixUrl"));

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar dados: ${response.statusCode}');
    }

    final List<dynamic> data = json.decode(response.body);
    return data.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  // Post
  Future<bool> post<T>(String sufixUrl, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("$_prefixUrlApi$sufixUrl"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode.toString()[0] == '2') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Falha na requisição: $e');
    }
  }

  // Patch
  Future<bool> patch<T>(String sufixUrl, Map<String, dynamic> data) async {
    try {
      final response = await http.patch(
        Uri.parse("$_prefixUrlApi$sufixUrl"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode.toString()[0] != '2') {
        return false;
      }
      return true;
    } catch (e) {
      throw Exception('Falha na requisição: $e');
    }
  }
}
