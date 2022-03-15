import 'package:flutter/material.dart';
import 'package:flutter_vpn_client/modules/home.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget containerButton = OutlinedButton(
      onPressed: () => setState(() {
        if (containersColor[0] == const Color.fromRGBO(35, 176, 219, 1.0)) {
          containersColor = [
            const Color.fromRGBO(48, 120, 232, 1.0),
            const Color.fromRGBO(0, 253, 25, 1.0),
          ];
        } else {
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
        )),
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
            const Text(
              'Not Connected',
              style: TextStyle(
                fontSize: 25,
                color: onPrimaryColor,
              ),
            ),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/LocationMenu'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.edit_location_rounded,
                    color: onPrimaryColor,
                  ),
                  Text(
                    'Change Location',
                    style: TextStyle(color: onPrimaryColor),
                  ),
                  Icon(
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
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.info_outline,
                    color: onPrimaryColor,
                  ),
                ),
                const Text(
                  'Just for telegram',
                  style: TextStyle(
                    fontSize: 18,
                    color: onPrimaryColor,
                  ),
                ),
                Switch(
                  value: useProxy,
                  onChanged: (value) => setState(() {
                    useProxy = value;
                  }),
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
      )
    );
  }
}
