  String rupiah(double angka) {
    String r = angka.toStringAsFixed(0);
    String hasil = '';
    int hitung = 0;
    for (int i = r.length - 1; i >= 0; i--) {
      if (hitung > 0 && hitung % 3 == 0) hasil = '.$hasil';
      hasil = '${r[i]}$hasil';
      hitung++;
    }
    return hasil;
  }

  String kol(String teks, int lebar) =>
      teks.length > lebar ? '${teks.substring(0, lebar - 2)}..' : teks.padRight(lebar);

      
