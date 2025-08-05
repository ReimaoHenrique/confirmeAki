import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/wallet_provider.dart';
import '../../models/bank_account_model.dart';

class BankAccountsScreen extends StatefulWidget {
  const BankAccountsScreen({super.key});

  @override
  State<BankAccountsScreen> createState() => _BankAccountsScreenState();
}

class _BankAccountsScreenState extends State<BankAccountsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WalletProvider>(context, listen: false).loadBankAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contas Bancárias')),
      body: Consumer<WalletProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...provider.bankAccounts.map((account) => Card(
                child: ListTile(
                  leading: const Icon(Icons.account_balance_outlined),
                  title: Text('${account.banco} - ${account.conta}'),
                  subtitle: Text('Agência: ${account.agencia}\nTitular: ${account.titular}'),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      // TODO: Implementar remoção
                    },
                  ),
                ),
              )),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Conta Bancária'),
                onPressed: () {
                  // TODO: Implementar adição de conta
                },
              ),
            ],
          );
        },
      ),
    );
  }
} 