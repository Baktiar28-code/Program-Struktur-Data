import 'dart:io';
import 'oop.dart';
import 'helper/helper.dart';

class ManajemenKeuangan {
  TransaksiNode? _head;
  int _nextId = 1;
  final String _namaFile = 'Keuangan_Desa.csv';

  final Map<String, String> kategori = {
    '1': 'Iuran Warga',
    '2': 'Bantuan Sosial',
    '3': 'Operasional/ATK',
    '4': 'Infrastruktur',
    '5': 'Lain-lain',
  };

  ManajemenKeuangan() {
    _loadCsv();
  }

  // ══════════════════════════════════════════════════════════
  // TAMBAH TRANSAKSI — Insert at Tail Linked List
  // ══════════════════════════════════════════════════════════
  void tambah(
    String tanggal,
    String ket,
    String kodeKat,
    String jenis,
    double jumlah,
  ) {
    String namaKat = kategori[kodeKat] ?? 'Lain-lain';

    // Polymorphism
    Transaksi t = (jenis == 'pemasukan')
        ? Pemasukan(
            id: _nextId,
            tanggal: tanggal,
            keterangan: ket,
            kategori: namaKat,
            jumlah: jumlah,
          )
        : Pengeluaran(
            id: _nextId,
            tanggal: tanggal,
            keterangan: ket,
            kategori: namaKat,
            jumlah: jumlah,
          );
    _nextId++;

    // Sisipkan node baru ke ekor linked list
    TransaksiNode node = TransaksiNode(t);
    if (_head == null) {
      _head = node; // list kosong → node jadi head
    } else {
      TransaksiNode cur = _head!;
      while (cur.next != null) cur = cur.next!; // traverse ke ekor
      cur.next = node; // sambungkan di ekor
    }

    print('\n  [Sukses] Transaksi berhasil dicatat!');
    _simpan();
  }

  // ══════════════════════════════════════════════════════════
  // HAPUS TRANSAKSI — Delete Node Linked List
  // ══════════════════════════════════════════════════════════
  void hapus(int id) {
    if (_head == null) {
      print('\n  [!] Data kosong.');
      return;
    }

    // Kasus 1: node yang dihapus adalah HEAD
    if (_head!.data.id == id) {
      _head = _head!.next;
      print('\n  [Sukses] Transaksi ID $id dihapus.');
      _simpan();
      return;
    }

    // Kasus 2: cari node sebelum target lalu bypass
    TransaksiNode? prev = _head;
    TransaksiNode? cur = _head!.next;
    while (cur != null) {
      if (cur.data.id == id) {
        prev!.next = cur.next; // putus sambungan ke node target
        print('\n  [Sukses] Transaksi ID $id dihapus.');
        _simpan();
        return;
      }
      prev = cur;
      cur = cur.next;
    }
    print('\n  [!] ID $id tidak ditemukan.');
  }

  // ══════════════════════════════════════════════════════════
  // TAMPILKAN LAPORAN — Traversal Linked List
  // ══════════════════════════════════════════════════════════
  void tampilkan() {
    if (_head == null) {
      print('\n  [!] Belum ada data.');
      return;
    }

    print('\n  ============================================================');
    print('       LAPORAN KEUANGAN ORGANISASI DESA');
    print('  ============================================================');
    print(
      '  ${kol("ID", 3)} | ${kol("Tanggal", 11)} | ${kol("Kategori", 16)} | ${kol("Keterangan", 20)} | ${kol("Jenis", 11)} | Jumlah (Rp)',
    );
    print(
      '  ---------------------------------------------------------------------',
    );

    TransaksiNode? cur = _head;
    double totalMasuk = 0, totalKeluar = 0;

    // Traverse dari HEAD ke TAIL
    while (cur != null) {
      Transaksi t = cur.data;
      print(
        '  ${kol(t.id.toString(), 3)} | ${kol(t.tanggal, 11)} | ${kol(t.kategori, 16)} | ${kol(t.keterangan, 20)} | ${kol(t.jenis, 11)} | ${rupiah(t.jumlah)}',
      );
      if (t is Pemasukan)
        totalMasuk += t.jumlah;
      else
        totalKeluar += t.jumlah;
      cur = cur.next;
    }

    print(
      '  ---------------------------------------------------------------------',
    );
    print('  Total Pemasukan   : Rp ${rupiah(totalMasuk)}');
    print('  Total Pengeluaran : Rp ${rupiah(totalKeluar)}');
    print('  Saldo Akhir       : Rp ${rupiah(totalMasuk - totalKeluar)}');
    print('  ============================================================');
  }

