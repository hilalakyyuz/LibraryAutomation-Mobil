import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Controllers/kitap_controller.dart';
import 'package:flutter_application_1/View/Kitap/kategori_filtre.dart';
import 'package:flutter_application_1/View/Kitap/yazar_filtre.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_application_1/View/Kitap/kitap_detay.dart';

class KitapPage extends StatefulWidget {
  // ignore: use_super_parameters
  const KitapPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _KitapPageState createState() => _KitapPageState();
}

class _KitapPageState extends State<KitapPage> {
  final KitapController kitapController = Get.put(KitapController());
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _currentPage = 1;
      await kitapController.getKitapListe(_currentPage, clearList: true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      setState(() {
        _isLoading = true;
      });
      _currentPage += 1;
      await kitapController.getKitapListe(_currentPage);
      setState(() {
        _isLoading = false;
      });

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget _buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  void _openFiltreler() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _clearFilters() {
    kitapController.filterByKategoriAdlari([]);
    kitapController.filterByYazarAdlari([]);
    kitapController.getKitapListe(1, clearList: true); 
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Kitaplar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _openFiltreler,
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Filtrele',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                ),
              ),
            ),
            ListTile(
              title: const Text('Kategori Seç'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => KategoriFiltre());
              },
            ),
            ListTile(
              title: const Text('Yazar Seç'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => YazarFiltre());
              },
            ),
            ListTile(
              title: const Text(' Seçimi Temizle',
              style: TextStyle(color: Colors.red),),
              onTap: () {
                Navigator.pop(context);
                _clearFilters();
              },
            ),
          ],
        ),
      ),
      body: Obx(
        () {
          return ListView.builder(
            controller: _scrollController,
            itemCount: kitapController.kitaplar.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == kitapController.kitaplar.length) {
                return _isLoading ? _buildProgressIndicator() : Container();
              } else {
                final kitap = kitapController.kitaplar[index];
                return Card(
                  elevation: 15,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Slidable(
                    startActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Get.to(() => KitapDetay(kitapId: kitap.id!));
                          },
                          backgroundColor: const Color.fromARGB(255, 64, 176, 8),
                          icon: Icons.edit,
                          label: 'Düzenle',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            final int id = kitap.id!;
                            kitapController.deleteKitap(id).then((success) {
                              if (!success) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Uyarı'),
                                      content: const Text('Bu kitap ödünç verildiği için silinemez.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Tamam'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            });
                          },
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: 'Sil',
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text('ID: ${kitap.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kitap Adı: ${kitap.ad}'),
                          Text('Kategori Adı: ${kitap.adi}'),
                          Text('Yazar: ${kitap.adyazar}'),
                          Text('Yayın Yılı: ${kitap.yayinYili}'),
                          Text('Sayfa Sayısı: ${kitap.sayfaSayisi}'),
                          Text('Fiyat: ${kitap.fiyat}'),
                        ],
                      ),
                      onTap: () {
                        final selectedKitap = kitapController.kitaplar[index];
                        Get.back(result: selectedKitap);
                      },
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(() => KitapDetay(kitapId: null));
        },
        tooltip: 'Yeni Kayıt Ekle',
        backgroundColor: const Color.fromARGB(255, 237, 240, 237),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 41, 23, 234)),
      ),
    );
  }
}