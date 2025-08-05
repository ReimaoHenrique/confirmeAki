import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/wallet_provider.dart';

class WithdrawDialog extends StatefulWidget {
  final WalletProvider provider;

  const WithdrawDialog({
    super.key,
    required this.provider,
  });

  @override
  State<WithdrawDialog> createState() => _WithdrawDialogState();
}

class _WithdrawDialogState extends State<WithdrawDialog> {
  final _formKey = GlobalKey<FormState>();
  double? amount;
  String? selectedAccountId;

  @override
  void initState() {
    super.initState();
    selectedAccountId = widget.provider.bankAccounts.isNotEmpty 
        ? widget.provider.bankAccounts.first.id 
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Solicitar Retirada'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Informe o valor';
                final v = double.tryParse(value.replaceAll(',', '.'));
                if (v == null || v <= 0) return 'Valor inválido';
                if (widget.provider.wallet != null && v > widget.provider.wallet!.saldo) {
                  return 'Saldo insuficiente';
                }
                return null;
              },
              onSaved: (value) {
                amount = double.tryParse(value!.replaceAll(',', '.'));
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedAccountId,
              items: widget.provider.bankAccounts.map((acc) => DropdownMenuItem(
                value: acc.id,
                child: Text('${acc.banco} - ${acc.conta}'),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAccountId = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Conta Bancária'),
              validator: (value) => value == null ? 'Selecione uma conta' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              await widget.provider.withdraw(amount!, selectedAccountId!);
              if (widget.provider.error == null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Retirada solicitada!')),
                );
              }
            }
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
} 