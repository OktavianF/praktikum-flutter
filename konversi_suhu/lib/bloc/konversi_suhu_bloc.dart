import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/suhu_converter.dart';
import 'konversi_suhu_event.dart';
import 'konversi_suhu_state.dart';

class KonversiSuhuBloc extends Bloc<KonversiSuhuEvent, KonversiSuhuState> {
  KonversiSuhuBloc() : super(const KonversiSuhuState()) {
    on<UbahSatuanSuhu>((event, emit) {
      emit(state.copyWith(
        satuanTerpilih: event.satuanSuhu,
        clearHasil: true,
        errorMessage: '',
      ));
    });

    on<HitungKonversiSuhu>((event, emit) {
      if (event.inputSuhu.isEmpty) {
        emit(state.copyWith(
          errorMessage: 'Input suhu tidak boleh kosong',
          clearHasil: true,
        ));
        return;
      }

      final input = double.tryParse(event.inputSuhu);
      if (input == null) {
        emit(state.copyWith(
          errorMessage: 'Input suhu harus berupa angka',
          clearHasil: true,
        ));
        return;
      }

      final hasil = SuhuConverter.konversi(input, state.satuanTerpilih);
      emit(state.copyWith(
        hasilKonversi: hasil,
        errorMessage: '',
      ));
    });
  }
}
