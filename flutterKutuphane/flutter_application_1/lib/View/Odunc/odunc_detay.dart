import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/odunc_controller.dart';
import 'package:flutter_application_1/Model/odunc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OduncDetay extends StatelessWidget {
  final int? oduncId;
  final OduncController oduncController = Get.put(OduncController());
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final teslimDurumu = false.obs;

  // ignore: use_super_parameters
  OduncDetay({Key? key, required this.oduncId}) : super(key: key);

  final kulid = 0.obs;
  final kitid = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödünç Detay'),
      ),
      body: FutureBuilder<Odunc?>(
        future: oduncController.getOdunc(oduncId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Hata: ${snapshot.error}');
          } else {
            final odunc = snapshot.data!;
              final TextEditingController kullaniciAdiController =
                TextEditingController(text: odunc.kullaniciAdi);
            final TextEditingController kitapAdiController =
                TextEditingController(text: odunc.kitapAdi);
            final TextEditingController alisTarihiController =
                TextEditingController(
                    text: odunc.alisTarihi != null
                        ? (formatter.format(odunc.alisTarihi!))
                        : '');
            final TextEditingController teslimTarihiController =
                TextEditingController(
                    text: odunc.teslimTarihi != null
                        ? (formatter.format(odunc.teslimTarihi!))
                        : '');
            teslimDurumu.value = (odunc.teslimDurumu ?? false);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<int>(
                    value: odunc.kullaniciId,
                    onChanged: (int? newValue) {
                      odunc.kullaniciId = newValue!;
                    },
                    items: oduncController.kullaniciList.map((kullanici) {
                      return DropdownMenuItem<int>(
                        value: kullanici.id,
                        child: Text(kullanici.adSoyad.toString()),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Kullanıcı Adı',
                    ),
                  ),
                  DropdownButtonFormField<int>(
                    value: odunc.kitapId,
                    onChanged: (int? newValue) {
                      odunc.kitapId = newValue!;
                    },
                    items: oduncController.kitapList.map((kitap) {
                      return DropdownMenuItem<int>(
                        value: kitap.id,
                        child: Text(kitap.ad.toString()),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Kitap Adı',
                    ),
                  ),
                  _buildDatePicker(
                    context: context,
                    controller: alisTarihiController,
                    labelText: 'Alış Tarihi',
                  ),
                  _buildDatePicker(
                    context: context,
                    controller: teslimTarihiController,
                    labelText: 'Teslim Tarihi',
                  ),
                  Obx(
                    () => CheckboxListTile(
                      title: const Text('Teslim Edildi'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: teslimDurumu.value,
                      onChanged: (value) {
                        teslimDurumu.value = value!;
                      },
                       activeColor: Colors.blue,
                      checkColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (oduncId == null) {
                        Odunc yeniOdunc = Odunc(
                          kullaniciId: odunc.kullaniciId,
                          kullaniciAdi: kullaniciAdiController.text,
                          kitapId: odunc.kitapId,
                          kitapAdi: kitapAdiController.text,
                          alisTarihi:
                              formatter.parse(alisTarihiController.text),
                          teslimTarihi:
                              formatter.parse(teslimTarihiController.text),
                          teslimDurumu: teslimDurumu.value,
                        );
                        await oduncController.addOdunc(yeniOdunc);
                      } else {
                        odunc.teslimDurumu = teslimDurumu.value;
                        odunc.alisTarihi =
                            formatter.parse(alisTarihiController.text);
                        odunc.teslimTarihi =
                            formatter.parse(teslimTarihiController.text);

                        await oduncController.editOdunc(oduncId!, odunc);
                      }
                    },
                    child: const Text('Kaydet'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildDatePicker({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              // initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              controller.text = formatter.format(picked);
            }
          },
          decoration: InputDecoration(
            labelText: labelText,
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
