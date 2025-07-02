import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService {
  static const String baseUrl = 'https://api.confirmeaki.com'; // URL da API real
  
  // Por enquanto, vamos simular as chamadas de API
  // Em produção, estas chamadas serão feitas para o backend real

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Simulação de chamada de API
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulação de validação
      if (email == 'user@test.com' && password == '123456') {
        final user = User(
          id: '1',
          name: 'Usuário Teste',
          email: email,
          phone: '(11) 99999-9999',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        return {
          'success': true,
          'user': user,
          'token': 'fake_jwt_token_123',
          'message': 'Login realizado com sucesso',
        };
      } else {
        return {
          'success': false,
          'message': 'Email ou senha incorretos',
        };
      }
      
      // Código real para chamada de API:
      /*
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'user': User.fromJson(data['user']),
          'token': data['token'],
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Erro no login',
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
        updatedAt: DateTime.now(),
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
      // Simulação de validação de token
      await Future.delayed(const Duration(seconds: 1));
      
      if (token.startsWith('fake_jwt_token')) {
        return User(
          id: '1',
          name: 'Usuário Teste',
          email: 'user@test.com',
          phone: '(11) 99999-9999',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          updatedAt: DateTime.now(),
        );
      }
      
      return null;
      
      // Código real para chamada de API:
      /*
      final response = await http.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['user']);
      }
      
      return null;
      */
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
        updatedAt: DateTime.now(),
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

