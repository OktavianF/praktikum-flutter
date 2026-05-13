import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/konversi_suhu_bloc.dart';
import '../bloc/konversi_suhu_event.dart';
import '../bloc/konversi_suhu_state.dart';
import '../models/suhu_converter.dart';
import '../widgets/hasil_card.dart';
import '../services/auth_service.dart';

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
        title: const Text(
          'Konversi Suhu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.deepPurple),
            onPressed: () async {
              await AuthService().signOut();
            },
          ),
          const SizedBox(width: 10),
        ],
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
      decoration: InputDecoration(
        labelText: 'Masukkan Suhu',
        labelStyle: GoogleFonts.poppins(color: Colors.black54),
        prefixIcon: const Icon(Icons.thermostat_outlined, color: Colors.deepPurple),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildDropdown() {
    return BlocBuilder<KonversiSuhuBloc, KonversiSuhuState>(
      buildWhen: (previous, current) =>
          previous.satuanTerpilih != current.satuanTerpilih,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SatuanSuhu>(
              isExpanded: true,
              value: state.satuanTerpilih,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.deepPurple),
              items: SatuanSuhu.values
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(
                          SuhuConverter.labels[s]!,
                          style: GoogleFonts.poppins(),
                        ),
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
      height: 55,
      child: ElevatedButton(
        onPressed: _konversi,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Konversi Sekarang',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
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
                style: GoogleFonts.poppins(color: Colors.redAccent, fontWeight: FontWeight.w500),
              ),
            ),
          );
        }

        final hasil = state.hasilKonversi;
        if (hasil == null) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.query_stats_rounded, size: 60, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  Text(
                    'Masukkan suhu dan tekan Konversi',
                    style: GoogleFonts.poppins(color: Colors.black38),
                  ),
                ],
              ),
            ),
          );
        }

        return Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 10),
            children: [
              Text(
                'Hasil Konversi',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
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
