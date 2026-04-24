import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/konversi_suhu_bloc.dart';
import '../bloc/konversi_suhu_event.dart';
import '../bloc/konversi_suhu_state.dart';
import '../models/suhu_converter.dart';
import '../widgets/hasil_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  void _konversi() {
    context.read<KonversiSuhuBloc>().add(HitungKonversiSuhu(_controller.text));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Suhu'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInput(),
            const SizedBox(height: 20),
            _buildDropdown(),
            const SizedBox(height: 20),
            _buildKonversiButton(),
            const SizedBox(height: 20),
            _buildHasil(),
          ],
        ),
      ),
    );
  }

  Widget _buildInput() {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Masukkan Suhu',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.thermostat),
      ),
    );
  }

  Widget _buildDropdown() {
    return BlocBuilder<KonversiSuhuBloc, KonversiSuhuState>(
      buildWhen: (previous, current) =>
          previous.satuanTerpilih != current.satuanTerpilih,
      builder: (context, state) {
        return InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Satuan Input',
            border: OutlineInputBorder(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SatuanSuhu>(
              isDense: true,
              value: state.satuanTerpilih,
              items: SatuanSuhu.values
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(SuhuConverter.labels[s]!),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<KonversiSuhuBloc>().add(UbahSatuanSuhu(value));
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildKonversiButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _konversi,
        child: const Text(
          'Konversi',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildHasil() {
    return BlocBuilder<KonversiSuhuBloc, KonversiSuhuState>(
      builder: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final hasil = state.hasilKonversi;
        if (hasil == null) {
          return const Expanded(
            child: Center(
              child: Text('Masukkan suhu dan tekan Konversi'),
            ),
          );
        }

        return Expanded(
          child: ListView(
            children: [
              HasilCard(nama: 'Celsius (°C)', nilai: hasil.celsius),
              HasilCard(nama: 'Fahrenheit (°F)', nilai: hasil.fahrenheit),
              HasilCard(nama: 'Kelvin (K)', nilai: hasil.kelvin),
              HasilCard(nama: 'Reamur (°R)', nilai: hasil.reamur),
            ],
          ),
        );
      },
    );
  }
}
