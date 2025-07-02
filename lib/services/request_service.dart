import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/request_model.dart';

class RequestService {
  static const String baseUrl = 'https://api.confirmeaki.com'; // URL da API real
  
  // Lista simulada de solicitações para desenvolvimento
  static List<Request> _mockRequests = [
    Request(
      id: '1',
      userId: '1',
      title: 'Verificação de Imóvel',
      description: 'Preciso verificar as condições de um apartamento antes da compra.',
      address: 'Rua das Flores, 123 - São Paulo, SP',
      latitude: -23.5505,
      longitude: -46.6333,
      type: RequestType.property,
      status: RequestStatus.pending,
      desiredDate: DateTime.now().add(const Duration(days: 3)),
      attachments: [],
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      comments: [],
    ),
    Request(
      id: '2',
      userId: '1',
      title: 'Verificação de Produto',
      description: 'Verificar a autenticidade de um produto eletrônico.',
      address: 'Shopping Center Norte - São Paulo, SP',
      type: RequestType.product,
      status: RequestStatus.inProgress,
      desiredDate: DateTime.now().add(const Duration(days: 1)),
      attachments: [],
      verifierId: 'verifier_1',
      verifierName: 'João Silva',
      price: 150.0,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
      comments: [
        RequestComment(
          id: 'comment_1',
          requestId: '2',
          userId: 'verifier_1',
          userName: 'João Silva',
          message: 'Solicitação aceita. Estarei no local amanhã às 14h.',
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
      ],
    ),
  ];

  Future<List<Request>> getRequests() async {
    try {
      // Simulação de chamada de API
      await Future.delayed(const Duration(seconds: 1));
      
      return List.from(_mockRequests);
      
      // Código real para chamada de API:
      /*
      final response = await http.get(
        Uri.parse('$baseUrl/requests'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['requests'] as List)
            .map((json) => Request.fromJson(json))
            .toList();
      }
      
      throw Exception('Erro ao carregar solicitações');
      */
    } catch (e) {
      throw Exception('Erro ao carregar solicitações: $e');
    }
  }

  Future<Request?> createRequest(Request request) async {
    try {
      // Simulação de criação
      await Future.delayed(const Duration(seconds: 2));
      
      final newRequest = request.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      _mockRequests.insert(0, newRequest);
      return newRequest;
      
      // Código real para chamada de API:
      /*
      final response = await http.post(
        Uri.parse('$baseUrl/requests'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Request.fromJson(data['request']);
      }
      
      return null;
      */
    } catch (e) {
      throw Exception('Erro ao criar solicitação: $e');
    }
  }

  Future<Request?> getRequestDetails(String requestId) async {
    try {
      // Simulação de busca
      await Future.delayed(const Duration(milliseconds: 500));
      
      return _mockRequests.firstWhere(
        (request) => request.id == requestId,
        orElse: () => throw Exception('Solicitação não encontrada'),
      );
      
      // Código real para chamada de API:
      /*
      final response = await http.get(
        Uri.parse('$baseUrl/requests/$requestId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Request.fromJson(data['request']);
      }
      
      return null;
      */
    } catch (e) {
      throw Exception('Erro ao carregar detalhes: $e');
    }
  }

  Future<bool> updateRequestStatus(String requestId, RequestStatus status) async {
    try {
      // Simulação de atualização
      await Future.delayed(const Duration(seconds: 1));
      
      final index = _mockRequests.indexWhere((r) => r.id == requestId);
      if (index != -1) {
        _mockRequests[index] = _mockRequests[index].copyWith(
          status: status,
          updatedAt: DateTime.now(),
        );
        return true;
      }
      
      return false;
      
      // Código real para chamada de API seria implementado aqui
    } catch (e) {
      throw Exception('Erro ao atualizar status: $e');
    }
  }

  Future<bool> addComment(String requestId, String comment) async {
    try {
      // Simulação de adição de comentário
      await Future.delayed(const Duration(seconds: 1));
      
      final index = _mockRequests.indexWhere((r) => r.id == requestId);
      if (index != -1) {
        final newComment = RequestComment(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          requestId: requestId,
          userId: '1', // ID do usuário atual
          userName: 'Usuário Teste',
          message: comment,
          createdAt: DateTime.now(),
        );
        
        final updatedComments = List<RequestComment>.from(_mockRequests[index].comments);
        updatedComments.add(newComment);
        
        _mockRequests[index] = _mockRequests[index].copyWith(
          comments: updatedComments,
          updatedAt: DateTime.now(),
        );
        
        return true;
      }
      
      return false;
      
      // Código real para chamada de API seria implementado aqui
    } catch (e) {
      throw Exception('Erro ao adicionar comentário: $e');
    }
  }

  Future<bool> uploadAttachment(String requestId, String filePath) async {
    try {
      // Simulação de upload
      await Future.delayed(const Duration(seconds: 3));
      
      final index = _mockRequests.indexWhere((r) => r.id == requestId);
      if (index != -1) {
        final updatedAttachments = List<String>.from(_mockRequests[index].attachments);
        updatedAttachments.add(filePath);
        
        _mockRequests[index] = _mockRequests[index].copyWith(
          attachments: updatedAttachments,
          updatedAt: DateTime.now(),
        );
        
        return true;
      }
      
      return false;
      
      // Código real para upload seria implementado aqui
    } catch (e) {
      throw Exception('Erro ao fazer upload: $e');
    }
  }

  Future<List<Request>> searchRequests(String query) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      return _mockRequests.where((request) =>
        request.title.toLowerCase().contains(query.toLowerCase()) ||
        request.description.toLowerCase().contains(query.toLowerCase()) ||
        request.address.toLowerCase().contains(query.toLowerCase())
      ).toList();
      
      // Código real para busca seria implementado aqui
    } catch (e) {
      throw Exception('Erro na busca: $e');
    }
  }
}

