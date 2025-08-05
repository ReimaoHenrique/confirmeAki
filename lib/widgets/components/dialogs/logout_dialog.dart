import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/auth_provider.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sair'),
      content: const Text('Tem certeza que deseja sair da sua conta?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await Provider.of<AuthProvider>(context, listen: false).logout();
            if (context.mounted) {
              context.go('/login');
            }
          },
          child: const Text('Sair'),
        ),
      ],
    );
  }
} 