import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _haveStarted3Times = ''; 

  @override
  void initState() {
    super.initState();
    _incrementStartup();
  }

  Future<int> _getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startupNumber = prefs.getInt('startupNumber');
    if ( startupNumber == null ) {
      return 0;
    }
    return startupNumber;
  }

  Future<void> _resetCounter()  async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('startupNumber', 0);
  }

  Future<void> _incrementStartup()  async {
    final prefs = await SharedPreferences.getInstance();
    int lastStartupNumber = await _getIntFromSharedPref();
    int currentStartupNumber = ++lastStartupNumber;

    await prefs.setInt('startupNumber', currentStartupNumber);


      setState(() {
        _haveStarted3Times = 'app loaded ' + currentStartupNumber.toString() + ' times';
      });
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            _haveStarted3Times,
            style: TextStyle(
              fontSize: 32
            ),
          ),
        ),
      ),
    );
  }
}


