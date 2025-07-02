import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final user = await authProvider.fetchCurrentUser();
      setState(() {
        _user = user;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar usuário';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _user == null
                  ? const Center(child: Text('Usuário não encontrado'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: Text(
                                      _user!.name.substring(0, 1).toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _user!.name,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _user!.email,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.person_outline),
                                  title: const Text('Informações Pessoais'),
                                  subtitle: Text(_user!.phone),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Edição de perfil em desenvolvimento')),
                                    );
                                  },
                                ),
                                const Divider(height: 1),
                                ListTile(
                                  leading: const Icon(Icons.lock_outline),
                                  title: const Text('Alterar Senha'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Alteração de senha em desenvolvimento')),
                                    );
                                  },
                                ),
                                const Divider(height: 1),
                                ListTile(
                                  leading: const Icon(Icons.settings_outlined),
                                  title: const Text('Configurações'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () => context.go('/settings'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.help_outline),
                                  title: const Text('Ajuda e Suporte'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Suporte em desenvolvimento')),
                                    );
                                  },
                                ),
                                const Divider(height: 1),
                                ListTile(
                                  leading: const Icon(Icons.info_outline),
                                  title: const Text('Sobre o App'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    showAboutDialog(
                                      context: context,
                                      applicationName: 'Confirme Aki',
                                      applicationVersion: '1.0.0',
                                      applicationLegalese: '© 2024 Confirme Aki. Todos os direitos reservados.',
                                    );
                                  },
                                ),
                                const Divider(height: 1),
                                ListTile(
                                  leading: const Icon(Icons.logout, color: Colors.red),
                                  title: const Text('Sair', style: TextStyle(color: Colors.red)),
                                  onTap: () => _showLogoutDialog(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              await authProvider.logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}

