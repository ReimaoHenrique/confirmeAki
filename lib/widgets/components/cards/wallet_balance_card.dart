import 'package:flutter/material.dart';
import '../../../models/wallet_model.dart';

class WalletBalanceCard extends StatelessWidget {
  final WalletModel wallet;

  const WalletBalanceCard({
    super.key,
    required this.wallet,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saldo disponível',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'R\$ ${wallet.saldo.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Saldo não verificado: R\$ ${wallet.saldoNaoVerificado.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 