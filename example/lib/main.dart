import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9FB373),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 100.0),
        children: [
          Center(
              child: SizedBox(
            height: 400.0,
            width: 290.0,
            child: Stack(
              children: [
                Positioned(
                  top: 23.0,
                  right: 23.0,
                  left: 23.0,
                  bottom: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: ExpandableMenu(
                      width: 46.0,
                      height: 46.0,
                      items: [
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                      ],
                    )),
              ],
            ),
          )),
          const SizedBox(
            height: 40,
          ),
          Center(
              child: SizedBox(
            height: 200.0,
            width: 200.0,
            child: Stack(
              children: [
                Positioned(
                  top: 20.0,
                  right: 20.0,
                  left: 20.0,
                  bottom: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: ExpandableMenu(
                      width: 40.0,
                      height: 40.0,
                      items: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.access_alarm,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.accessible_forward,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.accessibility_new_sharp,
                          color: Colors.white,
                        ),
                      ],
                    )),
              ],
            ),
          )),
          const SizedBox(
            height: 40,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                height: 200.0,
                child: Stack(
                  children: [
                    Positioned(
                      top: 20.0,
                      right: 20.0,
                      left: 20.0,
                      bottom: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: ExpandableMenu(
                          width: 40.0,
                          height: 40.0,
                          backgroundColor: Colors.black,
                          iconColor: Colors.amber,
                          itemContainerColor: Colors.amber,
                          items: [
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                          ],
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
