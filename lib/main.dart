import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Flutter Hooks Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
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

class Counter extends StateNotifier<int?> {
  /// Constructor for [StateNotifier]
  Counter() : super(null);

  /// Increments value of [state]
  ///
  /// If [state] is null (initial state), sets [state] = 1
  /// otherwise, increases value of state by 1
  void increment() => state = state == null ? 1 : state + 1;
}

/// Creates a [StateNotifierProvider] based on our [Counter] class, which is
/// a [StateNotifier]
final counterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  /// [ref] provides a reference to our provider
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          /// There is a [ref] within the [Consumer] widget because this ref allows
          /// only the [Consumer] widget and its children to be rebuilt
          /// and not the entire [HomePage] and all its children as it is waste of resources
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final count = ref.watch(counterProvider);
            final text =
                count == null ? 'Press the button' : count.toString();
            return Center(child: Text(text));
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(

              /// ref.read() allows us to get a snapshot of the object which is passed
              /// which allows us to call the increment function.
              ///
              /// Since increment() is a void function, it can also be written as below
              onPressed: ref.read(counterProvider.notifier).increment,
              child: const Text('Increment Counter')),
        ],
      ),
    );
  }
}
