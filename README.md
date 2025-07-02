# Confirme Aki - Aplicativo Flutter

## Descrição

O **Confirme Aki** é um aplicativo desenvolvido em Flutter que conecta pessoas que precisam de verificações presenciais com verificadores profissionais. O aplicativo permite solicitar verificações de imóveis, produtos, serviços e outros itens, facilitando a comunicação entre solicitantes e verificadores.

## Funcionalidades Implementadas

### ✅ Autenticação

- Tela de login com validação
- Tela de registro de novos usuários
- Tela de splash com navegação automática
- Sistema de autenticação simulado com dados locais

### ✅ Gestão de Solicitações

- Formulário para criar novas solicitações
- Lista de solicitações do usuário
- Detalhes completos de cada solicitação
- Status de acompanhamento (Aguardando, Em andamento, Concluído, Cancelado)
- Diferentes tipos de verificação (Imóvel, Produto, Serviço, Outro)

### ✅ Interface de Usuário

- Design moderno e responsivo
- Compatibilidade com web, Android e iOS
- Navegação intuitiva com go_router
- Componentes customizados reutilizáveis
- Tema consistente em todo o aplicativo

### ✅ Funcionalidades Adicionais

- Tela de perfil do usuário
- Configurações de notificações
- Chat básico entre usuário e verificador
- Telas de pagamento (estrutura básica)
- Sistema de navegação completo

## Tecnologias Utilizadas

- **Flutter 3.22.2** - Framework principal
- **Dart** - Linguagem de programação
- **Provider** - Gerenciamento de estado
- **go_router** - Navegação
- **shared_preferences** - Armazenamento local

## Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada do aplicativo
├── app_router.dart          # Configuração de rotas
├── models/                  # Modelos de dados
│   ├── user_model.dart
│   └── request_model.dart
├── providers/               # Gerenciamento de estado
│   ├── auth_provider.dart
│   └── request_provider.dart
├── services/               # Serviços de API
│   ├── auth_service.dart
│   └── request_service.dart
├── screens/                # Telas do aplicativo
│   ├── auth/
│   ├── home/
│   ├── requests/
│   ├── chat/
│   ├── payment/
│   └── profile/
└── widgets/                # Componentes reutilizáveis
    ├── custom_text_field.dart
    └── loading_button.dart
```

## Como Executar

### Pré-requisitos

- Flutter SDK 3.22.2 ou superior
- Dart SDK
- Navegador web (para teste web)
- Android Studio/Xcode (para dispositivos móveis)

### Instalação

1. Clone o repositório:

```bash
git clone <url-do-repositorio>
cd confirme_aki
```

2. Instale as dependências:

```bash
flutter pub get
```

3. Execute o aplicativo:

**Para Web:**

```bash
flutter run -d web
```

**Para Android:**

```bash
flutter run -d android
```

**Para iOS:**

```bash
flutter run -d ios
```

### Build para Produção

**Web:**

```bash
flutter build web
```

**Android:**

```bash
flutter build apk
```

**iOS:**

```bash
flutter build ios
```

## Credenciais de Teste

Para testar o aplicativo, use as seguintes credenciais:

- **Email:** user@test.com
- **Senha:** 123456

## Funcionalidades Testadas

### ✅ Testes Realizados

- [x] Login e autenticação
- [x] Criação de novas solicitações
- [x] Navegação entre telas
- [x] Responsividade em diferentes tamanhos de tela
- [x] Formulários com validação
- [x] Lista e detalhes de solicitações
- [x] Interface de usuário consistente

### 🔄 Funcionalidades em Desenvolvimento

- [ ] Integração com APIs reais
- [ ] Sistema de pagamento completo
- [ ] Notificações push
- [ ] Upload de imagens
- [ ] Geolocalização
- [ ] Sistema de avaliações

## Compatibilidade

- ✅ **Web** - Testado e funcionando
- ✅ **Android** - Compatível (estrutura preparada)
- ✅ **iOS** - Compatível (estrutura preparada)

## Próximos Passos

1. **Integração com Backend**

   - Implementar APIs reais para autenticação
   - Conectar com banco de dados
   - Sistema de notificações

2. **Funcionalidades Avançadas**

   - Upload de fotos e documentos
   - Integração com mapas
   - Sistema de pagamento real
   - Chat em tempo real

3. **Melhorias de UX/UI**
   - Animações e transições
   - Modo escuro
   - Acessibilidade

## Contribuição

Para contribuir com o projeto:

1. Faça um fork do repositório
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Faça um push para a branch
5. Abra um Pull Request

## Licença

## Contato

Para dúvidas ou sugestões, entre em contato através do email: contato@confirmeaki.com

---

**Desenvolvido com ❤️ usando Flutter**
