import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  final AuthService _authService = AuthService();

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    _setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token != null) {
        // Verificar se o token ainda é válido
        final user = await _authService.getCurrentUser(token);
        if (user != null) {
          _user = user;
        } else {
          await logout();
        }
      }
    } catch (e) {
      _setError('Erro ao verificar autenticação: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final result = await _authService.login(email, password);
      if (result['success']) {
        _user = result['user'];
        
        // Salvar token localmente
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', result['token']);
        
        notifyListeners();
        return true;
      } else {
        _setError(result['message']);
        return false;
      }
    } catch (e) {
      _setError('Erro ao fazer login: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register(String name, String email, String phone, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final result = await _authService.register(name, email, phone, password);
      if (result['success']) {
        _user = result['user'];
        
        // Salvar token localmente
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', result['token']);
        
        notifyListeners();
        return true;
      } else {
        _setError(result['message']);
        return false;
      }
    } catch (e) {
      _setError('Erro ao criar conta: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      
      _user = null;
      notifyListeners();
    } catch (e) {
      _setError('Erro ao fazer logout: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateProfile(String name, String email, String phone) async {
    _setLoading(true);
    _clearError();
    
    try {
      final result = await _authService.updateProfile(name, email, phone);
      if (result['success']) {
        _user = result['user'];
        notifyListeners();
        return true;
      } else {
        _setError(result['message']);
        return false;
      }
    } catch (e) {
      _setError('Erro ao atualizar perfil: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}

