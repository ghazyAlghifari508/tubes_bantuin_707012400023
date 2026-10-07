import 'package:flutter/foundation.dart';

class LaporanMasalah {
  final String id;
  final String judul;
  final String deskripsi;
  final String kategori; // Sampah, Jalan Rusak, Banjir, Lampu PJU
  final String urgensi; // Rendah, Sedang, Mendesak
  final DateTime waktu;
  bool isSelesai;

  LaporanMasalah({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.kategori,
    required this.urgensi,
    required this.waktu,
    this.isSelesai = false,
  });
}

class LaporanModel extends ChangeNotifier {
  final List<LaporanMasalah> _laporanList = [
    LaporanMasalah(
      id: 'LAP-101',
      judul: 'Tumpukan Sampah di Jl. Telekomunikasi',
      deskripsi: 'Sampah menumpuk sejak 2 hari lalu di seberang gerbang utama kampus.',
      kategori: 'Sampah',
      urgensi: 'Mendesak',
      waktu: DateTime.now().subtract(const Duration(hours: 5)),
      isSelesai: false,
    ),
    LaporanMasalah(
      id: 'LAP-102',
      judul: 'Lampu PJU Padam di Sukabirus',
      deskripsi: 'Penerangan jalan mati menyebabkan gang gelap dan rawan kecelakaan.',
      kategori: 'Lampu PJU',
      urgensi: 'Sedang',
      waktu: DateTime.now().subtract(const Duration(hours: 12)),
      isSelesai: true,
    ),
    LaporanMasalah(
      id: 'LAP-103',
      judul: 'Jalan Berlubang Dekat Simpang Bojongsoang',
      deskripsi: 'Lubang sedalam 15cm membahayakan pengendara roda dua.',
      kategori: 'Jalan Rusak',
      urgensi: 'Mendesak',
      waktu: DateTime.now().subtract(const Duration(days: 1)),
      isSelesai: false,
    ),
  ];

  List<LaporanMasalah> get laporanList => List.unmodifiable(_laporanList);

  void tambahLaporan(LaporanMasalah laporan) {
    _laporanList.insert(0, laporan);
    notifyListeners();
  }

  void toggleStatus(String id) {
    final idx = _laporanList.indexWhere((l) => l.id == id);
    if (idx != -1) {
      _laporanList[idx].isSelesai = !_laporanList[idx].isSelesai;
      notifyListeners();
    }
  }

  int jumlahPerKategori(String kategori) {
    return _laporanList.where((l) => l.kategori == kategori).length;
  }
}
