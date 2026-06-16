abstract class Transaksi {
  final int id;
  final String tanggal;
  final String keterangan;
  final String kategori;
  final String jenis; 
  final double jumlah;

  Transaksi({
    required this.id,
    required this.tanggal,
    required this.keterangan,
    required this.kategori,
    required this.jenis,
    required this.jumlah,
  });

  // Ubah data menjadi 1 baris CSV
  String keCsv() => '$id,$tanggal,$kategori,$keterangan,$jenis,${jumlah.toStringAsFixed(0)}';
}

// SUBCLASS: Inheritance dari Transaksi
class Pemasukan extends Transaksi {
  Pemasukan({required super.id, required super.tanggal, required super.keterangan, required super.kategori, required super.jumlah})
      : super(jenis: 'Pemasukan');
}

class Pengeluaran extends Transaksi {
  Pengeluaran({required super.id, required super.tanggal, required super.keterangan, required super.kategori, required super.jumlah})
      : super(jenis: 'Pengeluaran');
}

// NODE untuk LINKED LIST 
class TransaksiNode {
  Transaksi data;      
  TransaksiNode? next;  
  TransaksiNode(this.data);
}
