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
        primaryColor: const Color.fromARGB(255, 0, 0, 0),
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
              color: Colors.white,
              fontSize: 48,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
            ),
            onPressed: _toggleTimer,
            child: Text(
              _isRunning ? 'Stop' : 'Start',
              style: TextStyle(color: Colors.black),
            ),
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
          _startBreakTimer();
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
      _seconds = 5 * 60;
      _isRunning = false;
    });
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _tasks = [];

  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
    _controller.clear();
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            style: TextStyle(color: Colors.white), // Set text color to white
            onSubmitted: (String value) {
              _addTask(value);
            },
            decoration: InputDecoration(
              hintText: 'Enter a task',
              contentPadding: EdgeInsets.all(16.0),
              filled: true,
              fillColor: const Color.fromARGB(255, 0, 0, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: false,
                    onChanged: (bool? checked) {
                      if (checked != null && checked) {
                        _removeTask(index);
                      }
                    },
                  ),
                  title: Text(
                    _tasks[index],
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HabitTrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Habit Tracker Page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
