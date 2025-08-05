class WalletModel {
  final double saldo;
  final double saldoNaoVerificado;

  WalletModel({
    required this.saldo,
    required this.saldoNaoVerificado,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      saldo: (json['saldo'] ?? 0).toDouble(),
      saldoNaoVerificado: (json['saldoNaoVerificado'] ?? 0).toDouble(),
    );
  }
} 