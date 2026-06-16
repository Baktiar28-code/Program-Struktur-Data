import 'dart:io';
import 'program.dart';

void main() {
  ManajemenKeuangan kas = ManajemenKeuangan();

  while (true) {
    print('\n  =========================================');
    print('    KEUANGAN ORGANISASI DESA');
    print('  =========================================');
    print('  1. Tambah Transaksi');
    print('  2. Lihat Laporan');
    print('  3. Hapus Transaksi');
    print('  4. Cari Transaksi');
    print('  5. Urutkan (Bubble Sort)');
    print('  6. Keluar');
    print('  =========================================');
    stdout.write('  Pilih menu (1-6): ');

    String? pilihan = stdin.readLineSync();

    switch (pilihan) {

      //  MENU 1: TAMBAH TRANSAKSI
      case '1':
        print('\n  -- JENIS TRANSAKSI --');
        print('  1. Pemasukan  2. Pengeluaran');
        stdout.write('  Pilih: ');
        String jenis = (stdin.readLineSync() == '2') ? 'pengeluaran' : 'pemasukan';

        print('\n  -- KATEGORI --');
        kas.kategori.forEach((k, v) => print('  $k. $v'));
        stdout.write('  Pilih kategori (1-5): ');
        String kodeKat = stdin.readLineSync() ?? '5';

        print('');
        stdout.write('  Tanggal (DD-MM-YYYY) : ');
        String tgl = _inputTanggal();

        stdout.write('  Keterangan           : ');
        String ket = _inputTeks();

        stdout.write('  Jumlah (Rp)          : ');
        double jml = _inputAngka();

        kas.tambah(tgl, ket, kodeKat, jenis, jml);
        break;

      // MENU 2: LIHAT LAPORAN 
      case '2':
        kas.tampilkan();
        break;

      //  MENU 3: HAPUS 
      case '3':
        kas.tampilkan();
        stdout.write('\n  Masukkan ID yang ingin dihapus: ');
        int? id = int.tryParse(stdin.readLineSync() ?? '');
        if (id != null) {
          stdout.write('  Yakin hapus ID $id? (y/n): ');
          if (stdin.readLineSync()?.toLowerCase() == 'y') kas.hapus(id);
        } else {
          print('  [!] ID tidak valid.');
        }
        break;

      //  MENU 4: CARI 
      case '4':
        stdout.write('\n  Kata kunci pencarian: ');
        String kunci = stdin.readLineSync() ?? '';
        if (kunci.isNotEmpty) kas.cari(kunci);
        break;

      //  MENU 5: URUTKAN 
      case '5':
        kas.urutkan();
        kas.tampilkan();
        break;

      // MENU 6: KELUAR
      case '6':
        print('\n  Terima kasih! Data tersimpan di Laporan_Keuangan_Desa.csv\n');
        exit(0);

      default:
        print('\n  [!] Pilihan tidak valid, masukkan angka 1-6.');
    }
  }
}



// Input teks tidak boleh kosong
String _inputTeks() {
  while (true) {
    String? val = stdin.readLineSync()?.trim();
    if (val != null && val.isNotEmpty) return val;
    stdout.write('  [!] Tidak boleh kosong, coba lagi: ');
  }
}

// Input angka harus lebih dari 0
double _inputAngka() {
  while (true) {
    double? val = double.tryParse(stdin.readLineSync() ?? '');
    if (val != null && val > 0) return val;
    stdout.write('  [!] Masukkan angka yang valid (> 0): ');
  }
}

// Input tanggal harus format DD-MM-YYYY
String _inputTanggal() {
  while (true) {
    String? val = stdin.readLineSync()?.trim();
    if (val != null && RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(val)) return val;
    stdout.write('  [!] Format salah, gunakan DD-MM-YYYY: ');
  }
}
