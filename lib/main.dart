import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/laporan_model.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LaporanModel(),
      child: MaterialApp(
        title: 'Bantuin - Smart City Public Service',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.beranda,
        routes: AppRoutes.daftarRoute(),
        onGenerateRoute: AppRoutes.bentukRoute,
        onUnknownRoute: AppRoutes.routeTidakDikenal,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
