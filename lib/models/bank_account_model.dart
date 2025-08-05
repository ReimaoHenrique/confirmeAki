class BankAccountModel {
  final String id;
  final String banco;
  final String agencia;
  final String conta;
  final String titular;

  BankAccountModel({
    required this.id,
    required this.banco,
    required this.agencia,
    required this.conta,
    required this.titular,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      id: json['id'],
      banco: json['banco'],
      agencia: json['agencia'],
      conta: json['conta'],
      titular: json['titular'],
    );
  }
} 