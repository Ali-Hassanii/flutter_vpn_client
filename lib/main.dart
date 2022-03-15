import 'package:flutter/material.dart';
import 'package:flutter_vpn_client/screens/route.dart';

void main() => runApp(const Manager());

class Manager extends StatelessWidget {
  const Manager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vpn client',
      theme: ThemeData(
        fontFamily: 'comfortaa',
        colorScheme: const ColorScheme.light(
          primary: Colors.deepPurpleAccent,
          onPrimary: Colors.white,
          onSurface: Colors.white,
          background: Colors.blueAccent,
        ),
      ),
      initialRoute: '/Home',
      routes: {
        '/Home': (context) => const Home(),
        '/LocationMenu': (context) => const LocationMenu(),
      },
    );
  }
}
