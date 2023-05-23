import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Hooks Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.dark,
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}

/// This extension allows us to add a nullable number with another number.
///
/// final int? num1 = 1;
/// final int num2 = 1;
/// final int num3 = num1 + num2; -> Addition is now allowed
///
/// As long as the left hand side integer is not null, addition is allowed
///
/// [shadow] is the operand to the left of the addition symbol
/// [other] is the operand to the right of the addition symbol
extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
