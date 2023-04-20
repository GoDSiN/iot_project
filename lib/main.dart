import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.blue[600], fontFamily: 'Poppins'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text('Super Ultrasonic Mist Maker',
            style: TextStyle(fontSize: 22),
          ),
        ),        
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset('assets/image1.png').image,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 55),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 170,
                        height: 170,
                        alignment: AlignmentDirectional(0, -0.3),
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
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset('assets/waterlv.png').image,
                          ),
                        ),
                        child: Text('MEDIUM',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.blue[600]),
                        ),
                      ),  
                      SizedBox(height: 15),
                      Text('Water Level',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue[600])
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('21',
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: Colors.blue[600]),
                      ),
                      Text('Humidity (%)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue[600]),
                      ),
                      SizedBox(height: 20),
                      Text('30',
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: Colors.blue[600]),
                      ),
                      Text('Temperature (°C)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue[600]),
                      ),
                    ],
                  ),
                ),            
              ],
            ),
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlidingSwitch(
                  value: switchValue ??= true,
                  height: 55,
                  width: 230,
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
                SizedBox(height: 15),
                Text('Humitity Control',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue[600]),  
                ),
              ],
            ), 
          ],
        ),
      ),
    );
  }
}
