import 'package:equatable/equatable.dart';

import '../models/suhu_converter.dart';

class KonversiSuhuState extends Equatable {
  final SatuanSuhu satuanTerpilih;
  final HasilKonversi? hasilKonversi;
  final String errorMessage;

  const KonversiSuhuState({
    this.satuanTerpilih = SatuanSuhu.celsius,
    this.hasilKonversi,
    this.errorMessage = '',
  });

  KonversiSuhuState copyWith({
    SatuanSuhu? satuanTerpilih,
    HasilKonversi? hasilKonversi,
    String? errorMessage,
    bool clearHasil = false,
  }) {
    return KonversiSuhuState(
      satuanTerpilih: satuanTerpilih ?? this.satuanTerpilih,
      hasilKonversi: clearHasil ? null : (hasilKonversi ?? this.hasilKonversi),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [satuanTerpilih, hasilKonversi, errorMessage];
}
