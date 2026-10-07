import 'package:flutter/material.dart';
import '../pages/form_laporan_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String buatLaporan = '/buat-laporan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      buatLaporan: (context) => const FormLaporanPage(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
        body: Center(child: Text('Rute ${settings.name} tidak dikenali.')),
      ),
    );
  }
}
