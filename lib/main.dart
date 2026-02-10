import 'package:flutter/material.dart';
// import 'ui/screens/ride_pref/ride_pref_screen.dart';
// import 'ui/theme/theme.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: appTheme,
//       home: Scaffold(body: RidePrefScreen()),
//     );
//   }
// }

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorTap(type: CardType.red),
        ColorTap(type: CardType.blue),
        ColorTap(type: CardType.blue),
      ],
    );
  }
}

class ColorTap extends StatefulWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  @override
  ColorTapState createState() => ColorTapState();
}

class ColorTapState extends State<ColorTap> {
  int tapCount = 0;

  Color get backgroundColor =>
      widget.type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tapCount++;
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
