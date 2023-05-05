import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final client = MqttServerClient( 'mqtt://172.20.10.12:1883', '3e59b01c-bcfc-488f-b6ab-953c1639c142');
  String message = '';

  @override
  void initState() {
    super.initState();

    client.logging(on: true);
    client.onConnected = onConnected;
  }

  Future<void> onConnected() async {
    print('Connected to MQTT server');
    client.connect("iotProject","12345678");
    await client.subscribe('dht', MqttQos.exactlyOnce);
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MQTT Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Message received:',
              ),
              Text(
                '$message',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    client.disconnect();
    super.dispose();
  }
}
