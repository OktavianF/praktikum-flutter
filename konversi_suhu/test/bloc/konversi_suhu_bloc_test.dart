import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konversi_suhu/bloc/konversi_suhu_bloc.dart';
import 'package:konversi_suhu/bloc/konversi_suhu_event.dart';
import 'package:konversi_suhu/bloc/konversi_suhu_state.dart';
import 'package:konversi_suhu/models/suhu_converter.dart';

void main() {
  group('KonversiSuhuBloc', () {
    late KonversiSuhuBloc bloc;

    setUp(() {
      bloc = KonversiSuhuBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is KonversiSuhuState()', () {
      expect(bloc.state, const KonversiSuhuState());
    });

    blocTest<KonversiSuhuBloc, KonversiSuhuState>(
      'emits [KonversiSuhuState] with new satuanTerpilih when UbahSatuanSuhu is added',
      build: () => bloc,
      act: (bloc) => bloc.add(const UbahSatuanSuhu(SatuanSuhu.fahrenheit)),
      expect: () => <KonversiSuhuState>[
        const KonversiSuhuState(
          satuanTerpilih: SatuanSuhu.fahrenheit,
          errorMessage: '',
        )
      ],
    );

    blocTest<KonversiSuhuBloc, KonversiSuhuState>(
      'emits error when HitungKonversiSuhu is added with empty input',
      build: () => bloc,
      act: (bloc) => bloc.add(const HitungKonversiSuhu('')),
      expect: () => <KonversiSuhuState>[
        const KonversiSuhuState(
          errorMessage: 'Input suhu tidak boleh kosong',
        )
      ],
    );

    blocTest<KonversiSuhuBloc, KonversiSuhuState>(
      'emits error when HitungKonversiSuhu is added with invalid input',
      build: () => bloc,
      act: (bloc) => bloc.add(const HitungKonversiSuhu('abc')),
      expect: () => <KonversiSuhuState>[
        const KonversiSuhuState(
          errorMessage: 'Input suhu harus berupa angka',
        )
      ],
    );

    blocTest<KonversiSuhuBloc, KonversiSuhuState>(
      'emits valid HasilKonversi when HitungKonversiSuhu is added with valid input',
      build: () => bloc,
      act: (bloc) => bloc.add(const HitungKonversiSuhu('100')),
      expect: () => <KonversiSuhuState>[
        KonversiSuhuState(
          hasilKonversi: SuhuConverter.konversi(100, SatuanSuhu.celsius),
          errorMessage: '',
        )
      ],
    );
  });
}
