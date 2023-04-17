import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sliding_switch/sliding_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool? switchValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  Color PrimaryBackgroundColor = Color(0xFF4B39EF);
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PrimaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: PrimaryBackgroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Super UltrasonicMistMaker',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          child: Container(
            width: 400,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/image.png',
                ).image,
              ),
              shape: BoxShape.rectangle,
            ),
            child: Align(
              alignment: AlignmentDirectional(0, -0.6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // CircularPercentIndicator(
                            //   percent: 0.7,
                            //   radius: 60,
                            //   lineWidth: 24,
                            //   animation: true,
                            //   progressColor: PrimaryBackgroundColor,
                            //   backgroundColor: Colors.white,
                            //   center: Text(
                            //     '50%',
                            //     style: TextStyle(
                            //       fontFamily: 'Poppins',
                            //       color: PrimaryBackgroundColor,
                            //     ),
                            //   ),
                            // ),
                            Stack(
                              alignment: AlignmentDirectional(0, -0.4),
                              children: [
                                Image.asset('assets/waterlv.png'),
                                Center(
                                    child: Text(
                                  "Medium",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'Poppins',
                                    color: PrimaryBackgroundColor,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Water Level',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '21',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Humidity(%)',
                            ),
                            SizedBox(height: 10),
                            Text(
                              '30',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Temperature (C)',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SlidingSwitch(
                        value: switchValue ??= true,
                        height: 50,
                        width: 150,
                        colorOn: Color(0xFFFF0000),
                        colorOff: Colors.white,
                        onChanged: (newValue) async {
                          setState(() => switchValue = newValue!);
                          print(switchValue);
                        },
                        onTap: (bool value) {
                          print(value);
                        },
                        onDoubleTap: (bool value) {},
                        onSwipe: (bool value) {},
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Humitity Control',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
