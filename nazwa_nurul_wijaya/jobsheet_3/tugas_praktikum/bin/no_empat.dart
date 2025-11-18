Function hitungDiskon() {
  var diskon = 0;

  return (int harga) {
    diskon += 5;
    var potongan = harga * diskon ~/ 100;
    var hargaAkhir = harga - potongan;
    print('Diskon $diskon% → Harga setelah diskon: $hargaAkhir');
  };
}

void main() { 
  var diskonBertingkat = hitungDiskon();

  diskonBertingkat(100000); // panggilan 1 → diskon 5%
  diskonBertingkat(100000); // panggilan 2 → diskon 10%
  diskonBertingkat(100000); // panggilan 3 → diskon 15%
}
