import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/laporan_model.dart';

class BerandaLaporanPage extends StatelessWidget {
  const BerandaLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final laporanList = context.watch<LaporanModel>().laporanList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bantuin: Aduan Warga'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_comment),
        label: const Text('Lapor Masalah'),
        onPressed: () {
          Navigator.pushNamed(context, '/buat-laporan');
        },
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            color: Colors.indigo.shade50,
            child: Row(
              children: [
                const Icon(Icons.campaign, color: Colors.indigo, size: 30),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Total ${laporanList.length} laporan warga tercatat. Ketuk kartu untuk detail, tekan lama untuk update status tindak lanjut.',
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: laporanList.length,
              itemBuilder: (context, index) {
                final item = laporanList[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(item.judul),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${item.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('Kategori: ${item.kategori}'),
                            Text('Urgensi: ${item.urgensi}'),
                            const SizedBox(height: 8),
                            Text('Keterangan:\n${item.deskripsi}'),
                            const SizedBox(height: 8),
                            Text(
                              'Status: ${item.isSelesai ? "Selesai Ditangani" : "Sedang Ditangani"}',
                              style: TextStyle(
                                color: item.isSelesai ? Colors.green : Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup')),
                        ],
                      ),
                    );
                  },
                  onLongPress: () {
                    context.read<LaporanModel>().toggleStatus(item.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Status laporan ${item.id} berhasil diperbarui!'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: item.isSelesai ? Colors.green.shade300 : Colors.indigo.shade100,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: item.urgensi == 'Mendesak'
                            ? Colors.redAccent
                            : Colors.indigo,
                        foregroundColor: Colors.white,
                        child: Icon(
                          item.kategori == 'Sampah'
                              ? Icons.delete_outline
                              : item.kategori == 'Jalan Rusak'
                                  ? Icons.warning_amber
                                  : Icons.report_problem,
                        ),
                      ),
                      title: Text(
                        item.judul,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      subtitle: Text(
                        '${item.kategori} • Urgensi: ${item.urgensi}\nKetuk: Detail | Tahan: Ubah Status',
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: Chip(
                        label: Text(
                          item.isSelesai ? 'Selesai' : 'Proses',
                          style: TextStyle(
                            fontSize: 11,
                            color: item.isSelesai ? Colors.white : Colors.indigo.shade900,
                          ),
                        ),
                        backgroundColor:
                            item.isSelesai ? Colors.green : Colors.indigo.shade50,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
