import 'package:equatable/equatable.dart';

import '../models/suhu_converter.dart';

sealed class KonversiSuhuEvent extends Equatable {
  const KonversiSuhuEvent();

  @override
  List<Object> get props => [];
}

class UbahSatuanSuhu extends KonversiSuhuEvent {
  final SatuanSuhu satuanSuhu;

  const UbahSatuanSuhu(this.satuanSuhu);

  @override
  List<Object> get props => [satuanSuhu];
}

class HitungKonversiSuhu extends KonversiSuhuEvent {
  final String inputSuhu;

  const HitungKonversiSuhu(this.inputSuhu);

  @override
  List<Object> get props => [inputSuhu];
}
