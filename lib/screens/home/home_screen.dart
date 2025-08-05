import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/request_provider.dart';
import '../../models/request_model.dart';
import '../../widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showLoginPrompt = true;
  LatLng? _currentPosition;
  String? _locationError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RequestProvider>(context, listen: false).loadRequests();
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (!authProvider.isAuthenticated) {
        setState(() {
          _showLoginPrompt = true;
        });
      }
    });
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationError = 'Serviço de localização desativado';
        });
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationError = 'Permissão de localização negada';
          });
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationError = 'Permissão de localização permanentemente negada';
        });
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _locationError = null;
      });
    } catch (e) {
      setState(() {
        _locationError = 'Erro ao obter localização: $e';
      });
    }
  }

  void _openLogin() {
    setState(() {
      _showLoginPrompt = false;
    });
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirme Aki'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implementar notificações
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificações em desenvolvimento')),
              );
            },
          ),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'profile':
                      context.go('/profile');
                      break;
                    case 'settings':
                      context.go('/settings');
                      break;
                    case 'logout':
                      _showLogoutDialog();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.person_outlined),
                        SizedBox(width: 8),
                        Text('Perfil'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings_outlined),
                        SizedBox(width: 8),
                        Text('Configurações'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 8),
                        Text('Sair'),
                      ],
                    ),
                  ),
                ],
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await Provider.of<RequestProvider>(context, listen: false).loadRequests();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_currentPosition != null)
                    SizedBox(
                      height: 220,
                      child: Consumer<RequestProvider>(
                        builder: (context, requestProvider, child) {
                          final requestsNearby = requestProvider.requests.where((req) {
                            if (req.latitude == null || req.longitude == null) return false;
                            final distance = Geolocator.distanceBetween(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude,
                              req.latitude!,
                              req.longitude!,
                            );
                            return distance <= 5000; // 5km
                          }).toList();
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: _currentPosition!,
                                zoom: 14,
                              ),
                              myLocationEnabled: true,
                              markers: {
                                Marker(
                                  markerId: const MarkerId('me'),
                                  position: _currentPosition!,
                                  infoWindow: const InfoWindow(title: 'Você'),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                                ),
                                ...requestsNearby.map((req) => Marker(
                                  markerId: MarkerId(req.id),
                                  position: LatLng(req.latitude!, req.longitude!),
                                  infoWindow: InfoWindow(title: req.title, snippet: req.address),
                                )),
                              },
                            ),
                          );
                        },
                      ),
                    )
                  else if (_locationError != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(_locationError!, style: const TextStyle(color: Colors.red)),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  const SizedBox(height: 24),
                  
                  // Ações principais
                  Text(
                    'Ações Rápidas',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      ActionCard(
                        icon: Icons.add_circle_outline,
                        title: 'Nova Solicitação',
                        subtitle: 'Solicitar verificação',
                        color: Colors.blue,
                        onTap: () => context.go('/request-form'),
                      ),
                      ActionCard(
                        icon: Icons.list_alt,
                        title: 'Minhas Solicitações',
                        subtitle: 'Ver histórico',
                        color: Colors.green,
                        onTap: () => context.go('/my-requests'),
                      ),
                      ActionCard(
                        icon: Icons.account_balance_wallet_outlined,
                        title: 'Carteira',
                        subtitle: 'Ver saldo e extrato',
                        color: Colors.orange,
                        onTap: () => context.go('/wallet'),
                      ),
                      ActionCard(
                        icon: Icons.person,
                        title: 'Perfil',
                        subtitle: 'Editar informações',
                        color: Colors.purple,
                        onTap: () => context.go('/profile'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Solicitações recentes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Solicitações Recentes',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go('/my-requests'),
                        child: const Text('Ver todas'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Consumer<RequestProvider>(
                    builder: (context, requestProvider, child) {
                      if (requestProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      
                      final recentRequests = requestProvider.requests.take(3).toList();
                      
                      if (recentRequests.isEmpty) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Nenhuma solicitação encontrada',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Crie sua primeira solicitação para começar',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[500],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: () => context.go('/request-form'),
                                  icon: const Icon(Icons.add),
                                  label: const Text('Nova Solicitação'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      
                      return Column(
                        children: recentRequests.map((request) => RequestCard(
                          request: request,
                          onTap: () => context.go('/request-details/${request.id}'),
                        )).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_showLoginPrompt)
            Container(
              color: Colors.black54,
              child: Center(
                child: Card(
                  margin: const EdgeInsets.all(32),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.login,
                          size: 64,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Bem-vindo ao Confirme Aki!',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Faça login para acessar todas as funcionalidades',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _openLogin,
                            child: const Text('Fazer Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => const LogoutDialog(),
    );
  }
}

