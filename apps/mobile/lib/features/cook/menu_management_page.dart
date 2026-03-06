import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client/dishes_api_service.dart';
import '../../core/api_client.dart';
import '../auth/auth_cubit.dart';

class MenuManagementPage extends StatefulWidget {
  const MenuManagementPage({super.key});

  @override
  State<MenuManagementPage> createState() => _MenuManagementPageState();
}

class _MenuManagementPageState extends State<MenuManagementPage> {
  final DishesApiService _dishesApiService = DishesApiService(ApiClient());
  List<Map<String, dynamic>> _dishes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDishes();
  }

  Future<void> _fetchDishes() async {
    try {
      final cookId = context.read<AuthCubit>().state.user?.id ?? 1;
      final dishes = await _dishesApiService.getDishesByCook(cookId);
      if (mounted) {
        setState(() {
          _dishes = dishes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mon Menu',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/create-dish'),
        label: const Text('Ajouter un plat'),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _dishes.isEmpty
              ? const Center(child: Text("Vous n'avez pas encore ajouté de plat."))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _dishes.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final dish = _dishes[index];
                    final isActive = true; // Replace with dish['active'] if backend supports

                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: dish['image'] != null
                              // If it's a network image from server, use Image.network
                              // For now we keep using asset logic or fallback since Nest Multer returns path
                              ? Image.network(
                                  dish['image'].toString().startsWith('http')
                                      ? dish['image']
                                      : 'http://10.0.2.2:3000/uploads/${dish['image']}', // assuming local testing url
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.restaurant, color: Colors.grey),
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/dishes/couscous_royal.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        title: Text(
                          dish['name'] as String,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              '${dish['price']} DA',
                              style: GoogleFonts.outfit(
                                color: const Color(0xFF933D41),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                isActive ? 'Actif' : 'Inactif',
                                style: TextStyle(
                                  color: isActive ? Colors.green : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
