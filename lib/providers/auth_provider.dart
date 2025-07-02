import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isLoading = false;
  String? _error;

  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _token != null;

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
        _token = token;
      } else {
        _token = null;
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
        _token = result['token'];
        print('Token salvo: $_token');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
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
        _token = result['token'];
        print('Token salvo: $_token');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
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
      _token = null;
      notifyListeners();
    } catch (e) {
      _setError('Erro ao fazer logout: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<User?> fetchCurrentUser() async {
    if (_token == null) return null;
    return await _authService.getCurrentUser(_token!);
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

