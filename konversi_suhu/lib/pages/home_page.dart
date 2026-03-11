import 'package:flutter/material.dart';

import '../models/suhu_converter.dart';
import '../widgets/hasil_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  SatuanSuhu _satuanInput = SatuanSuhu.celsius;
  HasilKonversi? _hasil;

  void _konversi() {
    if (_controller.text.isEmpty) return;

    final input = double.tryParse(_controller.text);
    if (input == null) return;

    setState(() {
      _hasil = SuhuConverter.konversi(input, _satuanInput);
    });
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
    return DropdownButtonFormField<SatuanSuhu>(
      initialValue: _satuanInput,
      decoration: const InputDecoration(
        labelText: 'Satuan Input',
        border: OutlineInputBorder(),
      ),
      items: SatuanSuhu.values
          .map((s) => DropdownMenuItem(
                value: s,
                child: Text(SuhuConverter.labels[s]!),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => _satuanInput = value);
        }
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
    final hasil = _hasil;
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
  }
}
