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

# Navigation

Basic Navigation:
Flutter uses a Navigator to manage a stack of pages (routes). Each route represents a screen in the app. The navigation system in Flutter is based on the Navigator widget.

Pushing a New Route:
To navigate to a new screen, you use the Navigator.push() method. Here's an example:

```
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen()),
);
```

MaterialPageRoute: This is the most commonly used route, which uses material design principles.

SecondScreen: This is the screen you want to navigate to.

Popping a Route:
To go back to the previous screen, you use Navigator.pop():

```
Navigator.pop(context);
```

Navigator.pop(context);

# Named Routes:

For better scalability and maintainability, you can define routes by name using Navigator.pushNamed() and Navigator.pop().

Defining Routes:
You define the routes in the MaterialApp widget like this:

```
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomeScreen(),
    '/second': (context) => SecondScreen(),
  },
);
```

Navigating to Named Routes:
To navigate to a named route:

```
Navigator.pushNamed(context, '/second');
```

#Bottom Navigation Bar:
For apps with multiple primary destinations, a bottom navigation bar is common. Flutter provides a BottomNavigationBar widget to switch between different screens.

```
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Navigation')),
      body: _currentIndex == 0 ? FirstScreen() : SecondScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

```

# GoRouter:

```
dependencies:
  go_router: ^5.0.0
```

import 'package:go_router/go_router.dart';

```
void main() {
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/second',
        builder: (context, state) => SecondScreen(),
      ),
    ],
  );

  runApp(MyApp(router: _router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  MyApp({required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
```

Navigating with GoRouter:
Instead of using Navigator.pushNamed(), you use context.go() or context.push():
// Navigating to a new route
context.go('/second');

// Navigating and keeping the current route in the stack
context.push('/second');

GoRouter for Nested Navigation:
GoRouter also supports nested navigation:

```
GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: 'second',
          builder: (context, state) => SecondScreen(),
        ),
      ],
    ),
  ],
);
```

# With FIrebase

```
dependencies:
  flutter:
    sdk: flutter
  firebase_core: latest_version
  firebase_auth: latest_version  # for authentication
  cloud_firestore: latest_version  # for Firestore database
  firebase_storage: latest_version  # for file storage
  # add other firebase packages as needed
```

Initialize

```
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      home: MyHomePage(),
    );
  }
}
```

Firebase Authentication: To authenticate users, use the firebase_auth package.

```
import 'package:firebase_auth/firebase_auth.dart';

Future<User?> signUp(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    print('Error: ${e.message}');
    return null;
  }
}
```

Firestore Database: To read and write to the Firestore database, use the cloud_firestore package.

```
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUser() async {
  await FirebaseFirestore.instance.collection('users').add({
    'name': 'John Doe',
    'email': 'john.doe@example.com',
  });
}
```

Firebase Storage: To upload and download files, use the firebase_storage package.

```
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Future<void> uploadFile(File file) async {
  try {
    await FirebaseStorage.instance
        .ref('uploads/${file.uri.pathSegments.last}')
        .putFile(file);
  } catch (e) {
    print('Error uploading file: $e');
  }
}
```
