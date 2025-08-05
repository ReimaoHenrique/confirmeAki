import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/wallet_provider.dart';
import '../../widgets/widgets.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WalletProvider>(context, listen: false).loadWallet();
    Provider.of<WalletProvider>(context, listen: false).loadBankAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Carteira')),
      body: Consumer<WalletProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.wallet == null) {
            return const Center(child: Text('Erro ao carregar carteira.'));
          }
          
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WalletBalanceCard(wallet: provider.wallet!),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  icon: const Icon(Icons.attach_money),
                  label: const Text('Solicitar Retirada'),
                  onPressed: () {
                    _showWithdrawDialog(context, provider);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context, WalletProvider provider) {
    showDialog(
      context: context,
      builder: (context) => WithdrawDialog(provider: provider),
    );
  }
} 