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
    UserRole userRole;
    String roleDisplay;
    Color roleColor;
    IconData roleIcon;

    switch (widget.role) {
      case 'cook':
        userRole = UserRole.cook;
        roleDisplay = 'Devenir Cuisinier';
        roleColor = const Color(0xFF708238); // Olive Green
        roleIcon = Icons.soup_kitchen;
        break;
      case 'courier':
        userRole = UserRole.courier;
        roleDisplay = 'Devenir Livreur';
        roleColor = const Color(0xFF795548); // Warm Brown
        roleIcon = Icons.delivery_dining;
        break;
      default:
        userRole = UserRole.client;
        roleDisplay = 'Client';
        roleColor = const Color(0xFF933D41); // Wajabat Rouge Terre
        roleIcon = Icons.restaurant_menu;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            if (_isOtpSent) {
              setState(() => _isOtpSent = false);
            } else {
              context.go('/role-selection');
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Wajabat Branding
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: roleColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(roleIcon, size: 60, color: roleColor),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Wajabat',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: roleColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Les meilleurs plats faits maison,\nlivrés chez vous.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                if (!_isOtpSent) ...[
                  const Text(
                    'Entrez votre numéro pour continuer',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: '05 50 12 34 56',
                      prefixText: '+213  ',
                      prefixStyle: const TextStyle(
                        color: Colors.black87, 
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5), // Light grey pill
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    ),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre numéro';
                      }
                      final regex = RegExp(r'^0[567][0-9]{8}$');
                      if (!regex.hasMatch(value)) {
                        return 'Numéro invalide (ex: 0550123456)';
                      }
                      return null;
                    },
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Code envoyé au',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '+213 ${_phoneController.text}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Entrez le code de vérification',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _otpController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '1 2 3 4 5 6',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    ),
                    style: const TextStyle(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 6) {
                        return 'Code invalide';
                      }
                      return null;
                    },
                  ),
                ],

                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);

                            try {
                              if (!_isOtpSent) {
                                await context.read<AuthCubit>().requestOtp(_phoneController.text);
                                if (mounted) {
                                  setState(() {
                                    _isOtpSent = true;
                                    _isLoading = false;
                                  });
                                }
                              } else {
                                if (mounted) {
                                  await context.read<AuthCubit>().login(
                                    phone: _phoneController.text,
                                    otp: _otpController.text,
                                    role: userRole,
                                  );

                                  if (mounted) {
                                    final authState = context.read<AuthCubit>().state;
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
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          _isOtpSent ? 'Vérifier et continuer' : 'Recevoir le code',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