  // ══════════════════════════════════════════════════════════
  // CARI TRANSAKSI — Linear Search
  // ══════════════════════════════════════════════════════════
  void cari(String kunci) {
    if (_head == null) {
      print('\n  [!] Belum ada data.');
      return;
    }

    print('\n  === HASIL PENCARIAN: "$kunci" ===');
    bool ketemu = false;
    TransaksiNode? cur = _head;

    // Telusuri setiap node satu per satu dari HEAD ke TAIL
    while (cur != null) {
      Transaksi t = cur.data;
      bool cocok =
          t.keterangan.toLowerCase().contains(kunci.toLowerCase()) ||
          t.kategori.toLowerCase().contains(kunci.toLowerCase()) ||
          t.jenis.toLowerCase().contains(kunci.toLowerCase());
      if (cocok) {
        print(
          '  ID:${t.id} | ${t.tanggal} | ${t.kategori} | ${t.keterangan} | ${t.jenis} | Rp ${rupiah(t.jumlah)}',
        );
        ketemu = true;
      }
      cur = cur.next;
    }
    if (!ketemu) print('  Tidak ada data yang cocok.');
  }

  // ══════════════════════════════════════════════════════════
  // URUTKAN — Bubble Sort pada Linked List
  // ══════════════════════════════════════════════════════════
  void urutkan() {
    if (_head == null || _head!.next == null) return;

    bool adaTukar;
    do {
      adaTukar = false;
      TransaksiNode? cur = _head;

      // Bandingkan 2 node berdampingan
      while (cur?.next != null) {
        if (cur!.data.jumlah > cur.next!.data.jumlah) {
          // Tukar DATA di dalam node (bukan pointer-nya)
          Transaksi temp = cur.data;
          cur.data = cur.next!.data;
          cur.next!.data = temp;
          adaTukar = true;
        }
        cur = cur.next;
      }
    } while (adaTukar); // ulangi sampai tidak ada pertukaran

    print('\n  [Sukses] Data diurutkan dari terkecil ke terbesar.');
    _simpan();
  }

  void _simpan() {
    final buffer = StringBuffer();
    buffer.writeln('ID,Tanggal,Kategori,Keterangan,Jenis,Jumlah (Rp)');

    TransaksiNode? cur = _head;
    double totalMasuk = 0, totalKeluar = 0;
    while (cur != null) {
      buffer.writeln(cur.data.keCsv());
      if (cur.data is Pemasukan)
        totalMasuk += cur.data.jumlah;
      else
        totalKeluar += cur.data.jumlah;
      cur = cur.next;
    }

    // Ringkasan di bagian bawah CSV
    buffer.writeln('');
    buffer.writeln('Total Pemasukan,,,,,${totalMasuk.toStringAsFixed(0)}');
    buffer.writeln('Total Pengeluaran,,,,,${totalKeluar.toStringAsFixed(0)}');
    buffer.writeln(
      'Saldo Akhir Kas,,,,,${(totalMasuk - totalKeluar).toStringAsFixed(0)}',
    );

    File(_namaFile).writeAsStringSync(buffer.toString());
    print('  [Auto-Save] Tersimpan ke "$_namaFile"');
  }

  void _loadCsv() {
    final file = File(_namaFile);
    if (!file.existsSync()) return;

    int maxId = 0;
    for (String baris in file.readAsLinesSync().skip(1)) {
      final k = baris.split(',');
      if (k.length < 6 || !RegExp(r'^\d+$').hasMatch(k[0].trim())) continue;

      int id = int.parse(k[0].trim());
      Transaksi t = (k[4].trim() == 'Pemasukan')
          ? Pemasukan(
              id: id,
              tanggal: k[1].trim(),
              keterangan: k[3].trim(),
              kategori: k[2].trim(),
              jumlah: double.parse(k[5].trim()),
            )
          : Pengeluaran(
              id: id,
              tanggal: k[1].trim(),
              keterangan: k[3].trim(),
              kategori: k[2].trim(),
              jumlah: double.parse(k[5].trim()),
            );

      // Sisipkan ke ekor linked list
      TransaksiNode node = TransaksiNode(t);
      if (_head == null) {
        _head = node;
      } else {
        TransaksiNode cur = _head!;
        while (cur.next != null) cur = cur.next!;
        cur.next = node;
      }
      if (id > maxId) maxId = id;
    }
    if (maxId > 0) {
      _nextId = maxId + 1;
      print('  [Load] Data berhasil dimuat dari "$_namaFile"');
    }
  }
}
