import 'package:flutter_test/flutter_test.dart';
import 'package:konversi_suhu/models/suhu_converter.dart';

void main() {
  group('SuhuConverter', () {
    test('konversi dari Celsius ke semua satuan dengan benar', () {
      final hasil = SuhuConverter.konversi(100, SatuanSuhu.celsius);
      
      expect(hasil.celsius, 100);
      expect(hasil.fahrenheit, 212);
      expect(hasil.kelvin, 373.15);
      expect(hasil.reamur, 80);
    });

    test('konversi dari Fahrenheit ke semua satuan dengan benar', () {
      final hasil = SuhuConverter.konversi(212, SatuanSuhu.fahrenheit);
      
      expect(hasil.celsius, 100);
      expect(hasil.fahrenheit, 212);
      expect(hasil.kelvin, 373.15);
      expect(hasil.reamur, 80);
    });

    test('konversi dari Kelvin ke semua satuan dengan benar', () {
      final hasil = SuhuConverter.konversi(373.15, SatuanSuhu.kelvin);
      
      expect((hasil.celsius * 100).round() / 100, 100); 
    });

    test('konversi dari Reamur ke semua satuan dengan benar', () {
      final hasil = SuhuConverter.konversi(80, SatuanSuhu.reamur);
      
      expect(hasil.celsius, 100);
    });
  });
}
