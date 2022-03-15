import 'package:flutter/material.dart';
import 'package:flutter_vpn_client/modules/location_menu.dart';

class LocationMenu extends StatefulWidget {
  const LocationMenu({Key? key}) : super(key: key);

  @override
  State<LocationMenu> createState() => _LocationMenuState();
}

class _LocationMenuState extends State<LocationMenu> with Servers {
  late Map? serverList;

  @override
  void initState() async {
    super.initState();
    serverList = await loadServers();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(),
    );
  }
}
