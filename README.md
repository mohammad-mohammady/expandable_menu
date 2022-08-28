# expandable_menu

Expandable menu is an expandable menu with infinite horizontal item list with high customizable ability.

### Preview
<img src="https://user-images.githubusercontent.com/32927238/187061783-8cf2d8d1-aea6-46e9-aac7-ec920d0beb6d.png" width="32%" height="422px">
<br>
<img src="https://user-images.githubusercontent.com/32927238/187061970-0d3241bd-60b4-4b4a-8810-69fc30d60958.gif" width="32%" height="422px">



| Property | Description |
| --- | --- |
| `width` | This property declare width of widget when it's not expanded in initial state |
| `height` | This property declare height of widget |
| `items` | This property will contains items in list of menu |
| `backgroundColor` | This property declare background color of widget and default value is [Color(0xFF4B5042)] |
| `iconColor` | This property declare icon color of both icon(Arrow icon and Hamburger icon) |
| `itemContainerColor` | This property declare item background color and if it's be null default value is [Colors.white.withOpacity(.4)] |



Usage
-----

```dart
import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';

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


```
