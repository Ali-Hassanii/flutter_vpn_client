import 'package:flutter/material.dart';
import 'package:flutter_vpn_client/modules/home.dart';
import 'package:flutter_vpn_client/screens/location_menu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const Color onPrimaryColor = Colors.white60;
  bool useProxy = false;
  List<Color> containersColor = [
    const Color.fromRGBO(35, 176, 219, 1.0),
    const Color.fromRGBO(175, 79, 167, 1.0),
  ];

  String connectionStatus = 'Not Connected';

  // choose server to connecting
  late Map server;
  void _choseServer(BuildContext context) async {
    server = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationMenu()));
    setState(() {
      _serverName = server['name'];
    });
  }
  String _serverName = 'Choose a server';

  @override
  Widget build(BuildContext context) {
    // vpn (on/off) button
    Widget containerButton = OutlinedButton(
      onPressed: () => setState(() {
        if (containersColor[0] == const Color.fromRGBO(35, 176, 219, 1.0)) {
          // turn vpn on ( off --> on )
          connectionStatus = 'Connected';
          containersColor = [
            const Color.fromRGBO(48, 120, 232, 1.0),
            const Color.fromRGBO(0, 253, 25, 1.0),
          ];
        } else {
          // turn vpn off ( on --> off )
          connectionStatus = 'Not Connected';
          containersColor = [
            const Color.fromRGBO(35, 176, 219, 1.0),
            const Color.fromRGBO(175, 79, 167, 1.0),
          ];
        }
      }),
      child: const Icon(
        Icons.power_settings_new,
        size: 45,
        color: onPrimaryColor,
      ),
      style: OutlinedButton.styleFrom(
          fixedSize: const Size(75, 75), shape: const CircleBorder()),
    );

    List<CircularContainer> containersValue = [
      CircularContainer(250, containersColor, 0.2, null),
      CircularContainer(190, containersColor, 0.35, null),
      CircularContainer(130, containersColor, 0.5, null),
      CircularContainer(75, containersColor, 1, containerButton),
    ];

    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.deepPurple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 2),
              Row(
                children: [
                  const SizedBox(width: 15),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        size: 28,
                        color: onPrimaryColor,
                      )),
                  const SizedBox(width: 25),
                  const Text(
                    'VPN client',
                    style: TextStyle(fontSize: 20, color: onPrimaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              Text(
                connectionStatus,
                style: const TextStyle(
                  fontSize: 25,
                  color: onPrimaryColor,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  _choseServer(context);
                  if (server.isNotEmpty) {

                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.edit_location_rounded,
                      color: onPrimaryColor,
                    ),
                    Text(
                      _serverName,
                      style: const TextStyle(color: onPrimaryColor),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: onPrimaryColor,
                    ),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    fixedSize: const Size(220, 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    )),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.blue,
                        title: const Text(
                          'More Info',
                          style: TextStyle(
                            color: onPrimaryColor,
                          ),
                        ),
                        content: const Text(
                          'You can use vpn over socks5 proxy. '
                          'Means that it can just reach at '
                          '"socks5://127.0.0.1:1401" address.',
                          style: TextStyle(
                            color: onPrimaryColor,
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'Ok',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                          )
                        ],
                      )
                    ),
                    icon: const Icon(
                      Icons.info_outline,
                      color: onPrimaryColor,
                    ),
                  ),
                  const Text(
                    'Over Socks5 Proxy',
                    style: TextStyle(
                      fontSize: 18,
                      color: onPrimaryColor,
                    ),
                  ),
                  Switch(
                    value: useProxy,
                    onChanged: null,
                    activeColor: onPrimaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                  alignment: AlignmentDirectional.center,
                  children: containersValue
                      .map((value) => Opacity(
                            opacity: value.containerOpacity,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: value.containerSize,
                              height: value.containerSize,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: value.containerColors,
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: value.containerChild,
                            ),
                          ))
                      .toList()),
              const SizedBox(height: 20),
              Container(
                width: 300,
                height: 70,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.pink,
                          Color.fromRGBO(43, 117, 147, 1.0),
                          Colors.lightBlue
                        ])),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.attach_money,
                        size: 35,
                        color: onPrimaryColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Buy full version',
                            style: TextStyle(fontSize: 20, color: onPrimaryColor),
                          ),
                          Text(
                            'Fast and unlimited',
                            style: TextStyle(color: onPrimaryColor),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: onPrimaryColor,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
