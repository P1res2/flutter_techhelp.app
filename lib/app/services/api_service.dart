import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  final String _prefixUrlApi = prefixUrlApi;

  // Get one
  Future<T> getBy<T>(
    String sufixUrl,
    T Function(Map<String, dynamic>) fromMap,
  ) async {
    try {
      final response = await http
          .get(Uri.parse("$_prefixUrlApi$sufixUrl"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar dados: ${response.statusCode}');
      }

      final dynamic data = json.decode(response.body);
      return fromMap(data);
    } on SocketException {
      throw Exception("Sem conexão com o servidor");
    }
  }

  // Get all
  Future<List<T>> getAll<T>(
    String sufixUrl,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await http
          .get(Uri.parse("$_prefixUrlApi$sufixUrl"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar dados: ${response.statusCode}');
      }

      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } on SocketException {
      throw Exception("Sem conexão com o servidor");
    }
  }

  // Post
  Future<bool> post<T>(String sufixUrl, Map<String, dynamic> data) async {
    try {
      final response = await http
          .post(
            Uri.parse("$_prefixUrlApi$sufixUrl"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      return response.statusCode.toString().startsWith('2');
    } on SocketException {
      throw Exception("Sem conexão com o servidor");
    }
  }

  // Patch
  Future<bool> patch<T>(String sufixUrl, Map<String, dynamic> data) async {
    try {
      final response = await http
          .patch(
            Uri.parse("$_prefixUrlApi$sufixUrl"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      return response.statusCode.toString().startsWith('2');
    } on SocketException {
      throw Exception("Sem conexão com o servidor");
    }
  }

  // Delete
  Future<bool> delete<T>(String sufixUrl) async {
    try {
      final response = await http
          .delete(
            Uri.parse("$_prefixUrlApi$sufixUrl"),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      return response.statusCode.toString().startsWith('2');
    } on SocketException {
      throw Exception("Sem conexão com o servidor");
    }
  }
}