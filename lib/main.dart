
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const CalculatorPage(),
    );
  }
}

// ==========================================
// HALAMAN KALKULATOR
// ==========================================

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() =>
      _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController angkaAController =
      TextEditingController(text: '300');

  final TextEditingController angkaBController =
      TextEditingController(text: '200');

  String hasil = '60000';

  // FUNGSI HITUNG
  void hitung(String operator) {
    double? angkaA =
        double.tryParse(angkaAController.text);

    double? angkaB =
        double.tryParse(angkaBController.text);

    if (angkaA == null || angkaB == null) {
      setState(() {
        hasil = 'Input tidak valid';
      });
      return;
    }

    double result;

    switch (operator) {
      case '+':
        result = angkaA + angkaB;
        break;

      case '-':
        result = angkaA - angkaB;
        break;

      case '×':
        result = angkaA * angkaB;
        break;

      case '÷':
        if (angkaB == 0) {
          setState(() {
            hasil = 'Tidak bisa dibagi 0';
          });
          return;
        }

        result = angkaA / angkaB;
        break;

      default:
        return;
    }

    setState(() {
      hasil = result == result.truncateToDouble()
          ? result.toInt().toString()
          : result.toString();
    });
  }

  // FUNGSI RESET
  void reset() {
    setState(() {
      angkaAController.clear();
      angkaBController.clear();
      hasil = '0';
    });
  }

  // TOMBOL OPERASI
  Widget tombolOperasi(String simbol) {
    return SizedBox(
      width: 72,
      height: 46,
      child: OutlinedButton(
        onPressed: () {
          hitung(simbol);
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFF7F1F9),
          foregroundColor: const Color(0xFF65518A),
          side: const BorderSide(
            color: Color(0xFFE8E0EB),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          simbol,
          style: const TextStyle(
            fontSize: 19,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    angkaAController.dispose();
    angkaBController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FF),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // JUDUL KALKULATOR
              const Center(
                child: Text(
                  'Kalkulator',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF29252D),
                  ),
                ),
              ),

              const SizedBox(height: 38),

              // INPUT ANGKA A
              TextField(
                controller: angkaAController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Angka A',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 20,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // INPUT ANGKA B
              TextField(
                controller: angkaBController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Angka B',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 20,
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // TOMBOL OPERASI
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                children: [
                  tombolOperasi('+'),
                  tombolOperasi('-'),
                  tombolOperasi('×'),
                  tombolOperasi('÷'),
                ],
              ),

              const SizedBox(height: 24),

              // TOMBOL RESET
              Center(
                child: ElevatedButton.icon(
                  onPressed: reset,
                  icon: const Icon(
                    Icons.refresh,
                    size: 20,
                  ),
                  label: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF44336),
                    foregroundColor: Colors.white,
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // HASIL PERHITUNGAN
              Center(
                child: Text(
                  'Hasil : $hasil',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF211E24),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // TOMBOL LIHAT PEMAIN
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PlayersPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Lihat Pemain',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// HALAMAN LIST PLAYERS
// ==========================================

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  // WIDGET ITEM PEMAIN
  Widget playerItem(String nama, String posisi) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),

          // IKON BOLA
          leading: const Icon(
            Icons.sports_soccer,
            size: 25,
            color: Color(0xFF55515B),
          ),

          // NAMA PEMAIN
          title: Text(
            nama,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF29252D),
            ),
          ),

          // POSISI PEMAIN
          subtitle: Text(
            posisi,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF625D67),
            ),
          ),

          minVerticalPadding: 15,
        ),

        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFE7E0E8),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FF),

      // APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8FF),
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF29252D),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'List Players',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF29252D),
          ),
        ),

        titleSpacing: 8,
      ),

      // DAFTAR PEMAIN
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          playerItem('Messi', 'Striker'),
          playerItem('C. Ronaldo', 'Striker'),
        ],
      ),
    );
  }
}
