import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/resim_controller.dart';
import 'package:flutter_application_1/Model/resim.dart';
import 'package:flutter_application_1/View/Kullanici/kullanici_detay.dart';
import 'package:flutter_application_1/View/Resim/resim_detay.dart';
import 'package:get/get.dart';

class ResimPage extends StatelessWidget {
  final int kullaniciId;
  final ResimController resimController = Get.put(ResimController());

  // ignore: use_super_parameters
  ResimPage({Key? key, required this.kullaniciId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ResimBody(kullaniciId: kullaniciId, resimController: resimController),
    );
  }
}

class ResimBody extends StatefulWidget {
  final int kullaniciId;
  final ResimController resimController;

  // ignore: use_super_parameters
  const ResimBody(
      {Key? key, required this.kullaniciId, required this.resimController})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ResimBodyState createState() => _ResimBodyState();
}

class _ResimBodyState extends State<ResimBody> {
  double get height => MediaQuery.of(context).size.height;
  bool _resimlerYuklendi = false;

  @override
  void initState() {
    super.initState();
    _getResimListesi();
  }

  Future<void> _getResimListesi() async {
    try {
      await widget.resimController.getResimlerByKullaniciID(widget.kullaniciId);
      setState(() {
        _resimlerYuklendi = true;
      });
    } catch (e) {
      //
    }
  }

  Future<void> _refreshResimler() async {
    await _getResimListesi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Resim'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResimDetay(
                kullaniciId: widget.kullaniciId,
                resimController: widget.resimController,
              ),
            ),
          );
          if (result == true) {
            _refreshResimler();
          }
        },
        backgroundColor: const Color.fromARGB(255, 237, 240, 237),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 41, 23, 234)),
      ),
      body: _resimlerYuklendi
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: 1.0,
              ),
              itemCount: widget.resimController.resimler.length,
              itemBuilder: (context, index) {
                final resim = widget.resimController.resimler[index];
                return GestureDetector(
                  onTap: () {
                    _showPopupMenu(context, index, resim);
                  },
                  child: Image.memory(
                    resim.getResimBytes(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  void _showPopupMenu(BuildContext context, int index, Resim resim) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position = overlay.localToGlobal(Offset.zero);

    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(
              Icons.delete,
              size: 15,
              color: Colors.red,
            ),
            title: const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('Sil', style: TextStyle(fontSize: 15)),
            ),
            onTap: () async {
              Navigator.pop(context);
              await _deleteResim(resim);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(
              Icons.check,
              size: 15,
              color: Colors.blue,
            ),
            title: const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('Varsayılan Seç', style: TextStyle(fontSize: 15)),
            ),
            onTap: () async {
              Navigator.pop(context);
              await _editVarsayilanResim(resim);
            },
          ),
        ),
      ],
    );

    if (selected != null) {
      setState(() {});
    }
  }

  Future<void> _editVarsayilanResim(Resim resim) async {
    try {
      bool success = await widget.resimController.editVarsayilanResim(resim);
      if (success) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Varsayılan resim düzenlendi.'),
        ));
        // Navigate to KullaniciDetay page
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => KullaniciDetay(kullaniciId: widget.kullaniciId),
          ),
        );
      } else {
        // Handle failure
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _deleteResim(Resim resim) async {
    try {
      bool success =
          await widget.resimController.deleteResim(resim.id!.toInt());
      if (success) {
        setState(() {
          widget.resimController.resimler.remove(resim);
        });
      } else {
        // Handle failure
      }
    } catch (e) {
      // Handle error
    }
  }
}
