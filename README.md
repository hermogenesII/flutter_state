# my_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# add notes

ChangeNotifier = reactive data (like useState() or a Redux store).

notifyListeners() = "Hey UI, something changed!"

context.watch() = "I care about this value, rebuild me when it changes."

context.read() = "I just wanna call a function — don’t rebuild me."

Ephemeral State
"State that only matters to a single widget or part of a screen, and doesn’t need to be shared."

App State
"State that needs to be shared across widgets, screens, or parts of the app."
Provider, Riverpod, Bloc, GetX etc.

Example

RiverPod

```
final counterProvider = StateProvider<int>((ref) => 0);

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  Widget build(BuildContext context) {
    final counter = useProvider(counterProvider);
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Count: ${counter.state}')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.state++,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

Cubit

```
// counter_cubit.dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
}

// main.dart
void main() {
  runApp(
    BlocProvider(
      create: (_) => CounterCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: BlocBuilder<CounterCubit, int>(
            builder: (context, count) => Text('Count: $count'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().increment(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

```
