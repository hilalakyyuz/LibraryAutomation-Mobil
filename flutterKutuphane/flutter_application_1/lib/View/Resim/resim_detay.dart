import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/resim_controller.dart';
import 'package:flutter_application_1/View/Resim/resim_page.dart';
import 'package:image_picker/image_picker.dart';

class ResimDetay extends StatefulWidget {
  final int kullaniciId;
  final ResimController resimController;

  const ResimDetay({super.key, required this.kullaniciId, required this.resimController});

  @override
  // ignore: library_private_types_in_public_api
  _ResimDetayState createState() => _ResimDetayState();
}

class _ResimDetayState extends State<ResimDetay> {
  final List<File> _images = [];
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
      }
    });
  }

  Future<void> _saveImage() async {
    bool allSuccess = true;

    for (var image in _images) {
      bool success = await widget.resimController.addResim(image, widget.kullaniciId);
      if (!success) {
        allSuccess = false;
      }
    }

    if (allSuccess) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Resim sayfasına dönülüyor
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _handleSaveButtonPressed() async {
    await _saveImage();
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => ResimPage(kullaniciId: widget.kullaniciId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resim Detay'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _images.isEmpty
                ? const Center(child: Text('Resim seçilmedi'))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Image.file(
                              _images[index],
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _removeImage(index),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 91, 71, 244),
                  ),
                  label: const Text(''),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(
                    Icons.photo,
                    color: Color.fromARGB(255, 227, 115, 253),
                  ),
                  label: const Text(''),
                ),
                ElevatedButton(
                  onPressed: _handleSaveButtonPressed,
                  child: const Text(
                    'Kaydet',
                    style: TextStyle(color: Color.fromARGB(255, 49, 232, 77)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


