# Program-Struktur-Data-
# Program Manajemen Keuangan Organisasi Desa

Program berbasis Command Line Interface (CLI) menggunakan bahasa pemrograman **Dart** untuk mengelola transaksi keuangan organisasi masyarakat desa. Program ini mengimplementasikan konsep **Struktur Data** dan **Object-Oriented Programming (OOP)**.

---

## Struktur Data yang Digunakan

### 1. Linked List
Struktur data utama program. Setiap transaksi disimpan dalam node yang saling terhubung melalui pointer `next`. Operasi yang diimplementasikan:
- **Insert at Tail** — menambah transaksi baru di ekor list
- **Delete Node** — menghapus transaksi berdasarkan ID
- **Traversal** — menelusuri seluruh node untuk menampilkan laporan

### 2. Map
Digunakan untuk menyimpan daftar kategori transaksi dalam format key-value:
```
'1' → 'Iuran Warga'
'2' → 'Bantuan Sosial'
'3' → 'Operasional/ATK'
'4' → 'Infrastruktur'
'5' → 'Lain-lain'
```

### 3. Linear Search
Algoritma pencarian yang menelusuri setiap node satu per satu dari HEAD hingga null. Pencarian dilakukan pada tiga field sekaligus: `keterangan`, `kategori`, dan `jenis` transaksi. Kompleksitas: **O(n)**.

### 4. Bubble Sort
Algoritma pengurutan yang membandingkan dua node berdampingan dan menukar DATA-nya jika nilai `jumlah` kiri lebih besar dari kanan. Proses diulang hingga tidak ada pertukaran. Kompleksitas: **O(n²)**.

---

## Fitur Program

| Menu | Fitur | Keterangan |
|------|-------|------------|
| 1 | Tambah Transaksi | Menambah pemasukan atau pengeluaran baru |
| 2 | Lihat Laporan | Menampilkan seluruh transaksi beserta total dan saldo |
| 3 | Hapus Transaksi | Menghapus transaksi berdasarkan ID |
| 4 | Cari Transaksi | Mencari transaksi berdasarkan kata kunci |
| 5 | Urutkan (Bubble Sort) | Mengurutkan transaksi dari jumlah terkecil ke terbesar |
| 6 | Keluar | Keluar dari program |

---

## Struktur File

```
Program-Struktur-Data/
├── main.dart         → Tampilan menu CLI dan penanganan input user
├── oop.dart          → Definisi class Transaksi, Pemasukan, Pengeluaran, TransaksiNode
├── program.dart      → Logika bisnis: linked list, linear search, bubble sort
├── helper/
│   └── helper.dart   → Fungsi utilitas: format rupiah dan kolom tabel
└── Keuangan_Desa.csv → File penyimpanan data transaksi (auto-generate)
```

---


## Cara Menjalankan Program

### Prasyarat
Pastikan **Dart SDK** sudah terinstall di komputer kamu.
Cek dengan perintah:
```bash
dart --version
```
Jika belum, download di: https://dart.dev/get-dart

### Langkah Menjalankan

**1. Clone repository ini:**
```bash
git clone https://github.com/Baktiar28-code/Program-Struktur-Data.git
```

**2. Masuk ke folder project:**
```bash
cd Program-Struktur-Data
```

**3. Jalankan program:**
```bash
dart main.dart
```

**4. Tampilan menu akan muncul:**
```
  =========================================
    KEUANGAN ORGANISASI DESA
  =========================================
  1. Tambah Transaksi
  2. Lihat Laporan
  3. Hapus Transaksi
  4. Cari Transaksi
  5. Urutkan (Bubble Sort)
  6. Keluar
  =========================================
  Pilih menu (1-6):
```

---

## Contoh Penggunaan

**Menambah Transaksi:**
```
Pilih menu: 1
Jenis: 1 (Pemasukan)
Kategori: 1 (Iuran Warga)
Tanggal: 18-06-2026
Keterangan: Iuran bulanan warga RT 03
Jumlah: 1500000
→ [Sukses] Transaksi berhasil dicatat!
```

**Mencari Transaksi:**
```
Pilih menu: 4
Kata kunci: infrastruktur
→ Menampilkan semua transaksi dengan kategori Infrastruktur
```

**Mengurutkan Transaksi:**
```
Pilih menu: 5
→ [Sukses] Data diurutkan dari terkecil ke terbesar.
```

---

## Persistensi Data

Data transaksi disimpan secara otomatis ke file `Keuangan_Desa.csv` setiap kali ada perubahan (tambah, hapus, urutkan). File ini juga dimuat otomatis saat program pertama kali dijalankan sehingga data tidak hilang setelah program ditutup.

Format CSV:
```
ID,Tanggal,Kategori,Keterangan,Jenis,Jumlah (Rp)
1,01-06-2025,Iuran Warga,Iuran bulanan warga RT 01,Pemasukan,1500000
...
Total Pemasukan,,,,,7000000
Total Pengeluaran,,,,,5100000
Saldo Akhir Kas,,,,,1900000
```

---

Project ini dibuat untuk keperluan tugas akhir praktikum mata kuliah **Struktur Data**.
