import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/Kategori/kategori_page.dart';
import 'package:flutter_application_1/View/Kitap/kitaplar_page.dart';
import 'package:flutter_application_1/View/Kullanici/kullanicilar_page.dart';
import 'package:flutter_application_1/View/Odunc/odunc_page.dart';
import 'package:flutter_application_1/View/Yazar/yazarlar_page.dart';
import 'package:flutter_application_1/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kütüphane Otomasyonu',
          style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 6, 6, 6)),
        ),
        backgroundColor: const Color.fromARGB(255, 81, 96, 189),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app,
                color: Color.fromARGB(255, 81, 96, 189)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Loginpage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color:Color.fromARGB(255, 135, 155, 243),
              ),
              child: Text(
                'Kütüphane İşlemleri',
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 8, 8),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book,
                  color: Color.fromARGB(255, 202, 137, 191),
                  size: 35.0,
                  semanticLabel: 'Text to announce in accessibility modes'),
              title: const Text(
                'Kitaplar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KitapPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: Color.fromARGB(255, 202, 137, 191),
                size: 35.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              title: const Text(
                'Yazarlar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  YazarPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle,
                  color: Color.fromARGB(255, 202, 137, 191),
                  size: 35.0,
                  semanticLabel: 'Text to announce in accessibility modes'),
              title: const Text(
                'Kullanıcılar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  KullaniciPage()),
                );
              },
            ),
            ListTile(
                leading: const Icon(Icons.list_sharp,
                    color: Color.fromARGB(255, 202, 137, 191),
                    size: 35.0,
                    semanticLabel: 'Text to announce in accessibility modes'),
                title: const Text(
                  'Kategoriler',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  KategoriPage()),
                  );
                }),
            ListTile(
              leading: const Icon(Icons.library_add,
                  color: Color.fromARGB(255, 202, 137, 191),
                  size: 35.0,
                  semanticLabel: 'Text to announce in accessibility modes'),
              title: const Text(
                'Ödünç İşlemleri',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OduncPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/img/anasayfa.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(),
      ),
    );
  }
}
