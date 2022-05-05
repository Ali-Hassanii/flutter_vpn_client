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

  // Loading data from storage
  Future<void> _loadServers() async {
    List data = await widget.storage.loadServers();
    if (data.isNotEmpty) {
      setState(() => showInfo = _dataListShow(data, context));
    }
  }

  // Showing servers on screen by Card() widget
  Widget _dataListShow(List data, context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int _index) {
          Map item = jsonDecode(data[_index]);
          return Dismissible(
              key: Key(_index.toString()),

              // logics
              confirmDismiss: (DismissDirection direction) async {
                // for edit
                if (direction == DismissDirection.startToEnd) {
                  late bool isChanged;
                  return _inputForm(context, isEditing: true, info: item);
                  // for delete
                } else if (direction == DismissDirection.endToStart) {
                  return false;
                }
                return false;
              },

              // Edit a server info
              background: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.edit,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    'Edit',
                    style: TextStyle(color: Colors.green, fontSize: 20.0),
                  )
                ],
              ),

              // Delete a server info
              secondaryBackground: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    'Delete',
                    style: TextStyle(color: Colors.red, fontSize: 20.0),
                  ),
                ],
              ),

              // Build ListView
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Card(
                  color: Colors.cyanAccent,
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text(item['address']),
                    onTap: () {
                      Navigator.pop(context, item);
                    },
                  ),
                ),
              ));
        }
        //     confirmDismiss: (DismissDirection direction) async {
        //       if (direction == DismissDirection.startToEnd) {
        //         return false;
        //       } else if (direction == DismissDirection.endToStart) {
        //         return await showDialog(
        //           context: context,
        //           builder: (BuildContext context) => AlertDialog(
        //             title: const Text('Confirm'),
        //             content: const Text('Are you sure you wish to delete this item?'),
        //             actions: [
        //               TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
        //               TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Ok')),
        //             ],
        //           )
        //         );
        //       } else {
        //         return false;
        //       }
        //     },
        //     onDismissed: (DismissDirection direction) async {
        //       if (direction == DismissDirection.startToEnd) {} else {}
        //     },
        );
  }

  // This widget will be show when user have not added server yet
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

  // input form for add/edit server
  // void inputForm(BuildContext context) async {
  //
  // }
  Future<bool> _inputForm(context, {required bool isEditing, required Map info}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color.fromRGBO(0, 144, 255, 1.0),
        title: const Text(
          'Enter info',
          style: TextStyle(
            color: onPrimaryColor,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 190,
            vertical: 150,
          ),
          child: Form(
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: onPrimaryColor),
                    floatingLabelStyle: TextStyle(color: Colors.purple),
                  ),
                  onChanged: (name) {
                    info['name'] = name;
                  },
                  initialValue: info['name'],
                  textInputAction: TextInputAction.next,
                  maxLength: 15,
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
                    info['address'] = address;
                  },
                  initialValue: info['address'],
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
                    info['username'] = username;
                  },
                  initialValue: info['username'],
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
                    info['password'] = password;
                  },
                  initialValue: info['password'],
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () async {
              if (isEditing) {
                await widget.storage.editServer(info);
                await _loadServers();
                Navigator.of(context).pop(true);
              } else {
                await widget.storage.addServer(info);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    )
    .then((value) => true);
  }

  // Starting state
  @override
  void initState() {
    super.initState();
    _loadServers();
  }

  @override
  Widget build(BuildContext context) {
    // The Screen background
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.blue,
              Colors.deepPurple,
            ])),
        child: SafeArea(
          child: showInfo,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add_location_outlined,
          size: 30,
        ),
        onPressed: () async {
          // Map inputInfo = await _inputForm(context);
          // if (inputInfo.isNotEmpty) {
          //   await widget.storage.addServer(inputInfo);
          _loadServers();
          // }
        },
      ),
    );
  }
}
