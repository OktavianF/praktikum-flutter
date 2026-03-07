import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konversi Suhu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController controller = TextEditingController();

  String satuanInput = "Celsius";

  double c = 0;
  double f = 0;
  double k = 0;
  double r = 0;

  void konversi() {

    if(controller.text.isEmpty) return;

    double input = double.parse(controller.text);

    setState(() {

      switch (satuanInput) {

        case "Celsius":
          c = input;
          f = (c * 9/5) + 32;
          k = c + 273.15;
          r = c * 4/5;
          break;

        case "Fahrenheit":
          f = input;
          c = (f - 32) * 5/9;
          k = c + 273.15;
          r = c * 4/5;
          break;

        case "Kelvin":
          k = input;
          c = k - 273.15;
          f = (c * 9/5) + 32;
          r = c * 4/5;
          break;

        case "Reamur":
          r = input;
          c = r * 5/4;
          f = (c * 9/5) + 32;
          k = c + 273.15;
          break;

      }

    });
  }

  Widget hasil(String nama, double nilai) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.thermostat),
        title: Text(nama),
        trailing: Text(
          nilai.toStringAsFixed(2),
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Konversi Suhu"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Masukkan Suhu",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.thermostat),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(
              value: satuanInput,
              decoration: const InputDecoration(
                labelText: "Satuan Input",
                border: OutlineInputBorder(),
              ),

              items: const [

                DropdownMenuItem(
                  value: "Celsius",
                  child: Text("Celsius"),
                ),

                DropdownMenuItem(
                  value: "Fahrenheit",
                  child: Text("Fahrenheit"),
                ),

                DropdownMenuItem(
                  value: "Kelvin",
                  child: Text("Kelvin"),
                ),

                DropdownMenuItem(
                  value: "Reamur",
                  child: Text("Reamur"),
                ),

              ],

              onChanged: (value) {
                setState(() {
                  satuanInput = value!;
                });
              },

            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: konversi,
                child: const Text(
                  "Konversi",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(

                children: [

                  hasil("Celsius (°C)", c),
                  hasil("Fahrenheit (°F)", f),
                  hasil("Kelvin (K)", k),
                  hasil("Reamur (°R)", r),

                ],

              ),
            )

          ],
        ),
      ),
    );
  }
}