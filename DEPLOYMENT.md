# Guia de Deployment - Confirme Aki

## Deployment Web

### Opção 1: Servidor Estático Simples

1. Faça o build para web:
```bash
flutter build web
```

2. Sirva os arquivos da pasta `build/web/`:
```bash
cd build/web
python3 -m http.server 8080
```

3. Acesse: `http://localhost:8080`

### Opção 2: Firebase Hosting

1. Instale o Firebase CLI:
```bash
npm install -g firebase-tools
```

2. Faça login no Firebase:
```bash
firebase login
```

3. Inicialize o projeto:
```bash
firebase init hosting
```

4. Configure o `firebase.json`:
```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

5. Deploy:
```bash
flutter build web
firebase deploy
```

### Opção 3: Netlify

1. Faça o build:
```bash
flutter build web
```

2. Arraste a pasta `build/web` para o Netlify Drop

3. Configure redirects criando `build/web/_redirects`:
```
/*    /index.html   200
```

## Deployment Android

### Preparação

1. Configure o arquivo `android/app/build.gradle`:
```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.confirmeaki.app"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}
```

2. Gere uma chave de assinatura:
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

3. Configure `android/key.properties`:
```properties
storePassword=<senha>
keyPassword=<senha>
keyAlias=upload
storeFile=<caminho-para-keystore>
```

### Build e Deploy

1. Build APK:
```bash
flutter build apk --release
```

2. Build App Bundle (recomendado):
```bash
flutter build appbundle --release
```

3. Upload para Google Play Console

## Deployment iOS

### Preparação

1. Abra o projeto no Xcode:
```bash
open ios/Runner.xcworkspace
```

2. Configure Bundle Identifier, Team e Signing

3. Configure `ios/Runner/Info.plist` com permissões necessárias

### Build e Deploy

1. Build para iOS:
```bash
flutter build ios --release
```

2. Archive no Xcode e upload para App Store Connect

## Configurações de Produção

### Variáveis de Ambiente

Crie arquivos de configuração para diferentes ambientes:

**lib/config/app_config.dart:**
```dart
class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.confirmeaki.com',
  );
  
  static const bool isProduction = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );
}
```

### Build com Configurações

```bash
# Desenvolvimento
flutter build web --dart-define=API_BASE_URL=http://localhost:3000

# Produção
flutter build web --dart-define=API_BASE_URL=https://api.confirmeaki.com --dart-define=PRODUCTION=true
```

## Monitoramento e Analytics

### Firebase Analytics

1. Adicione ao `pubspec.yaml`:
```yaml
dependencies:
  firebase_analytics: ^10.7.4
  firebase_core: ^2.24.2
```

2. Configure no `main.dart`:
```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

### Crashlytics

1. Adicione ao `pubspec.yaml`:
```yaml
dependencies:
  firebase_crashlytics: ^3.4.8
```

2. Configure tratamento de erros:
```dart
FlutterError.onError = (errorDetails) {
  FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
};
```

## Performance

### Otimizações Web

1. Configure `web/index.html`:
```html
<script>
  window.flutterConfiguration = {
    canvasKitBaseUrl: "https://unpkg.com/canvaskit-wasm@0.33.0/bin/",
  };
</script>
```

2. Use service worker para cache:
```javascript
// web/sw.js
self.addEventListener('fetch', (event) => {
  // Implementar estratégia de cache
});
```

### Otimizações Mobile

1. Configure ProGuard (Android):
```gradle
buildTypes {
    release {
        minifyEnabled true
        useProguard true
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
    }
}
```

2. Otimize assets:
```bash
flutter build apk --split-per-abi
```

## Checklist de Deploy

### Pré-Deploy
- [ ] Testes em diferentes dispositivos
- [ ] Verificação de performance
- [ ] Configuração de analytics
- [ ] Backup do código
- [ ] Documentação atualizada

### Deploy
- [ ] Build de produção
- [ ] Teste da build
- [ ] Upload para stores/hosting
- [ ] Verificação pós-deploy
- [ ] Monitoramento ativo

### Pós-Deploy
- [ ] Verificação de métricas
- [ ] Feedback dos usuários
- [ ] Correções de bugs críticos
- [ ] Planejamento de próximas versões

## Troubleshooting

### Problemas Comuns Web
- **Erro de CORS**: Configure headers no servidor
- **Roteamento**: Configure redirects para SPA
- **Performance**: Otimize assets e use CDN

### Problemas Comuns Mobile
- **Permissões**: Configure no AndroidManifest.xml/Info.plist
- **Assinatura**: Verifique certificados
- **Compatibilidade**: Teste em diferentes versões do OS

## Suporte

Para problemas de deployment, consulte:
- [Documentação oficial Flutter](https://docs.flutter.dev/deployment)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer)
- [App Store Connect Help](https://developer.apple.com/help/app-store-connect)

