import 'package:flutter/material.dart';

void main() {
  runApp(
  );
}

//stateless is the data in the thing is immutable (doesn't change)
//stateful is if it has data that changes (such as a counter)
class MyApp extends StatelessWidget {
  const MyApp({String?data}): super.(data);
  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello World',
    textDirection: TextDirection.ltr,
    )
  }
}
