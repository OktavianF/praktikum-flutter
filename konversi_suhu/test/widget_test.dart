import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:konversi_suhu/main.dart';
import 'package:konversi_suhu/models/suhu_converter.dart';

// ─── Unit Tests: Logika konversi ───

void main() {
  group('SuhuConverter', () {
    test('Celsius 100 → Fahrenheit 212, Kelvin 373.15, Reamur 80', () {
      final h = SuhuConverter.konversi(100, SatuanSuhu.celsius);
      expect(h.celsius, 100.0);
      expect(h.fahrenheit, 212.0);
      expect(h.kelvin, 373.15);
      expect(h.reamur, 80.0);
    });

    test('Celsius 0 → Fahrenheit 32, Kelvin 273.15, Reamur 0', () {
      final h = SuhuConverter.konversi(0, SatuanSuhu.celsius);
      expect(h.celsius, 0.0);
      expect(h.fahrenheit, 32.0);
      expect(h.kelvin, 273.15);
      expect(h.reamur, 0.0);
    });

    test('Fahrenheit 212 → Celsius 100', () {
      final h = SuhuConverter.konversi(212, SatuanSuhu.fahrenheit);
      expect(h.celsius, closeTo(100.0, 0.01));
      expect(h.kelvin, closeTo(373.15, 0.01));
      expect(h.reamur, closeTo(80.0, 0.01));
    });

    test('Kelvin 273.15 → Celsius 0', () {
      final h = SuhuConverter.konversi(273.15, SatuanSuhu.kelvin);
      expect(h.celsius, closeTo(0.0, 0.01));
      expect(h.fahrenheit, closeTo(32.0, 0.01));
      expect(h.reamur, closeTo(0.0, 0.01));
    });

    test('Reamur 80 → Celsius 100', () {
      final h = SuhuConverter.konversi(80, SatuanSuhu.reamur);
      expect(h.celsius, closeTo(100.0, 0.01));
      expect(h.fahrenheit, closeTo(212.0, 0.01));
      expect(h.kelvin, closeTo(373.15, 0.01));
    });

    test('Nilai negatif: Celsius -40 → Fahrenheit -40', () {
      final h = SuhuConverter.konversi(-40, SatuanSuhu.celsius);
      expect(h.fahrenheit, closeTo(-40.0, 0.01));
    });
  });

  // ─── Widget Tests: UI ───

  group('Widget Tests', () {
    testWidgets('Tampil elemen utama', (tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('Konversi Suhu'), findsOneWidget);
      expect(find.text('Masukkan Suhu'), findsOneWidget);
      expect(find.text('Satuan Input'), findsOneWidget);
      expect(find.text('Konversi'), findsOneWidget);
      expect(find.text('Masukkan suhu dan tekan Konversi'), findsOneWidget);
    });

    testWidgets('Konversi 100 Celsius menampilkan hasil', (tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField), '100');
      await tester.tap(find.text('Konversi'));
      await tester.pump();

      expect(find.text('212.00'), findsOneWidget);
      expect(find.text('373.15'), findsOneWidget);
      expect(find.text('80.00'), findsOneWidget);
      expect(find.text('100.00'), findsOneWidget);
    });

    testWidgets('Input kosong tidak crash', (tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Konversi'));
      await tester.pump();

      // Masih menampilkan placeholder, tidak crash
      expect(find.text('Masukkan suhu dan tekan Konversi'), findsOneWidget);
    });
  });
}
