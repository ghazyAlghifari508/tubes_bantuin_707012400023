import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tubes_bantuin_707012400023/model/laporan_model.dart';
import 'package:tubes_bantuin_707012400023/navigation/app_routes.dart';

void main() {
  testWidgets('Test navigasi dan halaman utama Tubes Bantuin',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => LaporanModel(),
        child: MaterialApp(
          initialRoute: AppRoutes.beranda,
          routes: AppRoutes.daftarRoute(),
        ),
      ),
    );

    expect(find.text('Bantuin: Aduan Warga'), findsOneWidget);
    expect(find.text('Lapor Masalah'), findsOneWidget);
  });
}
