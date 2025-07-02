enum RequestStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

enum RequestType {
  property,
  product,
  service,
  other,
}

class Request {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String address;
  final double? latitude;
  final double? longitude;
  final RequestType type;
  final RequestStatus status;
  final DateTime desiredDate;
  final List<String> attachments;
  final String? verifierId;
  final String? verifierName;
  final double? price;
  final List<RequestComment> comments;
  final DateTime createdAt;
  final DateTime updatedAt;

  Request({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.address,
    this.latitude,
    this.longitude,
    required this.type,
    required this.status,
    required this.desiredDate,
    this.attachments = const [],
    this.verifierId,
    this.verifierName,
    this.price,
    this.comments = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      type: RequestType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => RequestType.other,
      ),
      status: RequestStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RequestStatus.pending,
      ),
      desiredDate: DateTime.parse(json['desired_date'] ?? DateTime.now().toIso8601String()),
      attachments: List<String>.from(json['attachments'] ?? []),
      verifierId: json['verifier_id'],
      verifierName: json['verifier_name'],
      price: json['price']?.toDouble(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((c) => RequestComment.fromJson(c))
          .toList() ?? [],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'type': type.name,
      'status': status.name,
      'desired_date': desiredDate.toIso8601String(),
      'attachments': attachments,
      'verifier_id': verifierId,
      'verifier_name': verifierName,
      'price': price,
      'comments': comments.map((c) => c.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Request copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    RequestType? type,
    RequestStatus? status,
    DateTime? desiredDate,
    List<String>? attachments,
    String? verifierId,
    String? verifierName,
    double? price,
    List<RequestComment>? comments,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Request(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      type: type ?? this.type,
      status: status ?? this.status,
      desiredDate: desiredDate ?? this.desiredDate,
      attachments: attachments ?? this.attachments,
      verifierId: verifierId ?? this.verifierId,
      verifierName: verifierName ?? this.verifierName,
      price: price ?? this.price,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get statusText {
    switch (status) {
      case RequestStatus.pending:
        return 'Aguardando';
      case RequestStatus.inProgress:
        return 'Em andamento';
      case RequestStatus.completed:
        return 'Concluído';
      case RequestStatus.cancelled:
        return 'Cancelado';
    }
  }

  String get typeText {
    switch (type) {
      case RequestType.property:
        return 'Imóvel';
      case RequestType.product:
        return 'Produto';
      case RequestType.service:
        return 'Serviço';
      case RequestType.other:
        return 'Outro';
    }
  }

  @override
  String toString() {
    return 'Request(id: $id, title: $title, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Request && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class RequestComment {
  final String id;
  final String requestId;
  final String userId;
  final String userName;
  final String message;
  final DateTime createdAt;

  RequestComment({
    required this.id,
    required this.requestId,
    required this.userId,
    required this.userName,
    required this.message,
    required this.createdAt,
  });

  factory RequestComment.fromJson(Map<String, dynamic> json) {
    return RequestComment(
      id: json['id'] ?? '',
      requestId: json['request_id'] ?? '',
      userId: json['user_id'] ?? '',
      userName: json['user_name'] ?? '',
      message: json['message'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'request_id': requestId,
      'user_id': userId,
      'user_name': userName,
      'message': message,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

