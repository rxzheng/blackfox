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
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white), // Set text color to white
              onSubmitted: (String value) {
                _addTask(value);
              },
              decoration: InputDecoration(
                hintText: 'Enter a task',
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0), // Adjust padding here
                filled: true,
                fillColor: const Color.fromARGB(255, 0, 0, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
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

class HabitTrackerPage extends StatefulWidget {
  @override
  _HabitTrackerPageState createState() => _HabitTrackerPageState();
}

class _HabitTrackerPageState extends State<HabitTrackerPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _habits = [];
  List<bool> _checkedHabits = [];
  List<int> _streakCount = [];

  void _addHabit(String habit) {
    setState(() {
      _habits.add(habit);
      _checkedHabits.add(false);
      _streakCount.add(0);
    });
    _controller.clear();
  }

  void _removeHabit(int index) {
    setState(() {
      _habits.removeAt(index);
      _checkedHabits.removeAt(index);
      _streakCount.removeAt(index);
    });
  }

  void _incrementStreak(int index) {
    setState(() {
      _streakCount[index]++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                  onSubmitted: (String value) {
                    _addHabit(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter a habit',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0), // Adjust padding here
                    filled: true,
                    fillColor: const Color.fromARGB(255, 0, 0, 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _habits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        'Streak: ${_streakCount[index]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        _habits[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  trailing: Checkbox(
                    value: _checkedHabits[index],
                    onChanged: (newValue) {
                      setState(() {
                        _checkedHabits[index] = newValue!;
                        if (newValue) {
                          _incrementStreak(index);
                        }
                      });
                    },
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.white;
                      }
                      return Colors
                          .transparent; // Use transparent color as unchecked
                    }),
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
