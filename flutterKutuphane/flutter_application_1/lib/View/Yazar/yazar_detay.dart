import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/yazar_controller.dart';
import 'package:flutter_application_1/Model/yazar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class YazarDetay extends StatelessWidget {
  final int? yazarId;
final YazarController yazarController = Get.put(YazarController());
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  // ignore: use_super_parameters
  YazarDetay({Key? key, required this.yazarId}) : super(key: key);

  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController dogumTarihiController = TextEditingController();
  final TextEditingController ulkeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yazar Detay'),
      ),
      body: Obx(() {
        final yazar = yazarController.yazarlar.firstWhereOrNull((yazar) => yazar.id == yazarId);
        if (yazar != null) {
          adController.text = yazar.ad ?? '';
          soyadController.text = yazar.soyad ?? '';
          dogumTarihiController.text = yazar.dogumTarihi != null ? formatter.format(yazar.dogumTarihi!) : '';
          ulkeController.text = yazar.ulke ?? '';
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: adController,
                labelText: 'Ad',
                onChanged: (value) {},
              ),
              _buildTextField(
                controller: soyadController,
                labelText: 'Soyad',
                onChanged: (value) {},
              ),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: AbsorbPointer(
                  child: _buildTextField(
                    controller: dogumTarihiController,
                    labelText: 'Doğum Tarihi',
                    onChanged: (value) {},
                  ),
                ),
              ),
              _buildTextField(
                controller: ulkeController,
                labelText: 'Ülke',
                onChanged: (value) {},
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final yeniYazar = Yazar(
                    id: yazarId,
                    ad: adController.text,
                    soyad: soyadController.text,
                    dogumTarihi: formatter.parse(dogumTarihiController.text),
                    ulke: ulkeController.text,
                  );

                  if (yazarId == null) {
                    await yazarController.addYazar(yeniYazar);
                  } else {
                    await yazarController.editYazar(yazarId!, yeniYazar);
                  }
                },
                child: const Text('Kaydet'),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTextField({
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      //initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dogumTarihiController.text = formatter.format(picked);
    }
  }
}
