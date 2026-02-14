import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final String role;

  const LoginPage({super.key, required this.role});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isOtpSent = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Convert role string to UserRole enum
    UserRole userRole;
    String roleDisplay;
    Color roleColor;
    IconData roleIcon;

    switch (widget.role) {
      case 'cook':
        userRole = UserRole.cook;
        roleDisplay = 'Cuisinier';
        roleColor = const Color(0xFF708238); // Olive Green
        roleIcon = Icons.kitchen;
        break;
      case 'courier':
        userRole = UserRole.courier;
        roleDisplay = 'Livreur';
        roleColor = const Color(0xFF795548); // Warm Brown
        roleIcon = Icons.delivery_dining;
        break;
      default:
        userRole = UserRole.client;
        roleDisplay = 'Client';
        roleColor = const Color(0xFFCC5500); // Burnt Orange
        roleIcon = Icons.restaurant_menu;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_isOtpSent) {
              setState(() => _isOtpSent = false);
            } else {
              context.go('/role-selection');
            }
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(roleIcon, color: roleColor, size: 20),
            const SizedBox(width: 8),
            Text(roleDisplay, style: TextStyle(color: roleColor, fontSize: 18)),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Gusto',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF708238), // Olive Green
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Authentic & Homemade Cooking',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Icon(Icons.local_dining, size: 100, color: roleColor),
                const SizedBox(height: 32),

                if (!_isOtpSent) ...[
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Numéro de téléphone',
                      prefixText: '+213 ',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre numéro';
                      }
                      // Regex for Algerian phone numbers: 05, 06, 07 followed by 8 digits
                      final regex = RegExp(r'^0[567][0-9]{8}$');
                      if (!regex.hasMatch(value)) {
                        return 'Numéro invalide (ex: 0550123456)';
                      }
                      return null;
                    },
                  ),
                ] else ...[
                  Text(
                    'Code envoyé au +213 ${_phoneController.text}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _otpController,
                    decoration: const InputDecoration(
                      labelText: 'Code OTP (123456)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_clock),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le code';
                      }
                      if (value.length != 6) {
                        return 'Le code doit contenir 6 chiffres';
                      }
                      return null;
                    },
                  ),
                ],

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);

                            try {
                              if (!_isOtpSent) {
                                // Step 1: Request OTP via Cubit/Service
                                await context.read<AuthCubit>().requestOtp(
                                  _phoneController.text,
                                );

                                if (mounted) {
                                  setState(() {
                                    _isOtpSent = true;
                                    _isLoading = false;
                                  });
                                }
                              } else {
                                // Step 2: Verify OTP and Login
                                // Real verification happens in login() call below

                                // Mock validation (accept any 6 digit code for now, or specific one)
                                // In real app, verify with backend

                                if (mounted) {
                                  // Update AuthCubit with selected role and persistence
                                  await context.read<AuthCubit>().login(
                                    phone: _phoneController.text,
                                    otp: _otpController.text,
                                    role: userRole,
                                  );

                                  if (mounted) {
                                    final authState = context
                                        .read<AuthCubit>()
                                        .state;
                                    // Manual navigation to ensure we don't get stuck
                                    switch (authState.user?.role) {
                                      case UserRole.cook:
                                        context.go('/cook/dashboard');
                                        break;
                                      case UserRole.courier:
                                        context.go('/courier/dashboard');
                                        break;
                                      case UserRole.admin:
                                        context.go('/admin');
                                        break;
                                      default:
                                        context.go('/');
                                    }
                                  }
                                }
                              }
                            } catch (e) {
                              if (mounted) {
                                setState(() => _isLoading = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Erreur: $e')),
                                );
                              }
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: roleColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(_isOtpSent ? 'Vérifier' : 'Recevoir le code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
