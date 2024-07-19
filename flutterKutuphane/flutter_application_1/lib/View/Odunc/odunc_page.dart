import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/odunc_controller.dart';
import 'package:flutter_application_1/Model/odunc.dart';
import 'package:flutter_application_1/View/Odunc/kitap_filtre.dart';
import 'package:flutter_application_1/View/Odunc/kullanici_filtre.dart';
import 'package:flutter_application_1/View/Odunc/odunc_detay.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OduncPage extends StatefulWidget {
  // ignore: use_super_parameters
  const OduncPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OduncPageState createState() => _OduncPageState();
}

class _OduncPageState extends State<OduncPage> {
  final OduncController oduncController = Get.put(OduncController());
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
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
         await oduncController.getOduncListe(_currentPage, clearList: true);
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
      await oduncController.getOduncListe(_currentPage);
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

  void _openFilters() {
     _scaffoldKey.currentState!.openEndDrawer();
  }

  
 void _clearFilters() {
  oduncController.filterByKullaniciAdlari([]);
  oduncController.filterByKitapAdlari([]);
  oduncController.getOduncListe(1, clearList: true); 
}

  

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Ödünç İşlemleri'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _openFilters,
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
              title: const Text('Kullanıcı Seç'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => KullaniciFiltre());
              },
            ),
            ListTile(
              title: const Text('Kitap Seç'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => KitapFiltre());
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
          if (oduncController.oduncler.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount: oduncController.oduncler.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == oduncController.oduncler.length) {
                  return _buildProgressIndicator();
                } else {
                  final Odunc odunc = oduncController.oduncler[index];
                  return Card(
                    elevation: 15,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Slidable(
                    startActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Get.to(() => OduncDetay(oduncId: odunc.id!));
                          },
                          backgroundColor:const Color.fromARGB(255, 64, 176, 8),
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
                                  final int id = odunc.id!;
                                  oduncController.deleteOdunc(id);
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Sil',
                              ),
                            ],
                          ),
                      child: ListTile(
                        title: Text('ID: ${odunc.id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kullanıcı Adı: ${odunc.kullaniciAdi}'),
                            Text('Kitap Adı: ${odunc.kitapAdi}'),
                            Text(odunc.alisTarihi != null ? formatter.format(odunc.alisTarihi!) : ''),
                            Text(odunc.teslimTarihi != null ? formatter.format(odunc.teslimTarihi!) : ''),
                            Row(
                              children: [
                                const Text('Teslim Durumu: '),
                                Icon(
                                  odunc.teslimDurumu ?? false ? Icons.check_box : Icons.check_box_outline_blank,
                                  color: odunc.teslimDurumu ?? false ? Colors.blue : Colors.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
      final result = await Get.to(() => OduncDetay(oduncId: null));
        if (result != null && result as bool) {
       oduncController.getOduncListe(1, clearList: true);
      }
        },
        tooltip: 'Yeni Kayıt Ekle',
        backgroundColor: const Color.fromARGB(255, 237, 240, 237),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 41, 23, 234)),
      ),
    );
  }
}
