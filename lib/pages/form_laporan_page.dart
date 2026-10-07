import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/laporan_model.dart';

class FormLaporanPage extends StatefulWidget {
  const FormLaporanPage({super.key});

  @override
  State<FormLaporanPage> createState() => _FormLaporanPageState();
}

class _FormLaporanPageState extends State<FormLaporanPage> {
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String _kategoriTerpilih = 'Sampah';
  String? _urgensiTerpilih = 'Sedang';
  bool _konfirmasiKebenaran = false;
  bool _sedangMengirim = false;

  final List<String> _kategoriList = [
    'Sampah',
    'Jalan Rusak',
    'Banjir',
    'Lampu PJU',
  ];

  bool get _isValid =>
      _judulController.text.trim().isNotEmpty &&
      _deskripsiController.text.trim().isNotEmpty &&
      _konfirmasiKebenaran &&
      _urgensiTerpilih != null;

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _kirimLaporan() async {
    setState(() => _sedangMengirim = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final newId = 'LAP-${DateTime.now().millisecond}';
    context.read<LaporanModel>().tambahLaporan(
          LaporanMasalah(
            id: newId,
            judul: _judulController.text.trim(),
            deskripsi: _deskripsiController.text.trim(),
            kategori: _kategoriTerpilih,
            urgensi: _urgensiTerpilih!,
            waktu: DateTime.now(),
            isSelesai: false,
          ),
        );

    setState(() => _sedangMengirim = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Laporan #$newId berhasil diteruskan ke Dinas Terkait!'),
        backgroundColor: Colors.indigo,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Laporan Warga'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _kategoriTerpilih,
              decoration: const InputDecoration(
                labelText: 'Kategori Fasilitas / Masalah',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: _kategoriList.map((k) {
                return DropdownMenuItem(value: k, child: Text(k));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _kategoriTerpilih = val);
              },
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(
                labelText: 'Judul Pengaduan',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _deskripsiController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Detail & Lokasi Spesifik',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 14),
            const Text(
              'Tingkat Urgensi Masalah:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              children: ['Rendah', 'Sedang', 'Mendesak'].map((urg) {
                return RadioListTile<String>(
                  title: Text(urg),
                  value: urg,
                  // ignore: deprecated_member_use
                  groupValue: _urgensiTerpilih,
                  // ignore: deprecated_member_use
                  onChanged: (val) {
                    setState(() => _urgensiTerpilih = val);
                  },
                );
              }).toList(),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _konfirmasiKebenaran,
              title: const Text(
                'Saya menyatakan laporan ini benar dan dapat dipertanggungjawabkan.',
                style: TextStyle(fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (val) {
                setState(() => _konfirmasiKebenaran = val ?? false);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: (_isValid && !_sedangMengirim) ? _kirimLaporan : null,
              child: _sedangMengirim
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Kirimkan Pengaduan', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
