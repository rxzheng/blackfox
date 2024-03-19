import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.white,
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
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.timer, size: 20, color: Colors.white),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.checklist, size: 20, color: Colors.white),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: Icon(Icons.star, size: 20, color: Colors.white),
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
  int _seconds = 25 * 60; // 25 minutes converted to seconds
  Timer? _timer;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    int minutes = (_seconds / 60).truncate();
    int seconds = _seconds % 60;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$minutes:${seconds.toString().padLeft(2, '0')}',
            style: TextStyle(
                color: Colors.white, fontSize: 48), // Increased font size to 48
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // background color
              onPrimary: Colors.black, // foreground color
            ),
            onPressed: _toggleTimer,
            child: Text(_isRunning ? 'Stop' : 'Start',
                style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer!.cancel();
          _startBreakTimer(); // Start the break timer when Pomodoro timer ends
        }
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

  void _startBreakTimer() {
    setState(() {
      _seconds = 5 * 60; // 5 minutes break
      _isRunning = false;
    });
  }
}

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Todo List Page', style: TextStyle(color: Colors.white)),
    );
  }
}

class HabitTrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Habit Tracker Page', style: TextStyle(color: Colors.white)),
    );
  }
}
