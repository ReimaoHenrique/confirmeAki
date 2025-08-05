import '../models/wallet_model.dart';
import '../models/bank_account_model.dart';

class WalletService {
  Future<WalletModel> fetchWallet() async {
    // Simulação de chamada ao backend
    await Future.delayed(const Duration(milliseconds: 500));
    return WalletModel(saldo: 1500.0, saldoNaoVerificado: 200.0);
  }

  Future<List<BankAccountModel>> fetchBankAccounts() async {
    // Simulação de chamada ao backend
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      BankAccountModel(
        id: '1',
        banco: 'Banco do Brasil',
        agencia: '1234',
        conta: '56789-0',
        titular: 'João da Silva',
      ),
    ];
  }

  Future<void> requestWithdrawal({
    required double amount,
    required String bankAccountId,
  }) async {
    // Simulação de chamada ao backend
    await Future.delayed(const Duration(milliseconds: 500));
    // Aqui você trataria erros, saldo insuficiente, etc.
  }
} 