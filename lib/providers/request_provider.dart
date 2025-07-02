import 'package:flutter/foundation.dart';
import '../models/request_model.dart';
import '../services/request_service.dart';

class RequestProvider with ChangeNotifier {
  List<Request> _requests = [];
  Request? _currentRequest;
  bool _isLoading = false;
  String? _error;

  List<Request> get requests => _requests;
  Request? get currentRequest => _currentRequest;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final RequestService _requestService = RequestService();

  Future<void> loadRequests() async {
    _setLoading(true);
    _clearError();
    
    try {
      _requests = await _requestService.getRequests();
      notifyListeners();
    } catch (e) {
      _setError('Erro ao carregar solicitações: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> createRequest(Request request) async {
    _setLoading(true);
    _clearError();
    
    try {
      final newRequest = await _requestService.createRequest(request);
      if (newRequest != null) {
        _requests.insert(0, newRequest);
        notifyListeners();
        return true;
      } else {
        _setError('Erro ao criar solicitação');
        return false;
      }
    } catch (e) {
      _setError('Erro ao criar solicitação: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadRequestDetails(String requestId) async {
    _setLoading(true);
    _clearError();
    
    try {
      _currentRequest = await _requestService.getRequestDetails(requestId);
      notifyListeners();
    } catch (e) {
      _setError('Erro ao carregar detalhes da solicitação: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateRequestStatus(String requestId, RequestStatus status) async {
    _setLoading(true);
    _clearError();
    
    try {
      final success = await _requestService.updateRequestStatus(requestId, status);
      if (success) {
        // Atualizar na lista local
        final index = _requests.indexWhere((r) => r.id == requestId);
        if (index != -1) {
          _requests[index] = _requests[index].copyWith(status: status);
        }
        
        // Atualizar request atual se for o mesmo
        if (_currentRequest?.id == requestId) {
          _currentRequest = _currentRequest!.copyWith(status: status);
        }
        
        notifyListeners();
        return true;
      } else {
        _setError('Erro ao atualizar status da solicitação');
        return false;
      }
    } catch (e) {
      _setError('Erro ao atualizar status: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addComment(String requestId, String comment) async {
    try {
      final success = await _requestService.addComment(requestId, comment);
      if (success) {
        // Recarregar detalhes da solicitação
        await loadRequestDetails(requestId);
        return true;
      }
      return false;
    } catch (e) {
      _setError('Erro ao adicionar comentário: $e');
      return false;
    }
  }

  List<Request> getRequestsByStatus(RequestStatus status) {
    return _requests.where((request) => request.status == status).toList();
  }

  void clearCurrentRequest() {
    _currentRequest = null;
    notifyListeners();
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

