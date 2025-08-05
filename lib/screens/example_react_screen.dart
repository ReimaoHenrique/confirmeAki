import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/widgets.dart';

class ExampleReactScreen extends StatelessWidget {
  const ExampleReactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo React-like'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Exemplo de uso do ConfirmDialog
              showDialog(
                context: context,
                builder: (context) => const ConfirmDialog(
                  title: 'Configurações',
                  message: 'Deseja abrir as configurações?',
                  confirmText: 'Abrir',
                  cancelText: 'Cancelar',
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exemplo de SectionHeader
            const SectionHeader(
              title: 'Componentes React-like',
              subtitle: 'Demonstração de componentes reutilizáveis',
              actionText: 'Ver mais',
              actionIcon: Icons.arrow_forward,
            ),
            
            const SizedBox(height: 24),
            
            // Exemplo de ActionButton
            ActionButton(
              text: 'Botão Primário',
              icon: Icons.add,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Botão primário clicado!')),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Exemplo de ActionButton outlined
            ActionButton(
              text: 'Botão Secundário',
              icon: Icons.edit,
              isOutlined: true,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Botão secundário clicado!')),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Exemplo de SectionHeader com ação
            SectionHeader(
              title: 'Estados da Aplicação',
              subtitle: 'Diferentes tipos de estados',
              actionText: 'Atualizar',
              actionIcon: Icons.refresh,
              onActionPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Atualizando...')),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Exemplo de EmptyState
            const EmptyState(
              title: 'Nenhum item encontrado',
              subtitle: 'Crie seu primeiro item para começar',
              icon: Icons.inbox_outlined,
              actionText: 'Criar Item',
              actionIcon: Icons.add,
            ),
            
            const SizedBox(height: 24),
            
            // Exemplo de LoadingState
            const LoadingState(
              message: 'Carregando dados...',
            ),
            
            const SizedBox(height: 24),
            
            // Exemplo de ActionCard
            ActionCard(
              icon: Icons.star,
              title: 'Favorito',
              subtitle: 'Adicionar aos favoritos',
              color: AppColors.actionOrange,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Adicionado aos favoritos!')),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Exemplo de LoadingButton
            LoadingButton(
              onPressed: () async {
                // Simular carregamento
                await Future.delayed(const Duration(seconds: 2));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ação concluída!')),
                  );
                }
              },
              child: const Text('Botão com Loading'),
            ),
            
            const SizedBox(height: 24),
            
            // Exemplo de CustomTextField
            CustomTextField(
              controller: TextEditingController(),
              label: 'Campo de Texto',
              hint: 'Digite algo aqui...',
              prefixIcon: Icons.edit,
            ),
            
            const SizedBox(height: 24),
            
            // Exemplo de botões com cores do esquema
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    text: 'Sucesso',
                    backgroundColor: AppColors.success,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ActionButton(
                    text: 'Aviso',
                    backgroundColor: AppColors.warning,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ActionButton(
                    text: 'Erro',
                    backgroundColor: AppColors.error,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 