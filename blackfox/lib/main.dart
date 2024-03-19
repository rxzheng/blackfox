import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blackfox',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black, // Set background color to black
        primaryColor: Colors.white, // Set primary color to white
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PomodoroTimerPage(),
    TodoListPage(),
    HabitTrackerPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 1), // Adjust horizontal padding
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Adjust spacing between icons
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.timer,
                  size: 20, color: Colors.white), // Set color to white
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.checklist,
                  size: 20, color: Colors.white), // Set color to white
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: Icon(Icons.star,
                  size: 20, color: Colors.white), // Set color to white
              onPressed: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}

class PomodoroTimerPage extends StatefulWidget {
  @override
  _PomodoroTimerPageState createState() => _PomodoroTimerPageState();
}

class _PomodoroTimerPageState extends State<PomodoroTimerPage> {
  int _seconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_seconds',
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isRunning ? null : _startTimer,
                child: Text('Start'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _stopTimer,
                child: Text('Stop'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }
}

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Todo List Page',
          style: TextStyle(color: Colors.white)), // Set text color to white
    );
  }
}

class HabitTrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Habit Tracker Page',
          style: TextStyle(color: Colors.white)), // Set text color to white
    );
  }
}
