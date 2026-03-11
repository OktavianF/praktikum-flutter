import 'package:flutter/material.dart';

class HasilCard extends StatelessWidget {
  final String nama;
  final double nilai;

  const HasilCard({
    super.key,
    required this.nama,
    required this.nilai,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.thermostat),
        title: Text(nama),
        trailing: Text(
          nilai.toStringAsFixed(2),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
