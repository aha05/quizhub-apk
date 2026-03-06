import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/auth_repository.dart';


class Api {
  final String baseUrl;

  Api({String? baseUrl}) : baseUrl = baseUrl ?? dotenv.env['BASE_URL']!;

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body, {bool useToken = true}) async {
    final headers = {'Content-Type': 'application/json'};
    
    if (useToken) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AuthRepository.TOKEN_KEY);
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }

  Future<T> get<T>(String path) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AuthRepository.TOKEN_KEY);

    final headers = <String, String>{};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.get(Uri.parse('$baseUrl$path'), headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}