import 'package:flutter/material.dart';
import '../models/wallet_model.dart';
import '../models/bank_account_model.dart';
import '../services/wallet_service.dart';

class WalletProvider extends ChangeNotifier {
  final WalletService _service = WalletService();

  WalletModel? wallet;
  List<BankAccountModel> bankAccounts = [];
  bool isLoading = false;
  String? error;

  Future<void> loadWallet() async {
    isLoading = true;
    notifyListeners();
    try {
      wallet = await _service.fetchWallet();
      error = null;
    } catch (e) {
      error = 'Erro ao carregar carteira';
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadBankAccounts() async {
    isLoading = true;
    notifyListeners();
    try {
      bankAccounts = await _service.fetchBankAccounts();
      error = null;
    } catch (e) {
      error = 'Erro ao carregar contas bancárias';
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> withdraw(double amount, String bankAccountId) async {
    isLoading = true;
    notifyListeners();
    try {
      await _service.requestWithdrawal(amount: amount, bankAccountId: bankAccountId);
      await loadWallet();
      error = null;
    } catch (e) {
      error = 'Erro ao solicitar retirada';
    }
    isLoading = false;
    notifyListeners();
  }
} 