enum SatuanSuhu { celsius, fahrenheit, kelvin, reamur }

class HasilKonversi {
  final double celsius;
  final double fahrenheit;
  final double kelvin;
  final double reamur;

  const HasilKonversi({
    required this.celsius,
    required this.fahrenheit,
    required this.kelvin,
    required this.reamur,
  });
}

class SuhuConverter {
  static const Map<SatuanSuhu, String> labels = {
    SatuanSuhu.celsius: 'Celsius',
    SatuanSuhu.fahrenheit: 'Fahrenheit',
    SatuanSuhu.kelvin: 'Kelvin',
    SatuanSuhu.reamur: 'Reamur',
  };

  static double _toCelsius(double value, SatuanSuhu from) {
    return switch (from) {
      SatuanSuhu.celsius => value,
      SatuanSuhu.fahrenheit => (value - 32) * 5 / 9,
      SatuanSuhu.kelvin => value - 273.15,
      SatuanSuhu.reamur => value * 5 / 4,
    };
  }

  static HasilKonversi konversi(double input, SatuanSuhu from) {
    final c = _toCelsius(input, from);
    return HasilKonversi(
      celsius: c,
      fahrenheit: (c * 9 / 5) + 32,
      kelvin: c + 273.15,
      reamur: c * 4 / 5,
    );
  }
}
