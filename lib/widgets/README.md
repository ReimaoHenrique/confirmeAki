# Sistema de Componentes React-like

Este diretório contém um sistema de componentes reutilizáveis inspirado no React, organizado de forma modular e fácilawah.

## Estrutura

```
widgets/
├── components/           # Componentes organizados por categoria
│   ├── buttons/         # Botões
│   ├── forms/           # Formulários
│   ├── layout/          # Layout e estrutura
│   ├ cards/             # Cards e containers
│   ├── dialogs/         # Diálogos e modais
│   ├── navigation/      # Navegação
│   └── theme/           # Tema e cores
├── widgets.dart         # Importação principal
└── README.md           # Este arquivo
```

## Como Usar

### Importação

```dart
import 'package:confirme_aki/widgets/widgets.dart';
```

### Exemplos de Uo

#### Botões

```dart
// Botão primário
ActionButton(
  text: 'Salvar',
  icon: Icons.save,
  onPressed: () => saveData(),
)

// Botão outline
ActionButton(
  text: 'Cancelar',
  isOutlined: true,
  onPressed: () => cancel(),
)

// Botão com loading
LoadingButton(
  onPressed: () async {
    await saveData();
  },
  child: Text('Salvar'),
)
```

#### Layout

```dart
// Cabeçalho de seção
SectionHeader(
  title: 'Minhas Solicitações',
  subtitle: 'Gerencie suas solicitações',
  actionText: 'Ver todas',
  onActionPressed: () => navigateToAll(),
)

// Estado vazio
EmptyState(
  title: 'Nenhuma solicitação',
  subtitle: 'Crie sua primeira solicitação',
  icon: Icons.inbox_outlined,
  actionText: 'Nova Solicitação',
  onActionPressed: () => createRequest(),
)

// Estado de carregamento
LoadingState(
  message: 'Carregando dados...',
)
```

#### Cards

```dart
// Card de ação
ActionCard(
  icon: Icons.add,
  title: 'Nova Solicitação',
  subtitle: 'Criar solicitação',
  color: AppColors.actionBlue,
  onTap: () => createRequest(),
)

// Card de solicitação
RequestCard(
  request: request,
  onTap: () => viewDetails(request),
)
```

#### Diálogos

```dart
// Diálogo de confirmação
showDialog(
  context: context,
  builder: (context) => ConfirmDialog(
    title: 'Confirmar exclusão',
    message: 'Tem certeza que deseja excluir?',
    confirmText: 'Excluir',
    isDestructive: true,
    onConfirm: () => deleteItem(),
  ),
)

// Diálogo de logout
showDialog(
  context: context,
  builder: (context) => LogoutDialog(),
)
```

#### Formulários

```dart
// Campo de texto customizado
CustomTextField(
  controller: textController,
  label: 'Nome',
  hint: 'Digite seu nome',
  prefixIcon: Icons.person,
  validator: (value) {
    if (value?.isEmpty ?? true) {
      return 'Nome é obrigatório';
    }
    return null;
  },
)
```

## Cores

Use o esquema de cores predefinido:

```dart
// Cores de ação
AppColors.actionBlue
AppColors.actionGreen
AppColors.actionOrange
AppColors.actionPurple
AppColors.actionRed

// Cores de status
AppColors.success
AppColors.warning
AppColors.error
AppColors.info
```

## Benefícios

1. **Reutilização**: Componentes podem ser usados em múltiplas telas
2. **Consistência**: Design uniforme em toda a aplicação
3. **Manutenibilidade**: Mudanças centralizadas
4. **Produtividade**: Desenvolvimento mais rápido
5. **Legibilidade**: Código mais limpo e organizado

## Convenções

- Use `const` sempre que possível
- Mantenha os componentes simples e focados
- Documente props complexas
- Use nomes descritivos para props
- Siga o padrão de nomenclatura do Flutter

## Exemplo Completo

Veja `lib/screens/example_react_screen.dart` para um exemplo completo de uso.
