import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../../core/api_client.dart';

class KycPage extends StatefulWidget {
  const KycPage({super.key});

  @override
  State<KycPage> createState() => _KycPageState();
}

class _KycPageState extends State<KycPage> {
  XFile? _cniFront;
  final _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _cniFront = image;
      });
    }
  }

  Future<void> _uploadKyc() async {
    if (_cniFront == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      final apiClient = ApiClient();
      String fileName = _cniFront!.path.split('/').last;

      FormData formData = FormData.fromMap({
        "cni_front": await MultipartFile.fromFile(
          _cniFront!.path,
          filename: fileName,
        ),
      });

      final response = await apiClient.post('/kyc/upload', data: formData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('KYC Envoyé: ${response.data['message']}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur upload: $e')));
      }
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vérification KYC')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Veuillez uploader votre CNI (Recto)'),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _cniFront != null
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 50,
                            ),
                            SizedBox(height: 8),
                            Text('Image sélectionnée'),
                          ],
                        ),
                      )
                    : const Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.grey,
                      ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadKyc,
              child: _isUploading
                  ? const CircularProgressIndicator()
                  : const Text('Envoyer le dossier'),
            ),
          ],
        ),
      ),
    );
  }
}
