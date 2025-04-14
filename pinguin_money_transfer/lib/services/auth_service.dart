import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:3000/api/auth';
  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<String?> getToken() async {
    return _prefs.getString('token');
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  Future<void> removeToken() async {
    await _prefs.remove('token');
  }

  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String pin,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'pin': pin,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await saveToken(data['token']);
      return User.fromJson(data['user']);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<User> login({
    required String phoneNumber,
    required String pin,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone_number': phoneNumber,
          'pin': pin,
        }),
      );

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Parsed response data: $data');
        await saveToken(data['token']);
        return User.fromJson(data['user']);
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> logout() async {
    await removeToken();
  }
} 