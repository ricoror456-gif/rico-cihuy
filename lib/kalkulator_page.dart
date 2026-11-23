import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  final TextEditingController angkaA = TextEditingController();
  final TextEditingController angkaB = TextEditingController();

  String hasil = "0";

  void hitung(String operator) {
    if (angkaA.text.isEmpty || angkaB.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Masukkan kedua angka terlebih dahulu"),
        ),
      );
      return;
    }

    double a = double.parse(angkaA.text);
    double b = double.parse(angkaB.text);

    double total = 0;

    switch (operator) {
      case "+":
        total = a + b;
        break;

      case "-":
        total = a - b;
        break;

      case "×":
        total = a * b;
        break;

      case "÷":
        if (b == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Tidak bisa membagi dengan nol"),
            ),
          );
          return;
        }
        total = a / b;
        break;
    }

    setState(() {
      hasil = total.toString();
    });
  }

  void reset() {
    angkaA.clear();
    angkaB.clear();

    setState(() {
      hasil = "0";
    });
  }

  Widget tombolOperator(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(60, 45),
        ),
        onPressed: () => hitung(text),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: angkaA,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Angka A",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: angkaB,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Angka B",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                tombolOperator("+"),
                tombolOperator("-"),
                tombolOperator("×"),
                tombolOperator("÷"),

              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: reset,
              icon: const Icon(Icons.refresh),
              label: const Text("Reset"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 40),

            Text(
              "Hasil : $hasil",
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Halaman pemain belum dibuat"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text("Lihat Pemain"),
            ),

          ],
        ),
      ),
    );
  }
}