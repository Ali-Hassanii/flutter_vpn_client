import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_vpn_client/modules/location_menu.dart';

class LocationMenu extends StatefulWidget with StoreServers {
  LocationMenu({Key? key}) : super(key: key);

  final StoreServers storage = StoreServers();

  @override
  State<LocationMenu> createState() => _LocationMenuState();
}

class _LocationMenuState extends State<LocationMenu> {
  static const Color onPrimaryColor = Colors.white60;
  late Object serversList;

  // A simple widget
  Widget showInfo = Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.location_off,
          size: 40,
          color: onPrimaryColor,
        ),
        SizedBox(height: 20),
        Text(
            'You have not added server yet',
          style: TextStyle(
            color: onPrimaryColor,
          ),
        )
      ],
    ),
  );

  void _loadServers() {
    widget.storage.loadServers().then((data) {
      if (data.isNotEmpty) {
        setState(() {
          showInfo = ListView(
            children: data.map((obj) {
              Map dObj = jsonDecode(obj);
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                child: Card(
                  color: Colors.cyanAccent,
                  child: ListTile(
                    title: Text(dObj['name']),
                    subtitle: Text(dObj['address']),
                    onTap: () {},
                  ),
                ),
              );
            }).toList(),
          );
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadServers();
  }

  final Map inputInfo = {};

  @override
  Widget build(BuildContext context) {
    //
    // the build() function
    //
    return Scaffold(
        body: Container(
          child: showInfo,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue,
                    Colors.deepPurple,
                  ]
              )
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_location_outlined, size: 30,),
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: const Color.fromRGBO(0, 144, 255, 1.0),
              title: const Text(
                  'New server info:',
                style: TextStyle(
                  color: onPrimaryColor,
                ),
              ),
              content: SizedBox(
                height: 190,
                width: 150,
                child: Form(
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: onPrimaryColor,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                        onChanged: (name) {
                          inputInfo['name'] = name;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Address',
                            labelStyle: TextStyle(
                              color: onPrimaryColor,
                            ),
                          floatingLabelStyle: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                        onChanged: (address) {
                          inputInfo['address'] = address;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'UserName',
                            labelStyle: TextStyle(
                              color: onPrimaryColor,
                            ),
                          floatingLabelStyle: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                        onChanged: (username) {
                          inputInfo['username'] = username;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                            labelStyle: TextStyle(
                              color: onPrimaryColor,
                            ),
                          floatingLabelStyle: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                        onChanged: (password) {
                          inputInfo['password'] = password;
                        },
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                        'Cancel',
                      style: TextStyle(
                          color: onPrimaryColor
                      ),
                    )),
                TextButton(
                  onPressed: () async {
                    await widget.storage.addServer(inputInfo);
                    setState(() => _loadServers());
                    Navigator.pop(context);
                  },
                  child: const Text(
                      'OK',
                    style: TextStyle(
                      color: onPrimaryColor
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
