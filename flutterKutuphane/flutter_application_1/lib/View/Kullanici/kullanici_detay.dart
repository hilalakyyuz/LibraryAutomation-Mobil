import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/kullanici_controller.dart';
import 'package:flutter_application_1/Controllers/resim_controller.dart';
import 'package:flutter_application_1/Model/kullanici.dart';
import 'package:flutter_application_1/Model/resim.dart';
import 'package:flutter_application_1/View/Kullanici/kullanicilar_page.dart';
import 'package:flutter_application_1/View/Resim/resim_page.dart';
import 'package:get/get.dart';

class KullaniciDetay extends StatelessWidget {
  final int? kullaniciId;
  final kullaniciController = Get.put(KullaniciController());
  final resimController = Get.put(ResimController());

  // ignore: use_key_in_widget_constructors
  KullaniciDetay({Key? key, required this.kullaniciId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Detay'),
      ),
      body: FutureBuilder<Kullanici?>(
        future: kullaniciController.getKullanici(kullaniciId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Hata: ${snapshot.error}');
          } else {
            final kullanici = snapshot.data;
            final TextEditingController adSoyadController =
                TextEditingController(text: kullanici!.adSoyad);
            final TextEditingController emailController =
                TextEditingController(text: kullanici.email);

            return FutureBuilder<Resim?>(
              future: resimController.getVarsayilanResim(kullaniciId),
              builder: (context, resimSnapshot) {
                if (resimSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (resimSnapshot.hasError) {
                  return Text(
                      'Resim yüklenirken bir hata oluştu: ${resimSnapshot.error}');
                } else {
                  Uint8List? imageBytes;
                  if (resimSnapshot.data != null &&
                      resimSnapshot.data!.resim != null) {
                    imageBytes = base64Decode(resimSnapshot.data!.resim!);
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (imageBytes != null)
                          Image.memory(
                            imageBytes,
                            height: 100,
                            width: 100,
                          ),
                        _buildTextField(
                          controller: adSoyadController,
                          labelText: 'Ad Soyad',
                          onChanged: (value) {
                            kullanici.adSoyad = value;
                          },
                        ),
                        _buildTextField(
                          controller: emailController,
                          labelText: 'Email',
                          onChanged: (value) {
                            kullanici.email = value;
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_camera,
                              color: Color.fromARGB(255, 14, 14, 16),
                              size: 35.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes'),
                          title: const Text(
                            'Resim Yükle',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResimPage(
                                        kullaniciId: kullaniciId ?? 0)));
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (kullaniciId == null) {
                              Kullanici yeniKullanici = Kullanici(
                                resim: imageBytes != null
                                    ? base64Encode(imageBytes)
                                    : null,
                                adSoyad: adSoyadController.text,
                                email: emailController.text,
                              );
                              await kullaniciController
                                  .addKullanici(yeniKullanici);
                            } else {
                              await kullaniciController.editKullanici(
                                  kullaniciId!, kullanici);
                            }
                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => KullaniciPage(),
                              ),
                            );
                          },
                          child: const Text('Kaydet'),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  static Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required void Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
