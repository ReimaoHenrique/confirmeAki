import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService {
  static const String baseUrl = 'https://api.confirmeaki.com'; // URL da API real
  
  // Por enquanto, vamos simular as chamadas de API
  // Em produção, estas chamadas serão feitas para o backend real

  Future<Map<String, dynamic>> login(String email, String password) async {
    // Usuário de teste local
    if (email == 'user@test.com' && password == '123456') {
      final user = User(
        id: 'test_user',
        name: 'Usuário de Teste',
        email: email,
        phone: '11999999999',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      );
      return {
        'success': true,
        'user': user,
        'token': 'fake_jwt_token_test_user',
        'message': 'Login de teste bem-sucedido',
      };
    }

    try {
      final response = await http.post(
        Uri.parse('https://jvdpz4zf-3000.brs.devtunnels.ms/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      // print('🔵 Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // print('🔵 Token recebido: ${data['token']}');
        return {
          'success': true,
          'user': User.fromJson(data['user']),
          'token': data['token'],
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Email ou senha incorretos',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro de conexão: $e',
      };
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String phone, String password) async {
    try {
      // Simulação de chamada de API
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulação de criação de usuário
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        createdAt: DateTime.now(),
      );
      
      return {
        'success': true,
        'user': user,
        'token': 'fake_jwt_token_${user.id}',
        'message': 'Conta criada com sucesso',
      };
      
      // Código real para chamada de API:
      /*
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201) {
        return {
          'success': true,
          'user': User.fromJson(data['user']),
          'token': data['token'],
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Erro no cadastro',
        };
      }
      */
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro de conexão: $e',
      };
    }
  }

  Future<User?> getCurrentUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://jvdpz4zf-3000.brs.devtunnels.ms/api/auth/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userJson = data['user'];
        return User.fromJson(userJson);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> updateProfile(String name, String email, String phone) async {
    try {
      // Simulação de atualização
      await Future.delayed(const Duration(seconds: 1));
      
      final user = User(
        id: '1',
        name: name,
        email: email,
        phone: phone,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      );
      
      return {
        'success': true,
        'user': user,
        'message': 'Perfil atualizado com sucesso',
      };
      
      // Código real para chamada de API seria implementado aqui
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro ao atualizar perfil: $e',
      };
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      // Simulação de envio de email de recuperação
      await Future.delayed(const Duration(seconds: 2));
      return true;
      
      // Código real para chamada de API seria implementado aqui
    } catch (e) {
      return false;
    }
  }
}

