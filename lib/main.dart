import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
  String humidity = '0';
  String temperature = '0';
  int waterlv = 0;
  Color waterColor = Colors.black;
  String watertext = "";
  bool manualValue = false;
  bool instructionValue = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final Future<FirebaseApp> _fapp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Super Ultrasonic Mist Maker',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      body: FutureBuilder(
          future: _fapp,
          builder: (context, snapshot) {
            return content();
          }),
    );
  }

  Widget content() {
    DatabaseReference humiditydb =
        FirebaseDatabase.instance.ref('humidity/value');
    DatabaseReference tempdb =
        FirebaseDatabase.instance.ref('temperature/value');
    DatabaseReference waterlvdb =
        FirebaseDatabase.instance.ref('waterlevel/value');
    DatabaseReference manualdb =
        FirebaseDatabase.instance.ref('manual');
    DatabaseReference instructiondb =
        FirebaseDatabase.instance.ref('instruction');
    humiditydb.onValue.listen((event) {
      setState(() {
        humidity = event.snapshot.value.toString();
      });
    });
    tempdb.onValue.listen((event) {
      setState(() {
        temperature = event.snapshot.value.toString();
      });
    });
    waterlvdb.onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      var value = dataSnapshot.value;
      if (value != null && value is num) {
        var floatValue = value.toDouble();
        if(floatValue < 25){
          watertext = "LOW";
          waterColor = Colors.red;
        }else{
          watertext = "HIGHT";
          waterColor = Colors.blue;
        }
      }
    });
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.asset('assets/image1.png').image,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 45),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      alignment: AlignmentDirectional(0, -0.3),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset('assets/waterlv.png').image,
                        ),
                      ),
                      child: Text(
                        '$watertext',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: waterColor),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Water Level',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[600])),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$humidity',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[600]),
                    ),
                    Text(
                      'Humidity (%)',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[600]),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '${temperature}',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[600]),
                    ),
                    Text(
                      'Temperature (°C)',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 45),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlidingSwitch(
                value: manualValue ??= false,
                height: 45,
                width: 180,
                colorOn: Color(0xFFFF0000),
                colorOff: Color(0xFFFF0000),
                onChanged: (newValue) async {
                  setState(() => manualValue = newValue!);
                  manualdb.update({"status":newValue?0:1});
                },
                onTap: (bool value) { 
                },
                onDoubleTap: (bool value) {},
                onSwipe: (bool value) {},
              ),
              SizedBox(height: 12),
              Text(
                'Manual Control',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[600]),
              ),
            ],
          ),
          SizedBox(height: 25),
          Visibility(
            visible: manualValue,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlidingSwitch(
                value: instructionValue ??= false,
                height: 45,
                width: 180,
                colorOn: Color(0xFFFF0000),
                colorOff: Color(0xFFFF0000),
                onChanged: (newValue) async {
                  setState(() => instructionValue = newValue!);
                  instructiondb.update({"status":newValue?0:1});
                },
                onTap: (bool value) { 
                },
                onDoubleTap: (bool value) {},
                onSwipe: (bool value) {},
              ),
              SizedBox(height: 12),
              Text(
                'Humidiity Control',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[600]),
              ),
            ],
          ),)
        ],
      ),
    );
  }
}
