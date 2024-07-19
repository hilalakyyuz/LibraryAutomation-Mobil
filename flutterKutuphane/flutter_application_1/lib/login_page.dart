import 'package:flutter/material.dart';
import 'package:flutter_application_1/AP%C4%B0/gorevli_api.dart';
import 'package:flutter_application_1/Model/gorevli.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Loginpage extends StatelessWidget {
  final TextEditingController _kullaniciAdiController = TextEditingController();
  final TextEditingController _sifreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final RxString _girisHata = ''.obs;
  final _storage = GetStorage();
  final RxBool _beniHatirla = false.obs;

  Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    _kullaniciAdiController.text = _storage.read('username') ?? '';
    _sifreController.text = _storage.read('password') ?? '';
    _beniHatirla.value = _storage.read('rememberMe') ?? false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Kütüphane Otomasyonu',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 222, 189, 244),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _kullaniciAdiController,
                  onChanged: (value) => _girisHata.value = '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kullanıcı Adı boş bırakılamaz';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Kullanıcı Adı",
                    errorText: _girisHata.value.isEmpty ? null : _girisHata.value,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _sifreController,
                  onChanged: (value) => _girisHata.value = '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifre boş bırakılamaz';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Şifre",
                    errorText: _girisHata.value.isEmpty ? null : _girisHata.value,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Obx(
                      () => Checkbox(
                        activeColor: const Color.fromARGB(255, 53, 92, 170),
                        value: _beniHatirla.value,
                        onChanged: (value) {
                          _beniHatirla.value = value!;
                        },
                      ),
                    ),
                    const Text('Beni Hatırla',
                    style:TextStyle(fontSize:14 )),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String kullaniciAdi = _kullaniciAdiController.text;
                      String sifre = _sifreController.text;

                      String sonuc = await ApiGorevli.girisYap(
                        Gorevli(adSoyad: kullaniciAdi, sifre: sifre, id: 0),
                      );

                      if (sonuc == "Giriş başarılı.") {
                        if (_beniHatirla.value) {
                          _storage.write('username', kullaniciAdi);
                          _storage.write('password', sifre);
                          _storage.write('rememberMe', true);
                        } else {
                          _storage.remove('username');
                          _storage.remove('password');
                          _storage.remove('rememberMe');
                        }

                        Get.offAll(() => const HomePage());
                      } else {
                        _girisHata.value = sonuc;
                      }
                    }
                  },
                  child: const Text(
                    'Giriş Yap',
                    style: TextStyle(color: Color.fromARGB(255, 9, 64, 167) ,
                    fontSize: 17),
                    
                  ),
                ),
                Obx(() {
                  if (_girisHata.value.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _girisHata.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
