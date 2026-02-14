import 'package:flutter/material.dart';

class CreateDishPage extends StatefulWidget {
  const CreateDishPage({super.key});

  @override
  State<CreateDishPage> createState() => _CreateDishPageState();
}

class _CreateDishPageState extends State<CreateDishPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  bool _isLoading = false;

  Future<void> _createDish() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        // Here you would normally call the API
        // For now, we simulate success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Plat ajouté avec succès (Simulation) !'),
          ),
        );
        Navigator.pop(context);
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un plat')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nom du plat'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requis' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requis' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Prix (DA)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requis' : null,
              ),
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(labelText: 'Stock initial'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _createDish,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Ajouter au menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
