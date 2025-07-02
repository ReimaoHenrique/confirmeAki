import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/requests/request_form_screen.dart';
import 'screens/requests/my_requests_screen.dart';
import 'screens/requests/request_details_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/payment/payment_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/settings_screen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Authentication Routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      
      // Main App Routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      
      // Request Routes
      GoRoute(
        path: '/request-form',
        name: 'request-form',
        builder: (context, state) => const RequestFormScreen(),
      ),
      
      GoRoute(
        path: '/my-requests',
        name: 'my-requests',
        builder: (context, state) => const MyRequestsScreen(),
      ),
      
      GoRoute(
        path: '/request-details/:id',
        name: 'request-details',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return RequestDetailsScreen(requestId: id);
        },
      ),
      
      // Chat Route
      GoRoute(
        path: '/chat/:requestId',
        name: 'chat',
        builder: (context, state) {
          final requestId = state.pathParameters['requestId']!;
          return ChatScreen(requestId: requestId);
        },
      ),
      
      // Payment Route
      GoRoute(
        path: '/payment',
        name: 'payment',
        builder: (context, state) => const PaymentScreen(),
      ),
      
      // Profile Routes
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}

